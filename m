Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTEST1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTEST1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:27:18 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36534
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263129AbTEST1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:27:14 -0400
Subject: Re: Promise SX6000 No handler for event
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kernel <kernel@mousebusiness.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030519191814.3000.qmail@srvr1.mousebusiness.com>
References: <20030519191814.3000.qmail@srvr1.mousebusiness.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053369714.29227.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 19:41:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-19 at 20:18, kernel wrote:
> What am I doing wrong? Where should I look for more info to solve this? How 
> did others solve this? I think I've tried the same setup others have tried, 
> but still I run into problems. 

> May 19 13:03:39 production kernel: i2o_block: Checking for Boot device...
> May 19 13:03:39 production kernel: i2o_block: Checking for I2O Block 
> devices... May 19 13:03:39 production kernel: i2ob: Installing tid 11 device 
> at unit 0
> May 19 13:03:39 production kernel: i2o/hda: Max segments 28, queue depth 8, 
> byte limit 49152.
> May 19 13:03:39 production kernel: i2o/hda: Type 130: 621795MB, 512 byte 
> sectors.
> May 19 13:03:39 production kernel: i2o/hda: Maximum sectors/read set to 96.
> May 19 13:03:39 production kernel:  i2o/hda: i2o/hda1

So it found the card, found a non boot volume and is quite happy
with it. The type seems bogus but they do on all the promise devices.

> May 19 13:05:59 production kernel: i2o/iop0: No handler for event 
> (0x00000020)
> May 19 13:05:59 production kernel: i2o/iop0: No handler for event 
> (0x00000020)

It sent us two event messages for events we've never head of (or asked
for)

> May 19 13:06:04 production kernel: i2o/iop0: Hardware Failure: Unknown Error

and then exploded

> PDC20276: IDE controller on PCI bus 03 dev 00
> PCI: Device 03:00.0 not available because of resource collisions
> PCI: Device 03:00.0 not available because of resource collisions
> PDC20276: (ide_setup_pci_device:) Could not enable device.
> PDC20276: IDE controller on PCI bus 03 dev 08
> PCI: Device 03:01.0 not available because of resource collisions
> PCI: Device 03:01.0 not available because of resource collisions
> PDC20276: (ide_setup_pci_device:) Could not enable device.
> PDC20276: IDE controller on PCI bus 03 dev 10
> PCI: Device 03:02.0 not available because of resource collisions
> PCI: Device 03:02.0 not available because of resource collisions
> PDC20276: (ide_setup_pci_device:) Could not enable device.

So it skipped the PDC controllers, which is good


