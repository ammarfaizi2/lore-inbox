Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSJKKjN>; Fri, 11 Oct 2002 06:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbSJKKjN>; Fri, 11 Oct 2002 06:39:13 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:6532 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262387AbSJKKjL>;
	Fri, 11 Oct 2002 06:39:11 -0400
Date: Fri, 11 Oct 2002 12:44:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Fix atkbd.c oops on Alpha [2/5]
Message-ID: <20021011124452.A1763@ucw.cz>
References: <20021011124406.A1677@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021011124406.A1677@ucw.cz>; from vojtech@suse.cz on Fri, Oct 11, 2002 at 12:44:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.733.2.4, 2002-10-10 17:28:04-07:00, rth@dot.sfbay.redhat.com
  Avoid oops on systems that set atkbd_reset.


 atkbd.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Fri Oct 11 12:42:59 2002
+++ b/drivers/input/keyboard/atkbd.c	Fri Oct 11 12:42:59 2002
@@ -244,8 +244,9 @@
 
 	while (atkbd->cmdcnt && timeout--) udelay(10);
 
-	for (i = 0; i < receive; i++)
-		param[i] = atkbd->cmdbuf[(receive - 1) - i];
+	if (param)
+		for (i = 0; i < receive; i++)
+			param[i] = atkbd->cmdbuf[(receive - 1) - i];
 
 	if (atkbd->cmdcnt) 
 		return (atkbd->cmdcnt = 0) - 1;

===================================================================

This BitKeeper patch contains the following changesets:
1.733.2.4
## Wrapped with gzip_uu ##


begin 664 bkpatch1661
M'XL(`#.KICT``[64;4_;,!#'7\>?XB3>@%`2/Z5NPXI@;-JF30(Q\0JAR8E=
MXK6)*]LMZI0//S=4H$ECL&DD5I2S+^>[^__B/;CRVI7)VGX/NF[0'GRT/I2)
M7WF=U3^B?6EMM//&MCK?>>75/#?=<A507+^0H6Y@K9TO$Y*QAYFP6>HRN7S_
MX>K+Z25"TRF<-;*[U5]U@.D4!>O6<J'\B0S-PG99<++SK0XRJVW;/[CV%&,:
M[X((AHM13T:8B[XFBA#)B5:8\O&((Q>:$V5#YF>5W&1.JT:&WP0BF&",B>"L
M)VS""O0.2"88RVC&`=.<X#B`B)*.2\Q3+$J,X:G8<$@@Q>@M_-]2SE`-IVMK
M%%B[]&`[\!L?=.LAQ(W!Q_;),*_4-Z?C>X8^`^&"<W3QV%^4_N6%$)88'<-.
MWY-P9Q;FM@G9JKZ+%/3*F:W`]Z+G<[VIK'0J'_+(ZOO"!&:$X3''/9F,">FK
M2DTTQ5H1-IH(]F0;7Q(\ZA:%HZ*@/:=X-!EP^O-W6\9>L9R'V+L?Y655X`F)
MRA>XYX2,V4`?+7X%3Y0%?18\!BE]%?#.6Q,1BW$UF"Y86$HG6S`SB-/&0[=:
M++;$W8MP#JF[&T8DZ.(9/?Z!R7>4"Z#H4TP/&$IB%OM#/@<H26;6P;Z!*>`C
M,/`&G*YUW#X:AX?;]63PO#8WT67((#VN6U6M9M?[.U=(@1S$A[DY>CS&ZD;7
4<[]JIUHH/E(S@GX"1ADK_R$%````
`
end
