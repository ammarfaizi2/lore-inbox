Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbSKEA5L>; Mon, 4 Nov 2002 19:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266680AbSKEA5L>; Mon, 4 Nov 2002 19:57:11 -0500
Received: from dhcp16654186.neo.rr.com ([24.166.54.186]:1196 "EHLO
	viper.vortech.net") by vger.kernel.org with ESMTP
	id <S265443AbSKEAz5>; Mon, 4 Nov 2002 19:55:57 -0500
From: Joshua Jackson <linux-kernel@vortech.net>
Reply-To: linux-kernel@vortech.net
Organization: Vortech Consulting
To: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 and udma with VIA kt8235
Date: Mon, 4 Nov 2002 20:02:20 -0500
User-Agent: KMail/1.4.3
References: <20021105002551.A16087@pc9391.uni-regensburg.de> <20021105002750.C16087@pc9391.uni-regensburg.de>
In-Reply-To: <20021105002750.C16087@pc9391.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_W7W2ZOI5RVG1W5EPBP9Q"
Message-Id: <200211042002.20797.linux-kernel@vortech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_W7W2ZOI5RVG1W5EPBP9Q
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have been using the following modification for a couple of weeks now to=
 both=20
the 2.4.19 and 2.4.20-pre11 kernels on an MSI KT3 Ultra2 board (has the 8=
235=20
southbridge) and have not had any problems with the hard drives or DVD/CD=
RW=20
drives in the system running in UDMA mode.

The code modification comes from a patch that was posted to the list a wh=
ile=20
back by Vojtech.

--
Joshua Jackson
http://www.coyotelinux.com


On Monday 04 November 2002 6:27 pm, Christian Guggenberger wrote:
> Marcello, Vojtech,
>
> would you please incorporate the patch which lets udma work on a VIA kt=
8235
> Southbridge in one of the next 2.4.20-rc releases?
> I know, it would work with 2.5 series but that's not an alternative for=
 me
> now.
>
> Christian
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--------------Boundary-00=_W7W2ZOI5RVG1W5EPBP9Q
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="via8235.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="via8235.patch"

diff -uNr linux-2.4.20-pre11/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.4.20-pre11/drivers/ide/via82cxxx.c	2002-11-04 19:25:47.000000000 -0500
+++ linux/drivers/ide/via82cxxx.c	2002-10-28 18:49:41.000000000 -0500
@@ -105,8 +105,8 @@
 } via_isa_bridges[] = {
 #ifdef FUTURE_BRIDGES
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
-	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
 #endif
+	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
diff -uNr linux-2.4.20-pre11/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux-2.4.20-pre11/include/linux/pci_ids.h	2002-11-04 19:26:41.000000000 -0500
+++ linux/include/linux/pci_ids.h	2002-10-28 18:51:41.000000000 -0500
@@ -986,6 +986,7 @@
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
+#define PCI_DEVICE_ID_VIA_8235		0x3177
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235

--------------Boundary-00=_W7W2ZOI5RVG1W5EPBP9Q--
