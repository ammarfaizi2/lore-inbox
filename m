Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318770AbSG0PKX>; Sat, 27 Jul 2002 11:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318771AbSG0PKX>; Sat, 27 Jul 2002 11:10:23 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:48774 "EHLO gagarin")
	by vger.kernel.org with ESMTP id <S318770AbSG0PKW>;
	Sat, 27 Jul 2002 11:10:22 -0400
Date: Sat, 27 Jul 2002 17:13:14 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Add argument to synchronize_irq in cs46xx
Message-ID: <20020727151314.GA28194@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet@1.478, 2002-07-27 17:06:46+02:00, andersg@heineken.0x63.nu
  Added irq-argument to synchronize_irq to make sound/oss/cs46xx.c compile again.


 cs46xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c	Sat Jul 27 17:12:00 2002
+++ b/sound/oss/cs46xx.c	Sat Jul 27 17:12:00 2002
@@ -2521,7 +2521,7 @@
 			{
 				dmabuf = &state->dmabuf;
 				stop_dac(state);
-				synchronize_irq();
+				synchronize_irq(card->irq);
 				dmabuf->ready = 0;
 				resync_dma_ptrs(state);
 				dmabuf->swptr = dmabuf->hwptr = 0;
@@ -2536,7 +2536,7 @@
 			{
 				dmabuf = &state->dmabuf;
 				stop_adc(state);
-				synchronize_irq();
+				synchronize_irq(card->irq);
 				resync_dma_ptrs(state);
 				dmabuf->ready = 0;
 				dmabuf->swptr = dmabuf->hwptr = 0;

===================================================================


This BitKeeper patch contains the following changesets:
1.478
## Wrapped with gzip_uu ##


begin 664 bkpatch1093
M'XL(`$"X0CT``\54:VO;,!3]'/T*0;]L%-M7#TNQ1TJZ=JQCA8:,?AZ*K,4F
ML=3)3IH.__@ICZ4C:PA[P&1A"=W#U3GW'G2&[QOC\YZRA?'-%)WA&]>T>:\T
ME34S8V-8"1;;10B,G0N!I'2U27;P9&:\-?-D,DLF<_<8T3A%`3E2K2[Q,B#R
M'HG9_J1]>C!Y;_SN_?WMY1BAP0!?E<I.S2?3XL$`M<XOU;QHAJHMY\[&K5>V
MJ4VK8NWJ;@_M*``-7THD@U1T1`"7G28%(8H34P#E?<'1CN+P4,EA(DDE842F
M60<@6!]=8Q)SV<=`$Y`)E9C('$3.Q3G0'``?RXO/"8X`O<7_5L85TOBR*$R!
M*_\U4GZZJ(UMPR6X>;*Z],Y6W\SG$%L?U6IF<.,6MDA<TR2ZX6*UBC4.%S]4
M<X/55%4V1A]Q'R0:/5<?1;\Y$`(%Z.*$UL)7:Q,D6T8_V/PDG`.!C@-;_P5E
MI&]$!@5,4B&/UKG[5=]S(]/00MFEA'&Z\=<+M3AIM+]AC92NS5`[:W1;+3?Y
MXHD_2CDE&:2I#'WGF>!\XSV2'5J/R9/6HSBB_\]Z:T=M:WZ'(_^XF<$CHQ?*
M_P=.NZ8IY9B@#[NU%\8!@5=:^2*Z"+O7;]9XEFWQF_44?O\\Z=+H6;.H!RRT
.5;#L"_H.*=>,2AX%````
`
end


-- 

//anders/g

