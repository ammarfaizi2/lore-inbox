Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVAaHtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVAaHtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVAaHqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:46:37 -0500
Received: from dialin-165-72.tor.primus.ca ([216.254.165.72]:4992 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261966AbVAaHl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:41:58 -0500
Date: Mon, 31 Jan 2005 02:41:48 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Disabling IRQ #xx, because nobody cared!
Message-ID: <20050131074148.GA3034@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <fa.kb79h86.1k60j00@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa.kb79h86.1k60j00@ifi.uio.no>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 04:32:12AM +0000, William Park wrote:
> I'm runing 2.6.10 SMP.  I usually use APM, but I decided to try ACPI.
> On my machine, USB (integrated) and Audio (PCI card) shares IRQ:
...
> After a while, I get
> 
>     irq 185: nobody cared!
>      [<c01339e2>] __report_bad_irq+0x22/0x90
>      [<c0133ad8>] note_interrupt+0x58/0x90
>      [<c0133578>] __do_IRQ+0x128/0x130
>      [<c0104eba>] do_IRQ+0x1a/0x30
>      [<c010370a>] common_interrupt+0x1a/0x20
>      [<c0100690>] default_idle+0x0/0x40
>      [<c01006ba>] default_idle+0x2a/0x40
>      [<c0100760>] cpu_idle+0x40/0x70
>     handlers:
>     [<e086e000>] (snd_audiopci_interrupt+0x0/0xc0 [snd_ens1371])
>     Disabling IRQ #185
> 
> Then, after some more time, I get
> 
>     irq 11: nobody cared!
>      [<c01339e2>] __report_bad_irq+0x22/0x90
>      [<c0133ad8>] note_interrupt+0x58/0x90
>      [<c0133578>] __do_IRQ+0x128/0x130
>      [<c0104eba>] do_IRQ+0x1a/0x30
>      [<c010370a>] common_interrupt+0x1a/0x20
>      [<c0100690>] default_idle+0x0/0x40
>      [<c01006ba>] default_idle+0x2a/0x40
>      [<c0100760>] cpu_idle+0x40/0x70
>      [<c03728c7>] start_kernel+0x147/0x170
>     handlers:
>     [<c0227ef0>] (usb_hcd_irq+0x0/0x60)
>     [<c0227ef0>] (usb_hcd_irq+0x0/0x60)
> 
> At which point, USB is dead.
> 
> Do you know if 'acpi' is responsible for this?

Solved!  After many kernel compile and many kernel paramters,
'acpi=noirq' or 'pci=noacpi' solved the IRQ being disabled.

I'm running Abit VP6 dual-P3 (Via Apollo 133A, VT82C694X, VT82C686B).

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because I can type.
