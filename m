Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131180AbQLQKts>; Sun, 17 Dec 2000 05:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbQLQKti>; Sun, 17 Dec 2000 05:49:38 -0500
Received: from mail.valinux.com ([198.186.202.175]:46349 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S131180AbQLQKtY>;
	Sun, 17 Dec 2000 05:49:24 -0500
To: lukasz@lt.wsisiz.edu.pl
CC: twaugh@redhat.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.30.0012170143360.4003-100000@lt.wsisiz.edu.pl>
	(message from Lukasz Trabinski on Sun, 17 Dec 2000 01:51:15 +0100
	(CET))
Subject: Re: [patch] 2.2.18 PCI_DEVICE_ID_OXSEMI_16PCI954
From: tytso@valinux.com
Phone: (781) 391-3464
In-Reply-To: <Pine.LNX.4.30.0012170143360.4003-100000@lt.wsisiz.edu.pl>
Message-Id: <E147ato-0006CZ-00@beefcake.hdqt.valinux.com>
Date: Sun, 17 Dec 2000 02:18:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sun, 17 Dec 2000 01:51:15 +0100 (CET)
   From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>

   OK, You have right, I'm not a driver programmer, but it probably should
   look like this:

   +#define PCI_DEVICE_ID_OXSEMI_16PCI954   0x9501

That's correct, yes.  The reason why the original poster was having
problems was that the serial_compat.h defined PCI_VENDOR_ID_OXSEMI
PCI_DEVICE_ID_OXSEMI_16PCI954 if PCI_VENDOR_ID_OXSEMI was not defined.
Since 2.2.18 defines PCI_VENDOR_ID_OXSEMI, but ..._OXSEMI_16PCI954, the
5.05 serial.c wouldn't compile.  

When we integrate a newer serial driver into 2.2.19, I'll include the
necessary patches to pci_ids.h.  

   Why serial.c from the 2.2.18 not support 921600 speed? We have to patch
   it...

2.2.18 has an old serial driver that doesn't know about PCI devices.
The updated serial driver available at http://serial.sourceforge.net
should deal with this correctly.

							- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
