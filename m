Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbSJHNyt>; Tue, 8 Oct 2002 09:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263237AbSJHNyU>; Tue, 8 Oct 2002 09:54:20 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:60820 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263232AbSJHNwu>;
	Tue, 8 Oct 2002 09:52:50 -0400
Date: Tue, 8 Oct 2002 15:58:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Minor m68k cleanups [17/23]
Message-ID: <20021008155825.P18546@ucw.cz>
References: <20021008154549.F18546@ucw.cz> <20021008154631.G18546@ucw.cz> <20021008154733.H18546@ucw.cz> <20021008154824.I18546@ucw.cz> <20021008154904.J18546@ucw.cz> <20021008155003.K18546@ucw.cz> <20021008155045.L18546@ucw.cz> <20021008155125.M18546@ucw.cz> <20021008155236.N18546@ucw.cz> <20021008155651.O18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008155651.O18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:56:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.51, 2002-10-07 10:39:47+02:00, geert@linux-m68k.org
  Please apply this small clean up, too:
  
    - Kill unused variable and end-of-line whitespace.
    - s/M68K/M68k/


 Config.in  |    2 +-
 m68kspkr.c |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

===================================================================

diff -Nru a/drivers/input/misc/Config.in b/drivers/input/misc/Config.in
--- a/drivers/input/misc/Config.in	Tue Oct  8 15:25:46 2002
+++ b/drivers/input/misc/Config.in	Tue Oct  8 15:25:46 2002
@@ -9,6 +9,6 @@
    dep_tristate '  SPARC Speaker support' CONFIG_INPUT_SPARCSPKR $CONFIG_INPUT $CONFIG_INPUT_MISC
 fi
 if [ "$CONFIG_M68K" = "y" ]; then
-dep_tristate '  M68K Beeper support' CONFIG_INPUT_M68K_BEEP $CONFIG_INPUT $CONFIG_INPUT_MISC
+dep_tristate '  M68k Beeper support' CONFIG_INPUT_M68K_BEEP $CONFIG_INPUT $CONFIG_INPUT_MISC
 fi
 dep_tristate '  User level driver support' CONFIG_INPUT_UINPUT $CONFIG_INPUT $CONFIG_INPUT_MISC
diff -Nru a/drivers/input/misc/m68kspkr.c b/drivers/input/misc/m68kspkr.c
--- a/drivers/input/misc/m68kspkr.c	Tue Oct  8 15:25:46 2002
+++ b/drivers/input/misc/m68kspkr.c	Tue Oct  8 15:25:46 2002
@@ -31,7 +31,6 @@
 static int m68kspkr_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	unsigned int count = 0;
-	unsigned long flags;
 
 	if (type != EV_SND)
 		return -1;
@@ -40,11 +39,11 @@
 		case SND_BELL: if (value) value = 1000;
 		case SND_TONE: break;
 		default: return -1;
-	} 
+	}
 
 	if (value > 20 && value < 32767)
 		count = 1193182 / value;
-	
+
 	mach_beep(count, -1);
 
 	return 0;

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.51
## Wrapped with gzip_uu ##


begin 664 bkpatch18009
M'XL(`-K<HCT``[5574_;,!1];G[%E9C$`TMB.\ZGU(E1&*L84,%XFU2YCMMD
M39,H=LI`V7^?TU8M=,"`06)=Z?KC^OB>>^P=N)*BBCKSXJ<2/#%VX&LA5=21
MM106O]7^15%HWTZ*F;!7L^S1U$[SLE:&'A\PQ1.8BTI&'6PYZQYU4XJH<W%T
M?/7M\X5A=+O02U@^$9="0;=KJ**:LRR6^TPE69%;JF*YG`G%+%[,FO74AB!$
M].]BWT&NUV`/4;_A.,:842QB1&C@46,%;'\%>VL]1LA'@4.QVQ#JA=@X!&RY
MOF-IBP$1&R,;^8!1Y(01]?<0B1""B1"5VL_2O/YESKQ@:A75!/8(F,@X@+>%
MWS,X##+!I`!6EMD-J"25(&<LRX#K_ASJ\J/>LXCT1-T`3#A)]6"=ZP/',&=5
MRD:97IW'(/+8+,:F!B[@.DF5D"7CPEHMD_:I%YRT9FH;)T!<HO,QV'!CF"_\
M#`,Q9'R"ZG8K5TU<I6U9+$O%GJ62V^V8+*>5Q9>9"8FCJ7%=U'@T<)R&^80[
MXW#LA"%#B/('27A&X!7C(:4-(;[?XMLND0>"](I\G$ZL-%^""XB+'8)QT+C$
M0T$3!'C,4!#XWMCA)*#/!G<_[AULE+B(++3QY)%:O;Q+>O\O*M9J\OVEFLA?
M,J+_DI'S+C(Z3?.B6HJF+JVVPA?\GX-972^:KMC!T^E^A00.'0HZ$=31MK^P
MG=_:]1=N:W\\QO*Z-EJ2W[Y&G\?P5M!-V5#-,%I>ER\D&(.)WX=@O04<"%&*
M2M^*,5.B97FII`W+UX^PO#[I:TC&I.5S86-1#E652J7WAUVXATK695E4:A=Z
MYV=?^L?#_MG@ZONPO7:'!T='`_APM_^^-SSM7_8VKRI/!)_*>M;E(R)(.!X9
*?P"E9[?1L`<`````
`
end
