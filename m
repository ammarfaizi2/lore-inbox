Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTE0VWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbTE0VVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:21:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14031
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264197AbTE0VVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:21:21 -0400
Subject: Re: Linux 2.4.21-rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <8765nw2js3.fsf@sycorax.lbl.gov>
References: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva>
	 <8765nw2js3.fsf@sycorax.lbl.gov>
Content-Type: multipart/mixed; boundary="=-Gn0a4xMkFcUJq+VlGlaO"
Organization: 
Message-Id: <1054067784.19108.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 21:36:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gn0a4xMkFcUJq+VlGlaO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Maw, 2003-05-27 at 21:53, Alex Romosan wrote:
> i get the following error:
> 
> make[5]: Entering directory `/usr/src/linux/drivers/ide/pci'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -I../ -nostdinc -iwithprefix include -DKBUILD_BASENAME=via82cxxx  -c -o via82cxxx.o via82cxxx.c
> via82cxxx.c:77: error: `PCI_DEVICE_ID_VIA_8237' undeclared here (not in a function)
> via82cxxx.c:77: error: initializer element is not constant

Doh .. my fault



--=-Gn0a4xMkFcUJq+VlGlaO
Content-Disposition: inline; filename=a1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=a1; charset=UTF-8

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.21rc4/=
include/linux/pci_ids.h linux.21rc4-ac1/include/linux/pci_ids.h
--- linux.21rc4/include/linux/pci_ids.h	2003-05-27 13:54:22.000000000 +0100
+++ linux.21rc4-ac1/include/linux/pci_ids.h	2003-05-27 14:17:22.000000000 +=
0100
@@ -501,6 +501,7 @@
 #define PCI_DEVICE_ID_SI_650		0x0650
 #define PCI_DEVICE_ID_SI_651		0x0651
 #define PCI_DEVICE_ID_SI_652		0x0652
+#define PCI_DEVICE_ID_SI_655		0x0655
 #define PCI_DEVICE_ID_SI_730		0x0730
 #define PCI_DEVICE_ID_SI_630_VGA	0x6300
 #define PCI_DEVICE_ID_SI_730_VGA	0x7300
@@ -1025,11 +1026,13 @@
 #define PCI_DEVICE_ID_VIA_8622		0x3102
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
+#define PCI_DEVICE_ID_VIA_8375		0x3116
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
-#define PCI_DEVICE_ID_VIA_P4X333   0x3168
-#define PCI_DEVICE_ID_VIA_8235        0x3177
-#define PCI_DEVICE_ID_VIA_8377_0  0x3189
+#define PCI_DEVICE_ID_VIA_8237_SATA	0x3149
+#define PCI_DEVICE_ID_VIA_P4X333	0x3168
+#define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189
+#define PCI_DEVICE_ID_VIA_8237		0x3227
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235

--=-Gn0a4xMkFcUJq+VlGlaO--
