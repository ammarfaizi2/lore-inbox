Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSKRM5J>; Mon, 18 Nov 2002 07:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSKRMzc>; Mon, 18 Nov 2002 07:55:32 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:39940 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262480AbSKRMyc>; Mon, 18 Nov 2002 07:54:32 -0500
Date: Mon, 18 Nov 2002 11:01:29 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] input: fix up header cleanups: add include <linux/interrupt.h>
Message-ID: <20021118130129.GG2093@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there is five outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.894, 2002-11-18 10:42:52-02:00, acme@conectiva.com.br
  o input: fix up header cleanups: add include <linux/interrupt.h>


 mouse/inport.c   |    7 ++++---
 serio/ct82c710.c |   10 +++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)


diff -Nru a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
--- a/drivers/input/mouse/inport.c	Mon Nov 18 10:57:01 2002
+++ b/drivers/input/mouse/inport.c	Mon Nov 18 10:57:01 2002
@@ -34,14 +34,15 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
-#include <asm/io.h>
-#include <asm/irq.h>
-
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/input.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Inport (ATI XL and Microsoft) busmouse driver");
diff -Nru a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
--- a/drivers/input/serio/ct82c710.c	Mon Nov 18 10:57:01 2002
+++ b/drivers/input/serio/ct82c710.c	Mon Nov 18 10:57:01 2002
@@ -28,16 +28,16 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
-#include <asm/io.h>
-
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/serio.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
+
+#include <asm/io.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("82C710 C&T mouse port chip driver");
@@ -61,8 +61,8 @@
 
 #define CT82C710_IRQ          12
 
-static int ct82c710_data = 0;
-static int ct82c710_status = 0;
+static int ct82c710_data;
+static int ct82c710_status;
 
 static void ct82c710_interrupt(int cpl, void *dev_id, struct pt_regs * regs);
 

===================================================================


This BitKeeper patch contains the following changesets:
1.894
## Wrapped with gzip_uu ##


begin 664 bkpatch15333
M'XL(`)WCV#T``\U6VVZ;0!!]]G[%2'FL@)V]<$L=I8FKUDJE1JGR5JG:+)M`
M:\"%Q4DJ/KZ+TUSDN(Z;ME(`+6AF.,SEG!4[<-J:)ATI71JR`^_KUJ8C75=&
MVV*A?%V7_EGC'"=U[1Q!7I<F.#@*BDK/NLRT'O,E<>YC974."].TZ0A]?F>Q
MUW.3CD[>OCO]\.:$D/$8#G-579A/QL)X3&S=+-0L:_>5S6=UY=M&56UI[/+#
M_5UHSRAE[I08<2K#'D,JHEYCAJ@$FHPR$8>"##7LK^:^@H*(,3+A[CT*SA(R
M`?3C1`!E`6*`,2!-!4LE\RA+*86UH/"*@4?)`?S;`@Z)AAJ*:M[9%,Z+*^CF
MD!N5F0;TS*BJF[<IJ"R#7^V'U[.BZJ[<-*QIFFYN_7R/'`$*&3%R?-]JXOWA
M00A5E.S!HOYJC<[W[64Q*RYRZW?ZTM<_^JPIAED'RU2#LNY:,SS7C?7U3:T1
MY<AI++"GDC+9FTR=B3`)=1)CF$1R?5^?!KZ=GTAZ-SX>;YVD8WE1!]K&3$=(
M'Z;)9(AASU@H9*\C8ZA09Y$T:(S8*LNUR`_R9*&,XR7W-U4WR.'_M?L.NG7O
M;@6)E,;H",MI+ZCDT5(HX:I,1+)9)@(\_E)E<L.?C^`UE\O+T?YXXXB>(:,)
MCX"3J>"`9&=3.E,A7.#G!T&J+8.B'GPKMN;[8'S,IU4>;L^H9VGC[["=-+B(
MW"[LH$6\)->C/?@I<DGPY$LEUXWH-Y)KM3//HA<"(U-'LB?H-1'4A4S=RGY#
MLDDH!JA0NK6URA;:56CA-KTOF;)J=ZUGL'7M[OUO@,Z-_M9VY9B?QUG$SAGY
)"2"D!2-F"```
`
end
