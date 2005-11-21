Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVKUWju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVKUWju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVKUWjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:39:49 -0500
Received: from xenotime.net ([66.160.160.81]:63367 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751187AbVKUWjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:39:21 -0500
Date: Mon, 21 Nov 2005 14:39:19 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Josh Litherland <josh@emperorlinux.com>
cc: linux-kernel@vger.kernel.org, research@emperorlinux.com
Subject: Re: SATA ICH6M problems on Sharp M4000
In-Reply-To: <43824A6F.6070407@emperorlinux.com>
Message-ID: <Pine.LNX.4.58.0511211438110.3900@shark.he.net>
References: <43824A6F.6070407@emperorlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Josh Litherland wrote:

>
> Trying to get this laptop operational; it has SATA for the hard disc and
> PATA for the optical drive.  The hard drive is wired to the secondary
> IDE interface, the optical to the primary.  As it stands, driving the
> whole system with the PATA (piix) driver works, but performance for the
> hard disc is (predictably) extremely poor.  With ata_piix driving the
> hard drive, performance is great, but the optical device is never
> enumerated.  When the piix driver tries to load, the following occurs:
>
> ide0: I/O resource 0x1F0-0x1F7 not free.
> ide0: ports already in use, skipping probe
> ide1: I/O resource 0x170-0x177 not free.
> ide1: ports already in use, skipping probe
>
> We have tried to resolve this through a wide variety of kernel command
> line options.  Tried every combination we could think of of ide0=0x1f0,
> ide1=0x170, ide0=noprobe, ide1=noprobe, acpi=off, noapic, lapic,
> pci=routeirq.  Tried shaking up module load order and using ide-generic
> instead of piix.  ahci won't bind to the device; throws error -12.
>
> Some information about this system including dmesg and lspci:
>
> http://downloads.emperorlinux.com/research/lkml/sharp_m4000/
>
> Thanks in advance for any advice you can give.

Is there a BIOS option for SATA or AHCI modes,
like Compatible mode or Enhanced mode?  If so, which mode
is it in?

-- 
~Randy
