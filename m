Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSKUBUE>; Wed, 20 Nov 2002 20:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSKUBUE>; Wed, 20 Nov 2002 20:20:04 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:38927 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261978AbSKUBUC>; Wed, 20 Nov 2002 20:20:02 -0500
Date: Wed, 20 Nov 2002 23:27:00 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound: fix up header cleanups: add include <linux/interrupt.h>
Message-ID: <20021121012700.GI28717@conectiva.com.br>
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

	Now there are five outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.926, 2002-11-20 23:18:58-02:00, acme@conectiva.com.br
  sound: fix up header cleanups: add include <linux/interrupt.h>
  
  also fix a bug in hammerfall driver, removing __exit from a function
  that is called from a non __exit function.


 isa/ad1816a/ad1816a_lib.c    |    6 ++++--
 pci/rme9652/hammerfall_mem.c |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
--- a/sound/isa/ad1816a/ad1816a_lib.c	Wed Nov 20 23:20:18 2002
+++ b/sound/isa/ad1816a/ad1816a_lib.c	Wed Nov 20 23:20:18 2002
@@ -19,14 +19,16 @@
 */
 
 #include <sound/driver.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
 #include <sound/ad1816a.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
 
 MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
 MODULE_DESCRIPTION("lowlevel code for Analog Devices AD1816A chip");
diff -Nru a/sound/pci/rme9652/hammerfall_mem.c b/sound/pci/rme9652/hammerfall_mem.c
--- a/sound/pci/rme9652/hammerfall_mem.c	Wed Nov 20 23:20:18 2002
+++ b/sound/pci/rme9652/hammerfall_mem.c	Wed Nov 20 23:20:18 2002
@@ -178,7 +178,7 @@
 	printk ("Hammerfall memory allocator: unknown buffer address or PCI device ID");
 }
 
-static void __exit hammerfall_free_buffers (void)
+static void hammerfall_free_buffers (void)
 
 {
 	int i;

===================================================================


This BitKeeper patch contains the following changesets:
1.926
## Wrapped with gzip_uu ##


begin 664 bkpatch4244
M'XL(`-(TW#T``^U66V_3,!1^KG_%D?8"@B:V$^<F.HUM"*8A,0WM#:ER'&>)
M2.+*3DI!^?&XH6O+Z+H+\+;$BB6?XR_G\GV6#^#*2)V,N*@E.H`/RK3)2*A&
MBK:<<T>HVDFU-5PJ90UNH6KI'I^[92.J+I-F3!V&K/F"MZ*`N=0F&1''6Z^T
MWV<R&5V^>W_U\>TE0I,)G!2\N9:?90N3"6J5GO,J,T>\+2K5.*WFC:EE._RX
M7[OV%&-J7T9"#[.@)P'VPUZ0C!#N$YEAZD>!CY8Y'-V._18*(91@0D(:])3B
M*$"G0)R8!H"I2XA+,5`O(5'"HC&F"<:P$Q1>41AC=`S_-H$3),"HKLD2R,L%
M=#,H),^D!E%)WG0SDP#/,E@5']Y49=,M;"]:J74W:YWBT`+8P2NC!@0.:7=M
M_:'@=2UUSJL*,EW:/KT&+6LU+YMKF$[EHFPAUZJV&_*NL9FJQL*T!6^A-"#L
M-IG=.#2J66]9^3KHW):->3&ZV/07C1_Y((0Y1H<PDUHNCH:O(W[T0T'<F2A=
M7<LX8/1FGM:R=L2JM,0CL6?GWB,L8GTJJ)=EMK[<9P'+=W=Q!_2F3EOH*\Y$
MC/4X#.F=,9:&NSPC$0G6\[0JTQTQLC`B/8T8SZ/`\_,TII%,]P:Y'WLK0AJ%
MD3\H[9Z-2_W]CS16H*8S\J&8!&-"/1R0J*<!#KU!E']*DNV7I`]C^BS);4D.
M5/@$8_UM&%9B%_>QX@FJ/:44*#JC#`@ZV%>(,QJ#A[YL.7%3NZ5:VGY?RVJ^
M7-RP>)]&[R3RWYT9.WG\@+/""C'V`DQZ''FV_$LJ1X^E,H$Q>:;R%I6'8W<G
MD_=UY"EDMEJP/#[[-9F6MZ6`N2JSK22GN99RFG9Y;N\[\&)I?;FY!(E"BJ^F
2JR<ABX7PPA3]!!?P$L%D"0``
`
end
