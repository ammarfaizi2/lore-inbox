Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTLETIt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTLETIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:08:49 -0500
Received: from linux.us.dell.com ([143.166.224.162]:2213 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264330AbTLETIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:08:47 -0500
Date: Fri, 5 Dec 2003 13:07:58 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Meelis Roos <mroos@linux.ee>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
Message-ID: <20031205130758.A22775@lists.us.dell.com>
References: <Pine.SOL.4.58.0312042225300.26114@yellow.csi.cam.ac.uk> <Pine.LNX.4.44.0312051109580.1782-100000@logos.cnet> <20031205113619.A20371@lists.us.dell.com> <20031205125351.A22277@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031205125351.A22277@lists.us.dell.com>; from Matt_Domsch@dell.com on Fri, Dec 05, 2003 at 12:53:51PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1199, 2003-12-05 12:46:52-06:00, Matt_Domsch@dell.com
  EDD: s/DISKSIG_BUFFER/DISK80_SIG_BUFFER so it compiles
  
  bump EDD version number.


 edd.c   |    2 +-
 setup.c |    2 +-
 2 files changed, 2 insertions, 2 deletions


diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Fri Dec  5 12:51:43 2003
+++ b/arch/i386/kernel/edd.c	Fri Dec  5 12:51:43 2003
@@ -46,7 +46,7 @@
 MODULE_DESCRIPTION("proc interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.09 2003-Jan-21"
+#define EDD_VERSION "0.10 2003-Dec-05"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Fri Dec  5 12:51:43 2003
+++ b/arch/i386/kernel/setup.c	Fri Dec  5 12:51:43 2003
@@ -211,7 +211,7 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
-#define DISK80_SIGNATURE_BUFFER (*(unsigned int*) (PARAM+DISKSIG_BUFFER))
+#define DISK80_SIGNATURE_BUFFER (*(unsigned int*) (PARAM+DISK80_SIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))

===================================================================


This BitKeeper patch contains the following changesets:
1.1199
## Wrapped with gzip_uu ##


M'XL( +_3T#\  \U5:V^;,!3]'/\*J_W2AP!?OWA(F?I(VD5=VRA9]F6:(F+<
M!C5 !*3;)'[\#$N;/K)FZU9I&(%LF>-S[SWGLHU'A<Z#UGE8EN-.EA1JBK;Q
M^ZPH@U:D9S-;98E9&&2967"F6:*=)&JV.9,;1T>1,XO3Q3>+VMPR,V3V]L-2
M3?&MSHN@!3:[7RF_SW70&G1/1Q\.!PBUV_AX&J;7>JA+W&ZC,LMOPUE4'(3E
M=):E=IF':9'H,JPI5/=;*TH(-4. RXB0%4C"W4I!!!!RT!&AW),</8CGX"Z.
MQR ,# SXX(&LF  0J(/!!O!]3)@#U"$" PVX# 2UB P(P>M \3[%%D%'^-_R
M/T8*=SN= !=.IS<\&_9.QT>CDY/NH)EZ9+Q:P46&XQ*;4^;Q3!?F0W-/%LF\
M!FCJ$&<I3A?)1.<V.L.,F]-1?Y5]9/WAA1 )"7JW(>0P-R*)F2>=&YVG>N84
MNES,;?4@ ]Q4H.(N U*%0$SX+H<K4(JZ8FVR7\2L"RK XY**BKB<4\-P'<CG
MI8"_/$<S"EYB$9\R\ 7E4%&/"L.2,-^-))6A.]%2R=_DMT)\Q,YC;N. ]?MK
M.[P=\]=# S&#"4+].@0A&\>PIW:AXD6[ +;@[>S2Z/ZQYHWDFWQ?8BO_VMQ&
MP?U?I/X57NAP'P/J-<_M2%_%J:ZYC#]U!\/>Y07>(C807.?/ZFAE$;&UOO1+
M*6_NA7]GK/6M<9.Q3'^D3-32I9PU=7>]_ZKPF_ND\[11&EW476*3+I:9>(TR
M*/!:&C]?=]I8$;LX_#@:=._:^,[>SB(MXNM41SA.R[U=O-,_'!R>[S^+9'=W
9]9]54ZUNBD72=I565$J%?@!_!;MWTP<     
 
