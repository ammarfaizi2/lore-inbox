Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSDQPzO>; Wed, 17 Apr 2002 11:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292870AbSDQPzN>; Wed, 17 Apr 2002 11:55:13 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:18122 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S292855AbSDQPzL>; Wed, 17 Apr 2002 11:55:11 -0400
Date: Wed, 17 Apr 2002 17:55:08 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [BKPATCH 2.4] meye driver: fix request_irq bug
Message-ID: <20020417155508.GE1519@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes a failure in the meye driver to request_irq when
it is compiled into the kernel.

Marcelo, please apply.

Stelian.

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.418, 2002-04-17 16:29:42+02:00, stelian@popies.net
  Fix meye driver request_irq bug.


 meye.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	Wed Apr 17 16:30:05 2002
+++ b/drivers/media/video/meye.c	Wed Apr 17 16:30:05 2002
@@ -1237,7 +1237,6 @@
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1);
 
 	meye.mchip_dev = pcidev;
-	meye.mchip_irq = pcidev->irq;
 	memcpy(&meye.video_dev, &meye_template, sizeof(meye_template));
 
 	if (mchip_dma_alloc()) {
@@ -1251,6 +1250,7 @@
 		goto out3;
 	}
 
+	meye.mchip_irq = pcidev->irq;
 	mchip_adr = pci_resource_start(meye.mchip_dev,0);
 	if (!mchip_adr) {
 		printk(KERN_ERR "meye: mchip has no device base address\n");

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch15977
M'XL(`.V&O3P``[6476^;,!2&K^-?<:1>5@';F$"84F5K]Z5-6M6IUY,QI\$*
M8&H;VDK\^#EIU4A;UWUH!23#P7[/.:\?.()+A[:8.8^-EATY@@_&^6+6FUZC
MBSKT(71A3`C%M6DQ]KK39HBW:#MLXD9WP^V<1X*$:>?2JQI&M*Z8L2AYC/B[
M'HO9Q=OWEY]?7Q"R6L%I+;L-?D4/JQ7QQHZRJ=Q:^KHQ7>2M[%R+7D;*M-/C
MU(E3RL.9LBRAZ6)B"RJR2;&*,2D85I2+?"%(*ZW"QJS[9E#;NZC2SEL3E#I4
M7H_R1SVQD^$Y74XI3?*<G`&+!,N!\IB*F&7`%@5?%H(?4UY0"@\^K0_^P#&#
M.25OX/_V<4H4O-.WT.(=0F5UL!4L7@_H_#=MKZ$<-A'Y!&*9Y8*<'QPE\[\\
M"*&2DA/H=WOU=.WWZ5W<8J5E/.H*3;RK*U*'9I:,)FP2G*5B2E,IE119Q7FI
M*'O"M-]*"I8QP9=)-B4T%]F>FE^OV6'T<O63A_JC4/_ZRD:R46;$/U).@BX7
M&>4/;>SP^@FN)'L>+O8B<-U([>'*6/!U``Q'K3!D@1(!.UDV6(7;\!IA<+K;
M@/8.=MQ)[ZTN!X\!OON>OL#<WNRO`-/Y,[OT#VB>!?<H,/*1\30)XVROU*I:
G]_NO8`6]"AG&^4EX>G7X":D:U=8-[:K,EUE:E0GY#E^\6E7I!```
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
