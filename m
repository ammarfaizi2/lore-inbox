Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVABVaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVABVaT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 16:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVABVaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 16:30:19 -0500
Received: from postman2.arcor-online.net ([151.189.20.157]:39907 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261237AbVABVaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 16:30:08 -0500
Date: Sun, 2 Jan 2005 22:30:02 +0100
From: Christian Fertig <christian.fertig@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Problem: matrox framebuffer and kernel 2.6.x
Message-ID: <20050102213002.GA12121@fufnet.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux titan 2.6.10-fuf 
X-Fax: +49 69 13306784360
X-URL: http://www.fufnet.de/
X-PGP-Sig: http://www.fufnet.de/pubkey.asc
X-MSMail-Priority: Urgent Virus Delivery
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got Problems initializing the matrox framebuffer with my Matrox
G400 AGP Singlehead (32MB RAM) and an EPoX 8KDA3J (NFORCE3, AMD64)
Board running Debian Sarge.

I'm in contact with Petr Vandrovec, the maintainer of matroxfb. 

He sent me this patch

http://home.t-online.de/home/christian.fertig/matrox/matroxpatch

to increase message output.

The main error I get with kernel 2.6.0, 2.6.[8-10] vanilla, 2.6.[8-9]
with matrox-patches from
http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/ and my current
2.6.10-ac1 (with bootsplash and matroxpatch) is

matroxfb: Matrox G400 (AGP) detected
matroxfb: probe of 0000:01:00.0 failed with error -1

the increased output (see dmesg) is:

> PCI: Cannot allocate resource region 0 of device 0000:01:00.0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
> pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
> pnp: 00:00: ioport range 0x4400-0x447f has been reserved
> pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
> pnp: 00:00: ioport range 0x4800-0x487f has been reserved
> pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
> PCI: Failed to allocate mem resource #0:2000000@dc000000 for 0000:01:00.0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Machine check exception polling timer started.
> audit: initializing netlink socket (disabled)
> audit(1104439959.295:0): initialized
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Initializing Cryptographic API
> ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 177
> matroxfb: Matrox G400 (AGP) detected
> matroxfb: cannot request FB region at DC000000
> matroxfb: cannot determine memory size
> Trying to free nonexistent resource <dc000000-ddffffff>
> matroxfb: probe of 0000:01:00.0 failed with error -1

Petr is assuming, that the kernel wouldn't understand PCI bridges
properly and advised me to post this to lkml.
 
Relevant kernel output is located here:

http://home.t-online.de/home/christian.fertig/matrox/config-2.6.10-bootsplash-ac1
http://home.t-online.de/home/christian.fertig/matrox/dmesg
http://home.t-online.de/home/christian.fertig/matrox/interrupts
http://home.t-online.de/home/christian.fertig/matrox/ioports
http://home.t-online.de/home/christian.fertig/matrox/uname
http://home.t-online.de/home/christian.fertig/matrox/lspci

Christian

-- 
keyboard failure - press any key
