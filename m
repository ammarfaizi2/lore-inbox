Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUGFC2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUGFC2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 22:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUGFC2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 22:28:18 -0400
Received: from fmr02.intel.com ([192.55.52.25]:5531 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262744AbUGFC2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 22:28:15 -0400
Subject: Re: 2.6 series kernels on HP Netserver LH4 - kernel panic on boot
From: Len Brown <len.brown@intel.com>
To: Andrew Feldhacker <afeldhacker@thomasrepro.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FF248@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FF248@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089080891.15653.430.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 22:28:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-28 at 18:51, Andrew Feldhacker wrote:
> 2.6 series kernels on HP Netserver LH4 - kernel panic on boot
> 

> In attempting to migrate to the 2.6 series Linux kernel on my HP 
> Netserver LH4, I've run into a kernel panic on boot.  This happens 
> nearly immediately upon booting to the kernel, and so quickly that I 
> can't make out anything other than the truncated (transcribed) dump 
> appended below.
> 
> 2.4.x kernels work without a hitch on this system (I was trying to
> move 
> from 2.4.26 to 2.6.6 or 2.6.7 -- both of which produce the same 
> problem.).  I've also searched around a bit online, and found a couple
> other mentions of what seem to be the same problem, however, there
> were 
> no replies to go along with them.
> 
> The dump below is from a vanilla 2.6.7 kernel:
> 
> ----- top of screen -----
>         00000000 c02db078 c01bb853 f7feddb0 c02db078 00000000 00000001
> f7ea3400
>         00000000 00000000 00000000 c01bbaf8 f7feb158 f7ea3400 00000001
> 00000207
> Call Trace:
>    [<c02056e2>] class_device_add+0x112/0x130
>    [<c0205343>] class_device_create_file+0x23/0x30
>    [<c01bb853>] pci_alloc_child_bus+0x93/0xe0
>    [<c01bbaf8>] pci_scan_bridge+0x208/0x250
>    [<c01bc1da>] pci_scan_child_bus+0xaa/0xb0
>    [<c01bc354>] pci_scan_bus_parented+0x144/0x170
>    [<c0221f3e>] pcibios_scan_root+0x5e/0x70
>    [<c01d9b35>] acpi_pci_root_add+0x16d/0x1cd
>    [<c01db6aa>] acpi_bus_driver_init+0x2c/0x8a
>    [<c01dba24>] acpi_bus_find_driver+0x83/0xdd
>    [<c01dbed6>] acpi_bus_add+0x128/0x155
>    [<c01dc00e>] acpi_bus_scan+0x10b/0x159
>    [<c0359b5f>] acpi_scan_init+0x4e/0x6f
>    [<c03449ab>] do_initcalls+0x2b/0xc0
>    [<c0132bb5>] init_workqueues+0x15/0x2c
>    [<c0100564>] init+0x104/0x270
>    [<c0100460>] init+0x0/0x270
>    [<c01042c5>] kernel_thread_helper+0x5/0x10
> 
> Code: 0b 47 0c 8d 48 6c f0 ff 48 6c 0f 88 9f 01 00 00 8b 45 00 89
>    <0>Kernel panic: Attempted to kill init!
> 
> 
> Any help on this would be much appreciated, and I would be more than 
> happy to provide any additional information which may be needed.

any chance of getting a serial console "debug" capture?

would be interesting to try "acpi=off" and "pci=noacpi",
to see if ACPI is involved, but the trace above suggests
that the problem may lie in the common PCI code.

> (Attached is the output of lspci and the 'cpuinfo' from a working 
> 2.4.26 kernel.)

the attachments didn't seem to make it through -- at least to me.

thanks,
-Len


