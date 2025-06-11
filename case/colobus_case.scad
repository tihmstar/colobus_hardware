

CASE_LEN=60;
CASE_WIDTH=33;
CASE_THICKNESS=1.5;
CASE_HEIGHT=10;

CASE_LID_HEIGHT=2.5;
CASE_PIN_HEIGHT=6;
CASE_BUTTON_RADIUS=4.5/2;
CASE_LED_RADIUS=4/2;


BOARD_HEIGHT=2;
BOARD_LEN=50.5;
BOARD_WIDTH=29.5;
BOARD_MOUNTHOLE_RADIUS = 2.1/2;

USB_PORT_WIDTH=10;
USB_PORT_HEIGHT=3.5;

CABLE_DIAMETER=4;

w_space = CASE_WIDTH-BOARD_WIDTH;
indent_fill_len = CASE_LEN/2;

module board(){
    color("green")
    difference(){
        cube([BOARD_LEN,BOARD_WIDTH,BOARD_HEIGHT]);

        //holes
        translate([2.5,2.5,-1]) cylinder(10, BOARD_MOUNTHOLE_RADIUS, BOARD_MOUNTHOLE_RADIUS);
        translate([2.5,29.5-2.5,-1]) cylinder(10, BOARD_MOUNTHOLE_RADIUS, BOARD_MOUNTHOLE_RADIUS);
        translate([40.75,2.5,-1]) cylinder(10, BOARD_MOUNTHOLE_RADIUS, BOARD_MOUNTHOLE_RADIUS);
        translate([40.75,29.5-2.5,-1]) cylinder(10, BOARD_MOUNTHOLE_RADIUS, BOARD_MOUNTHOLE_RADIUS);                
    }
    
    color("pink"){
        cut_height = 5;
        //LEDs
        translate([BOARD_LEN-7.75,8.5,-1]) cylinder(cut_height, BOARD_LED_RADIUS, BOARD_LED_RADIUS);
        translate([BOARD_LEN-7.75,8.5+6.875,-1]) cylinder(cut_height, BOARD_LED_RADIUS, BOARD_LED_RADIUS);
        translate([BOARD_LEN-7.75,8.5+6.875*2,-1]) cylinder(cut_height, BOARD_LED_RADIUS, BOARD_LED_RADIUS);

/*        
        //Buttons
        translate([BOARD_LEN-16.55,BOARD_WIDTH-7.25,-1]) cylinder(cut_height, BOARD_BUTTON_RADIUS, BOARD_BUTTON_RADIUS);
        translate([BOARD_LEN-16.55,BOARD_WIDTH-7.25*2,-1]) cylinder(cut_height, BOARD_BUTTON_RADIUS, BOARD_BUTTON_RADIUS);
        translate([BOARD_LEN-16.55,BOARD_WIDTH-7.25*3,-1]) cylinder(cut_height, BOARD_BUTTON_RADIUS, BOARD_BUTTON_RADIUS);
*/
        
        //USB port
        translate([0,14.75-(USB_PORT_WIDTH/2),2]) cube([7.5,USB_PORT_WIDTH,USB_PORT_HEIGHT]);    
    
        //SWD port
        translate([20-8,BOARD_WIDTH-2.5-1.5,0]) cube([8,2.5, cut_height]);
    }
}


module box_bottom(){
    difference(){
        translate([-CASE_THICKNESS,-w_space/2,0]){
            cube([CASE_LEN,CASE_WIDTH,CASE_THICKNESS]);

            //pins
            color("red")
            translate([CASE_THICKNESS,1.8,0]){
                translate([2.5,2.5,0]) cylinder(CASE_PIN_HEIGHT, BOARD_MOUNTHOLE_RADIUS, BOARD_MOUNTHOLE_RADIUS);
                translate([2.5,29.5-2.5,0]) cylinder(CASE_PIN_HEIGHT, BOARD_MOUNTHOLE_RADIUS, BOARD_MOUNTHOLE_RADIUS);

                translate([40.75,2.5,0]) cylinder(CASE_PIN_HEIGHT, BOARD_MOUNTHOLE_RADIUS, BOARD_MOUNTHOLE_RADIUS);
                translate([40.75,29.5-2.5,0]) cylinder(CASE_PIN_HEIGHT, BOARD_MOUNTHOLE_RADIUS, BOARD_MOUNTHOLE_RADIUS);        
            }
            
            //walls
            color("blue"){
                //wall USB
                translate([0,0,0])
                    difference(){
                        cube([CASE_THICKNESS,CASE_WIDTH,CASE_HEIGHT]);

                        translate([-10,CASE_WIDTH/2-USB_PORT_WIDTH/2,CASE_THICKNESS+BOARD_HEIGHT])
                            cube([100,USB_PORT_WIDTH,USB_PORT_HEIGHT]);
                    }
                //wall back
                translate([CASE_LEN-CASE_THICKNESS,0,0])
                    difference(){
                        cube([CASE_THICKNESS,CASE_WIDTH,CASE_HEIGHT]);
                        
                        translate([-10,CASE_WIDTH/2-CABLE_DIAMETER/2,CASE_THICKNESS])
                            cube([100,CABLE_DIAMETER,100]);
                        
                    }


                //wall right
                translate([0,0,0])
                    cube([CASE_LEN,CASE_THICKNESS,CASE_HEIGHT]);
                //wall left
                translate([0,CASE_WIDTH-CASE_THICKNESS,0])
                    cube([CASE_LEN,CASE_THICKNESS,CASE_HEIGHT]);
            }
        }
        
        //lid indent
        translate([CASE_LEN/4,-0.5,CASE_HEIGHT-2]) cube([CASE_LEN/2,CASE_WIDTH-2*CASE_THICKNESS+1,1]);
    }
}


module box_top(){
    difference(){
        translate([-CASE_THICKNESS,-w_space/2,0]){
            color("grey")
            cube([CASE_LEN,CASE_WIDTH,CASE_THICKNESS]);
            
            //cable filler pin
            pinheight=CASE_HEIGHT-CASE_THICKNESS-CABLE_DIAMETER;
            color("brown")
            translate([CASE_LEN-CASE_THICKNESS,CASE_WIDTH/2-CABLE_DIAMETER/2,-pinheight])
            cube([CASE_THICKNESS,CABLE_DIAMETER,pinheight]);

        }        
        cut_height = 10;

        //LED cutouts
        translate([BOARD_LEN-7.75,8.5,-1])  cylinder(cut_height, CASE_LED_RADIUS, CASE_LED_RADIUS);
        translate([BOARD_LEN-7.75,8.5+6.875,-1]) cylinder(cut_height, CASE_LED_RADIUS, CASE_LED_RADIUS);
        translate([BOARD_LEN-7.75,8.5+6.875*2,-1]) cylinder(cut_height, CASE_LED_RADIUS, CASE_LED_RADIUS);
        
        //Buttons
        translate([BOARD_LEN-16.55,BOARD_WIDTH-7,-1]) cylinder(cut_height, CASE_BUTTON_RADIUS, CASE_BUTTON_RADIUS);
        translate([BOARD_LEN-16.55,BOARD_WIDTH-14,-1]) cylinder(cut_height, CASE_BUTTON_RADIUS, CASE_BUTTON_RADIUS);
        translate([BOARD_LEN-16.55,BOARD_WIDTH-21.2,-1]) cylinder(cut_height, CASE_BUTTON_RADIUS, CASE_BUTTON_RADIUS);
        
        //SWD Port
//        translate([20-8,BOARD_WIDTH-2.5-1.5,-1]) cube([8,3,cut_height]);

        //text
        color("orange")         
        rotate([0,0,180]){
            translate([-42,-5,1]) linear_extrude(height=1) text("colobus cable", size=5, direction="ltr");            

            translate([-28,CASE_THICKNESS-12,1]) linear_extrude(height=1) text("SWD", size=5, direction="ltr");            
            translate([-28,CASE_THICKNESS-10.5-8,1]) linear_extrude(height=1) text("Reset", size=5, direction="ltr");            
            translate([-28,CASE_THICKNESS-10.5-15,1]) linear_extrude(height=1) text("DFU", size=5, direction="ltr");            
        }
    }

    translate([0,-w_space/2+CASE_THICKNESS,-CASE_LID_HEIGHT]){
        difference(){
            color("orange")
            cube([CASE_LEN-CASE_THICKNESS*2,CASE_WIDTH-2*CASE_THICKNESS,CASE_LID_HEIGHT]);

            translate([1,1,-2])
                cube([CASE_LEN-CASE_THICKNESS*2-2,CASE_WIDTH-2*CASE_THICKNESS-2,CASE_LID_HEIGHT+10]);

            //cutouts side
            translate([CASE_LEN/8,-5,-1]) cube([1,CASE_WIDTH+10,CASE_LID_HEIGHT+10]);
            translate([CASE_LEN-4-CASE_LEN/8,-5,-1]) cube([1,CASE_WIDTH+10,CASE_LID_HEIGHT+10]);

            //cutouts USB
            translate([-3,(BOARD_WIDTH+0.5)/2-(USB_PORT_WIDTH+1)/2,-1]) cube([6,USB_PORT_WIDTH+1,CASE_LID_HEIGHT+10]);


        }        
        
        /*
        //indent fill 1
        translate([CASE_LEN/2-indent_fill_len/2,0,1])
        rotate([0,90,0])
        rotate([0,0,30])
        cylinder(indent_fill_len,1,1,$fn=3);
        */
        
        //indent fill 2
        translate([CASE_LEN/2-indent_fill_len/2,CASE_WIDTH-CASE_THICKNESS*2,1])
        rotate([0,90,0])
        rotate([0,0,30+180])
        cylinder(indent_fill_len,1,1,$fn=3);
    }
 }

//board();

//translate([0,0,-CASE_THICKNESS]) box_bottom();

translate([0,0,-CASE_THICKNESS+CASE_HEIGHT]) box_top();






