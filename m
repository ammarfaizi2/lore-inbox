Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSKUWk1>; Thu, 21 Nov 2002 17:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSKUWk0>; Thu, 21 Nov 2002 17:40:26 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:14348 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265126AbSKUWkY>; Thu, 21 Nov 2002 17:40:24 -0500
Date: Thu, 21 Nov 2002 20:47:22 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>, jgarzik@pobox.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/net/hamradio: fix up header cleanups: remove unneeded sched.h include
Message-ID: <20021121224721.GW31594@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>, jgarzik@pobox.com,
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

	With the header cleanups there is not anymore a need to
include sched.h in those files.

	Jeff, I was wrong, there is this one and an upcoming for
drivers/net/wan/lmc.

	Now there are two outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.930, 2002-11-21 20:44:10-02:00, acme@conectiva.com.br
  o drivers/net/hamradio: fix up header cleanups: remove uneeded sched.h includes


 sm_sbc.c |    7 ++++---
 sm_wss.c |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)


diff -Nru a/drivers/net/hamradio/soundmodem/sm_sbc.c b/drivers/net/hamradio/soundmodem/sm_sbc.c
--- a/drivers/net/hamradio/soundmodem/sm_sbc.c	Thu Nov 21 20:44:27 2002
+++ b/drivers/net/hamradio/soundmodem/sm_sbc.c	Thu Nov 21 20:44:27 2002
@@ -26,13 +26,14 @@
  */
 
 #include <linux/ptrace.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/ioport.h>
 #include <linux/soundmodem.h>
 #include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
+
 #include "sm.h"
 #include "smdma.h"
 
diff -Nru a/drivers/net/hamradio/soundmodem/sm_wss.c b/drivers/net/hamradio/soundmodem/sm_wss.c
--- a/drivers/net/hamradio/soundmodem/sm_wss.c	Thu Nov 21 20:44:27 2002
+++ b/drivers/net/hamradio/soundmodem/sm_wss.c	Thu Nov 21 20:44:27 2002
@@ -26,12 +26,13 @@
  */
 
 #include <linux/ptrace.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/ioport.h>
 #include <linux/soundmodem.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
+
 #include "sm.h"
 #include "smdma.h"
 

===================================================================


This BitKeeper patch contains the following changesets:
1.930
## Wrapped with gzip_uu ##


begin 664 bkpatch3393
M'XL(`,MAW3T``]U644_;,!!^KG_%23Q.3>X<)VZC%3%@VB8F#3'QAH2,[9**
M.J[BM`PI/YX0!JTJ--JN+UN2A^C.\MWWW?=9/H#+8*N\I[2S[`"^^E#G/>U+
MJ^O)0D7:N^BF:A,7WK>)N/#.QL=G\:34T[FQH<^CE+7I<U7K`A:V"GF/HN0U
M4C_,;-Z[^/SE\ONG"\9&(S@I5'EK?]H:1B-6^VJAIB8<J;J8^C*J*U4&9^NN
M</.ZM.&(O'U3D@FF64,9"MEH,D1*D#7(Q2`3[`G#T7KO:[L0<>(<,QHT)"0B
M.P6*A@D"\I@HY@0<<R%RPC[R'!'>W!0^<.@C.X;]`CAA&CR8:O)$9%S:.BZ4
MJY29^!S&DU\PGT%AE;$5Z*E5Y7P6<JBL\PL+\]):8PT$75@3%?`R('8&)%*4
M['S)/.MO^3"&"MGA.VC?ZCL.?EX:YXUU<7#7X49'>H4,@4A-PD4V;!1Q,1Y*
MJP9CE"83;Q._79'G80N!LA&2TN$^(-R'L`Z!-\C;OV:02<UU)CE)(C/>'<&R
MQBJ"`4\&G84VY>!]A^UW9&QV?>NKVJD[6QT]J,+['8H(3#BGE(M&#)-4=/Y,
MU]V)\L_N%-!/_A%W/@OS!_2K^^YKW7:^\81W</(I'P*QTZ2EDGU+4A#LBAW\
M[@<^JN#BB8^*P[68<>HI>+6I_CH%[T5_F_MM=_FMU%C*+T61))W\LO]9?MVI
DLKW\.LK^6GYB:_F]7"Q:)/HNS-UH+&\R):1DC[3:F^G*"```
`
end
