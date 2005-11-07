Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbVKGR3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbVKGR3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVKGR2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:28:51 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:46841 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965174AbVKGR1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:27:14 -0500
Subject: Re: 2.6 series kernels panic on boot at PCI probe with 450nx
From: Frank Overton <frank@discoverycenters.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051105043056.GA25501@kroah.com>
References: <436BF7BB.9070900@discoverycenters.org>
	 <20051105043056.GA25501@kroah.com>
Content-Type: text/plain
Message-Id: <1131384430.26641.31.camel@coco.overtonshome.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-16) 
Date: Mon, 07 Nov 2005 09:27:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

I don't know any good way to save the oops message. I'd love a pointer
on that. 

Here is a hand copy of the oops message I am seeing.

-- top of screen --
   c316d000  c3126240  00000000 00000000  c01de368  00000000  c31262b8 
c3126240

Call Trace: 
[<co23e390>] class_device_create_file+0x11/0x16
[<co1ddcaf>] pci_alloc_child_bus+0x74/0xb8
[<co1ddda5>] pci_scan_bridge+0x90/0x1cd
[<co1de368>] pci_scan_child_bus+0x51/0x77
[<co1de4c2>] pci_scan_bus_parented+0x11d/0x133
[<co29d3ec>] pci_bios_scan_root+0x3d/0x40
[<co208e00>] acpi_pci_root_add+0x19a/0x1f0
[<co20d825>] acpi_bus_driver_init+0x2c/0x8c
[<co20e019>] acpi_bus_find_driver+0x110/0x21a
[<co20e561>] acpi_bus_add+0x12c/0x152
[<co20e68b>] acpi_bus_scan+0x104/0x156
[<co3b7c7a>] acpi_bus_scan_init+0x48/0x5e
[<co3a86fa>] do_initcalls+0x49/0x8e
[<co100454>] init+0x0/0x1d8
[<co1041d5>] kernel_thread_helper+0x5/0xb

Code:
00 00 0f 8e 37 02 00 00 83 c4 14 5b 5e 5f 5d c3 53 89 c1 89 c1 89 d3 85
c0 74 12 83 78 30 00 0f 94 c2 85 db 0f 94 c0 09 d0 a8 01 74 08 <0f> 0b
7d 01 1b 5b 31 c0 8b 41 30 89 da b9 04 00 00 00 5b e9 47

<0> Fatal Exception: panic in 5 seconds




On Fri, 2005-11-04 at 20:30, Greg KH wrote:
> On Fri, Nov 04, 2005 at 04:07:23PM -0800, Frank Overton wrote:
> > [1.] 2.6 series kernels panic on boot at PCI probe with 450nx (2.4.x 
> > kernels boot without hitch)  [2.] System: HP Netserver LH4s
> 
> Can you post the oops message that you see?
> 
> thanks,
> 
> greg k-h
> 

