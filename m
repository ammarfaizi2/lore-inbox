Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319566AbSIMJEY>; Fri, 13 Sep 2002 05:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319567AbSIMJEY>; Fri, 13 Sep 2002 05:04:24 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:20113 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319566AbSIMJEV>;
	Fri, 13 Sep 2002 05:04:21 -0400
Date: Fri, 13 Sep 2002 11:06:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Minor input fixes [3/7]
Message-ID: <20020913110641.C28378@ucw.cz>
References: <20020913110453.A28145@ucw.cz> <20020913110600.B28378@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020913110600.B28378@ucw.cz>; from vojtech@suse.cz on Fri, Sep 13, 2002 at 11:06:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.568.6.2, 2002-09-04 23:10:46+03:00, johann.deneux@it.uu.se
  A small documentation update and a unused constant removal.


 Documentation/input/ff.txt   |    7 +++++--
 drivers/usb/input/hid-lgff.c |    3 ---
 2 files changed, 5 insertions(+), 5 deletions(-)

===================================================================

diff -Nru a/Documentation/input/ff.txt b/Documentation/input/ff.txt
--- a/Documentation/input/ff.txt	Thu Sep 12 23:37:44 2002
+++ b/Documentation/input/ff.txt	Thu Sep 12 23:37:44 2002
@@ -1,7 +1,7 @@
 Force feedback for Linux.
 By Johann Deneux <deneux@ifrance.com> on 2001/04/22.
-You can redistribute this file, provided you include shape.fig and
-interactive.fig.
+You may redistribute this file. Please remember to include shape.fig and
+interactive.fig as well.
 ----------------------------------------------------------------------------
 
 0. Introduction
@@ -90,12 +90,14 @@
 - FF_Y		has an Y axis (usually joysticks)
 - FF_WHEEL	has a wheel (usually sterring wheels)
 - FF_CONSTANT	can render constant force effects
-- FF_PERIODIC	can render periodic effects (sine, ramp, square...)
+- FF_PERIODIC	can render periodic effects (sine, triangle, square...)
+- FF_RAMP       can render ramp effects
 - FF_SPRING	can simulate the presence of a spring
 - FF_FRICTION	can simulate friction 
 - FF_DAMPER	can simulate damper effects
 - FF_RUMBLE	rumble effects (normally the only effect supported by rumble
 		pads)
+- FF_INERTIA    can simulate inertia
 
 
 int ioctl(int fd, EVIOCGEFFECTS, int *n);
diff -Nru a/drivers/usb/input/hid-lgff.c b/drivers/usb/input/hid-lgff.c
--- a/drivers/usb/input/hid-lgff.c	Thu Sep 12 23:37:44 2002
+++ b/drivers/usb/input/hid-lgff.c	Thu Sep 12 23:37:44 2002
@@ -45,9 +45,6 @@
 
 #define RUN_AT(t) (jiffies + (t))
 
-/* Transmition state */
-#define XMIT_RUNNING 0
-
 /* Effect status */
 #define EFFECT_STARTED 0     /* Effect is going to play after some time
 				(ff_replay.delay) */

===================================================================

This BitKeeper patch contains the following changesets:
1.568.6.2
## Wrapped with gzip_uu ##


begin 664 bkpatch25221
M'XL(`"@)@3T``[56;6_;-A#^;/Z*`_IE0VN9I%YM($.R)&V-K:GA)L#V*:"E
ML\54+RY)Q<W@'[^C[#1!L"1=M\B28?'EN>-S]]SY%5Q8-)/!=7OE,"_9*WC?
M6C<9V,YBD/]%[_.VI?=1V=8XVJ\:+3Z/=+/N'*/YF7)Y"==H[&0@@O#;B+M9
MXV0P/WUW\?O1G+&#`S@N5;/"3^C@X("YUERKJK"'RI55VP3.J,;6Z%20M_7V
MV]*MY%S2)Q9IR.-D*Q(>I=M<%$*H2&#!990E$=L[=KAW^^'^,3V9E%)LY3@*
M0W8"(HB3+$@""5R.^'C$(Y#A1/!)E+SFX81SN&H)HPD*;+#[>JA=T'6!17@M
M8<C9K_#_^G_,<C@"6ZNJ@J+-NQH;IYQN&^C6A7((JBE`0=?0^0K(V\8ZU3@P
M6+?D1<!^`YEF"6>S.Y+9\%]>C''%V2]PRZ7;Z$JO2CIXOO&<%D;[*(\ZN]A%
M?U3J8EBMELL@WQTS%4+$0HIX*WB2QMLLEDHJS/,Q#Y,XCA[A]'N0928]-A%(
MWREYN?9)]L_DG]PG<`](4.[K730D%UE(V1!)F6X33%5"?B\*E"(?/^;E<[!C
M'A$L#U,*<I*%?<H_OL=KX.7.P*ZLKFM*D\,2M<5F@6:ULW"MC>LH9;['2"IZ
M$U&TI</QK)=-^%`P8?J,8&(8AB\BF+G/_IT<"MV+A6Z#A;;.Z$7G1P):]JE7
MU4Y'UB_!Y1)SUQ<HZZ6S"]='&)I-?Y,49D]$[@>$=1*"9%-BC/W9=E"KF_MN
M(KA26UCJ"@.85:B(-!(VUA0T8@UTDU==@6!+M<9@J5>^&##=.#0J=Z2<W9B%
M#594"D[&(0@V'7N30WC[]G)V.I]^/)D>#W+EZ6D*@EVCT6VA\ST7%GZRNL$W
M0!Y1'"KZ9;]TRF`0!#_O4.9''V:PN^[A&%6O;S'(9D:6^]73L]/Y^?3H=C4E
M8U?Y,D9&C-.JU\93JO?J>+DZQ/Y#'4I$&DE?AV*9\GN*2$=R#)Q/1#P1S[40
M_M**H"Y1H;7PQX?I^>7\XNQL>O8.R%:'7A#G/MWH5C[-&M]'EJ:MH:U\1)VN
M226;$JGUV,6E[1:U=I>=6<"&4JQO/[X7?>FP0]VL^M&B;1`6-T`>%][`A?4S
MQ-WM=H/KUKA^GORB?%=DLS4$]P::=M.+L*_K#T3X5$!^1(91!N'=?Y:\Q/RS
3[>J#-(NS13Q&]C>/!;&^#@D`````
`
end

-- 
Vojtech Pavlik
SuSE Labs
