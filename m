Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbUDBJOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 04:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUDBJOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 04:14:18 -0500
Received: from fmr10.intel.com ([192.55.52.30]:55452 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S263371AbUDBJOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 04:14:16 -0500
Subject: Re: irq 16 : Nobody cared  - alsa v. io-apic in 2.6.5-rc3-bk2
From: Len Brown <len.brown@intel.com>
To: sean <seandarcy@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F7212@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F7212@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080897252.30361.147.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Apr 2004 04:14:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2004-04-01 at 14:24, sean wrote:
> I have a VIA k400 motherboard.
> 

> irq 16: nobody cared!
> Call Trace:
>   [<c0108508>] __report_bad_irq+0x28/0x80
>   [<c01088ae>] do_IRQ+0x15e/0x1a0
>   [<c0106e08>] common_interrupt+0x18/0x20
>   [<c01044e3>] default_idle+0x23/0x30
>   [<c010455d>] cpu_idle+0x2d/0x40
>   [<c04ee61b>] start_kernel+0x2ab/0x320
>   [<c04ee1c0>] unknown_bootoption+0x0/0x180
>  
> 
> handlers:
> [<c0395800>] (snd_cmipci_interrupt+0x0/0x130)
> Disabling IRQ #16
> ..............

> IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1
> Active:1)
> 00:00:01[A] -> 2-16 -> IRQ 16

Does acpi=off make a difference and change how /proc/interrupts looks?

If yes, can you try the latest ACPI code that 2.6.5 is missing?
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.5/

thanks,
-Len


