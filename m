Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUEQHUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUEQHUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 03:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUEQHUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 03:20:18 -0400
Received: from lac-1-82-66-8-145.fbx.proxad.net ([82.66.8.145]:27266 "EHLO
	vignemale.local.eukrea.com") by vger.kernel.org with ESMTP
	id S264923AbUEQHUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 03:20:04 -0400
From: Eric BENARD / Free <ebenard@free.fr>
To: David Dillow <dave@thedillows.org>
Subject: Re: 2.6.6 : bad PCI device ID for SiS ISA bridge => SiS900 eth0: Can not find ISA bridge
Date: Mon, 17 May 2004 08:48:12 +0200
User-Agent: KMail/1.6.2
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, webvenza@libero.it,
       dominik.karall@gmx.net
References: <200405162004.57041.ebenard@free.fr> <40A7E161.5060207@pobox.com> <1084765814.32116.20.camel@ori.thedillows.org>
In-Reply-To: <1084765814.32116.20.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sAGqAQU/fZztmAc"
Message-Id: <200405170848.12292.ebenard@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_sAGqAQU/fZztmAc
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 17 May 2004 05:50, David Dillow wrote:
> I'm not sure I understand the message, either. I can confirm that SiS's
> LPC-to-ISA bridges can change their device ID based on writes to the PCI
> config space -- 0x08 and 0x18 are both valid ids for that hardware.
>
> Eric, if you'll send me an lspci -xxx on the ISA bridge run under both
> kernels, that may be interesting. Then the fun part will be finding what
> changed in the kernel to cause that.
>
2.6.6
0000:00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC 
Bridge)
00: 39 10 18 00 0f 00 00 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: c8 80 0a 0c 0b 00 14 19 10 ef 00 00 11 20 04 01
50: 11 28 02 01 60 0a 63 0a a9 04 12 00 4d 17 00 00
60: 00 80 c0 80 40 c1 00 00 00 00 80 00 80 80 00 00
70: 80 00 d8 01 00 50 00 00 00 00 00 00 01 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

2.6.3-rc2
0000:00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC 
Bridge)
00: 39 10 08 00 0f 00 00 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 88 80 0a 0c 0b 00 14 19 10 ef 00 00 11 20 04 01
50: 11 28 02 01 62 0a 63 0a a9 04 12 00 4d 17 00 00
60: 0c 80 c0 80 40 c1 00 00 00 00 80 00 80 80 00 00
70: 80 00 d8 01 00 50 00 00 00 00 00 00 01 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


> In any event, I think it would be valid to have sis900 check for both
> ids.
>
Here is a patch for this.

Eric

--Boundary-00=_sAGqAQU/fZztmAc
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="sis900.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sis900.patch"

--- linux-2.6.6.orig/drivers/net/sis900.c	2004-05-17 08:41:55.000000000 +0200
+++ linux-2.6.6/drivers/net/sis900.c	2004-05-17 08:37:25.000000000 +0200
@@ -261,8 +261,10 @@
 	int i;
 
 	if ((isa_bridge = pci_find_device(0x1039, 0x0008, isa_bridge)) == NULL) {
-		printk("%s: Can not find ISA bridge\n", net_dev->name);
-		return 0;
+		if ((isa_bridge = pci_find_device(0x1039, 0x0018, isa_bridge)) == NULL) {
+			printk("%s: Can not find ISA bridge\n", net_dev->name);
+			return 0;
+		}
 	}
 	pci_read_config_byte(isa_bridge, 0x48, &reg);
 	pci_write_config_byte(isa_bridge, 0x48, reg | 0x40);

--Boundary-00=_sAGqAQU/fZztmAc--
