Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSDQP70>; Wed, 17 Apr 2002 11:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293196AbSDQP7Z>; Wed, 17 Apr 2002 11:59:25 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:3020 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S293187AbSDQP7V>; Wed, 17 Apr 2002 11:59:21 -0400
Date: Wed, 17 Apr 2002 17:59:19 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [BKPATCH 2.5] meye driver: fix request_irq bug
Message-ID: <20020417155919.GH1519@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes a failure in the meye driver to request_irq when
it is compiled into the kernel.

Linus, please apply.

Stelian.


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.532, 2002-04-17 16:45:29+02:00, stelian@popies.net
  Fix meye driver request_irq bug.


 meye.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	Wed Apr 17 16:45:51 2002
+++ b/drivers/media/video/meye.c	Wed Apr 17 16:45:51 2002
@@ -1242,7 +1242,6 @@
 	sonypi_camera_command(SONYPI_COMMAND_SETCAMERA, 1);
 
 	meye.mchip_dev = pcidev;
-	meye.mchip_irq = pcidev->irq;
 	memcpy(&meye.video_dev, &meye_template, sizeof(meye_template));
 
 	if (mchip_dma_alloc()) {
@@ -1256,6 +1255,7 @@
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


begin 664 bkpatch16582
M'XL(`)^*O3P``[6476O;,!2&KZ-?<:"7);:.+"6I1TJV=A]E@X6,7@]%/HU%
M_%5+3A/PCY^2EN9B7</&:AEL'8Z.WO/JL<_@UE&;#IRGPNJ*G<&7VOETT-2-
M)1=5Y$-H4=<A%.=U2;&WE:V[>$UM145<V*K;#D6D6$B;:V]RV%#KT@%&R7/$
M[QI*!XN/GV^_O5\P-IW"5:ZK%?T@#],I\W6[T47F9MKG15U%OM65*\GKR-1E
M_YS:"\Y%&`K'"5>C'D=<CGN#&:*62!D7<C*2QVH-5:O.GB@G<210*)[TB$)P
M=@T8J40`%S&7,8X!1ZE4J;@XYR+E')YLFAWM@7.$(6<?X/^V<<4,?+);*&E'
MD+4VN`HMW7?D_$_;WL.R6T7L*P35R-G\:"@;_N7%&-><74*S/ZJ7M3]N[^*2
M,JOCC<VHCO>Z(G-LY@)Y@KT4J&2OE-9&RW$FQ-)P?,&TDR4ECE%*)50ODV#4
M`9H_K]E3]';ZV;K56RIFRYTG1]NH;E>G]?,)GV`BDR?]>ZX0?\-*O8X5O@E6
M#]IZN*M;\#E!8RQDM+&&PDZP)*!*+PO*PFM((>B<K59@O8-`70#NL9WO,&P?
M#G<`:/[*R?P#CM<HI`)D-^&[G(3GX%"I-+EM#N1/]YJ#Y.%EF+T[_G=,3F;M
2NG)JDKNP4@GV"]8&>!O<!```
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
