Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVBXCGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVBXCGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVBXCGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:06:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:61056 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261753AbVBXCFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:05:14 -0500
Subject: Re: ppc32 weirdness with gcc-4.0 in 2.6.11-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <16924.59237.581247.498382@alkaid.it.uu.se>
References: <16924.59237.581247.498382@alkaid.it.uu.se>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 13:04:48 +1100
Message-Id: <1109210688.15027.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -Memory: 255872k available (1788k kernel code, 976k data, 144k init, 0k highmem)
> +Memory: 255872k available (1776k kernel code, 0k data, 144k init, 0k highmem)

That is weird... (0k data)

> AGP special page: 0xcffff000
>  Calibrating delay loop... 830.66 BogoMIPS (lpj=4153344)
>  Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> @@ -132,13 +132,7 @@
>  VFS: Mounted root (ext3 filesystem) readonly.
>  Freeing unused kernel memory: 144k init 4k chrp 8k prep
>  usb 3-2: new full speed USB device using ohci_hcd and address 2
> -hub 3-2:1.0: USB hub found
> -hub 3-2:1.0: 3 ports detected
> -usb 3-2.1: new low speed USB device using ohci_hcd and address 3
> -input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0001:10:1b.0-2.1
> -usb 3-2.3: new full speed USB device using ohci_hcd and address 4
> -input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:1b.0-2.3
> -input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:1b.0-2.3
> +usb 3-2: can't connect bus-powered hub to this port
>  EXT3 FS on hda5, internal journal
>  Adding 1048568k swap on /dev/hda3.  Priority:-1 extents:1
>  SCSI subsystem initialized
> 
> Note: "Memory: ... 0k data ..." !? Surely that can't be correct.

Not sure what's up, but it's probably something beeing miscompiled. Can
you check if the udelay/medlay loops are correct ?

Ben.


