Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbSKOILm>; Fri, 15 Nov 2002 03:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbSKOIKk>; Fri, 15 Nov 2002 03:10:40 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:59265 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265995AbSKOIJ0>;
	Fri, 15 Nov 2002 03:09:26 -0500
Date: Fri, 15 Nov 2002 09:16:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Add defaults for ATKBD et al [11/13]
Message-ID: <20021115091613.J16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz> <20021115090922.A16779@ucw.cz> <20021115091011.B16779@ucw.cz> <20021115091119.C16779@ucw.cz> <20021115091214.D16779@ucw.cz> <20021115091247.E16779@ucw.cz> <20021115091347.F16779@ucw.cz> <20021115091422.G16779@ucw.cz> <20021115091448.H16779@ucw.cz> <20021115091532.I16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091532.I16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:15:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.798.1.4, 2002-11-09 11:42:07+01:00, pasky@ucw.cz
  Add defaults for the most needed keyboard/mouse options.


 Kconfig          |    2 ++
 keyboard/Kconfig |    2 ++
 mouse/Kconfig    |    2 ++
 serio/Kconfig    |    3 +++
 4 files changed, 9 insertions(+)

===================================================================

diff -Nru a/drivers/input/Kconfig b/drivers/input/Kconfig
--- a/drivers/input/Kconfig	Fri Nov 15 08:30:39 2002
+++ b/drivers/input/Kconfig	Fri Nov 15 08:30:39 2002
@@ -28,6 +28,7 @@
 
 config INPUT_MOUSEDEV
 	tristate "Mouse interface"
+	default y
 	depends on INPUT
 	---help---
 	  Say Y here if you want your mouse to be accessible as char devices
@@ -45,6 +46,7 @@
 
 config INPUT_MOUSEDEV_PSAUX
 	bool "Provide legacy /dev/psaux device"
+	default y
 	depends on INPUT_MOUSEDEV
 
 config INPUT_MOUSEDEV_SCREEN_X
diff -Nru a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
--- a/drivers/input/keyboard/Kconfig	Fri Nov 15 08:30:39 2002
+++ b/drivers/input/keyboard/Kconfig	Fri Nov 15 08:30:39 2002
@@ -3,6 +3,7 @@
 #
 config INPUT_KEYBOARD
 	bool "Keyboards"
+	default y
 	depends on INPUT
 	help
 	  Say Y here, and a list of supported keyboards will be displayed.
@@ -12,6 +13,7 @@
 
 config KEYBOARD_ATKBD
 	tristate "AT keyboard support"
+	default y
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	---help---
 	  Say Y here if you want to use the standard AT keyboard. Usually
diff -Nru a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
--- a/drivers/input/mouse/Kconfig	Fri Nov 15 08:30:39 2002
+++ b/drivers/input/mouse/Kconfig	Fri Nov 15 08:30:39 2002
@@ -3,6 +3,7 @@
 #
 config INPUT_MOUSE
 	bool "Mice"
+	default y
 	depends on INPUT
 	help
 	  Say Y here, and a list of supported mice will be displayed.
@@ -12,6 +13,7 @@
 
 config MOUSE_PS2
 	tristate "PS/2 mouse"
+	default y
 	depends on INPUT && INPUT_MOUSE && SERIO
 	---help---
 	  Say Y here if you have a PS/2 mouse connected to your system. This
diff -Nru a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
--- a/drivers/input/serio/Kconfig	Fri Nov 15 08:30:39 2002
+++ b/drivers/input/serio/Kconfig	Fri Nov 15 08:30:39 2002
@@ -3,6 +3,7 @@
 #
 config SERIO
 	tristate "Serial i/o support"
+	default y
 	---help---
 	  Say Yes here if you have any input device that uses serial I/O to
 	  communicate with the system. This includes the 
@@ -19,6 +20,7 @@
 
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller"
+	default y
 	depends on SERIO
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
@@ -34,6 +36,7 @@
 
 config SERIO_SERPORT
 	tristate "Serial port line discipline"
+	default y
 	depends on SERIO
 	---help---
 	  Say Y here if you plan to use an input device (mouse, joystick,

===================================================================

This BitKeeper patch contains the following changesets:
1.798.1.4
## Wrapped with gzip_uu ##


begin 664 bkpatch16292
M'XL(`)^BU#T``]6776_:,!2&K_&OL-3+BL1?<1(D)KINVJI.6M6I5],NC&V:
M+!]FB6E'E1\_%_JQ4*`-8E,+W-A$)V_>\_`><P`O:ET->E?FI]4R`0?PLZGM
MH%?/:NW)&[<^-\:M_<04VK^[RA]G?EI.9Q:X[\^$E0F\TE4]Z&&//NS8^50/
M>N<?/UU\.3H'8#B$QXDH+_4W;>%P"*RIKD2NZI&P26Y*SU:BK`MMA2=-T3Q<
MVA"$B'L'.*0HX`WFB(6-Q`ICP;!6B+"(,U"DF<A'M4WS//FUI@+&*,8((<K<
M,D01^`"Q%\:1AST&$?$Q]E$,,1XP,D#A(<(#A.!4U-E\-)/7S@AXR&`?@?=P
MO[J/@81'2D&E)V*6VQI.3`5MHF'AN@!+K956,-/SL1&5\@OCN@+-U*:FK#UP
M"C$C803.'IT%_8XO`)!`X!V\2:=3G8_RM)S][A<\RCQ377Z_?]@?C:K2VQ8O
MV[X4XI]*4T[2RZ7!B"+$*"%10V(<!0U6@JJ`19,@CL=R0EMN/E]NT2_F'&QH
M%+"XL\('SS:)C"@C31QKIHD4@>*AX`1O$[F^XE\Z"7(-[:ISDSS."6ND&'.B
M@K%B*)(DW.KA!E4L#BCMK,I%0FHV]Y>CN(D8CC@=4Q*&B$M$MFE;4^Y184!H
M3!?YL/:!;K/B'UJZC]IQPYP)X2)3R),T(6O3A+S"-%FR\A7VJ^O%QZ7#V?JF
M[!`S)Q1!#'IWTN`<G+"PO?$4@=6?7'<6=HN!O=XD;B@B-'KS="SS;2L=JT;L
M@DFP0@EFSU'2FA[=$=EAEH&JR$835]]ZHBJ\Q8UN[^'-LI=,-NY.(H$[B5`>
M$KK@@KYE+A;S>2L7+1?^#Q2MD=,=BAT&X,NA6#L.'12$!I$;V#Q@G:"@KQ"*
KY5#?"D7+A7U`X8YO[0W*5RBY_VLB$RVS>E8,N1P'FD\$^`/SW1!'!PT`````
`
end
