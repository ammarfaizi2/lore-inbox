Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUJBKLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUJBKLr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 06:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUJBKLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 06:11:47 -0400
Received: from port-222-152-48-85.fastadsl.net.nz ([222.152.48.85]:11904 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S267381AbUJBKLp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 06:11:45 -0400
Message-ID: <415E7EE0.60200@reub.net>
Date: Sat, 02 Oct 2004 22:11:44 +1200
From: Reuben Farrelly <reuben-news@reub.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1
References: <fa.h7b6720.im6q1m@ifi.uio.no>
In-Reply-To: <fa.h7b6720.im6q1m@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm1/
> 
> - Various fixups, cleanups, etc.  Nothing particularly notable.
> 
> - ppc64 build are still broken.
> 
> - sparc64 builds are still broken.
> 
> 
> 
> 
> Changes since 2.6.9-rc2-mm4:

This is the first -mm kernel in a while that compiles and runs without 
patches, although I did get this trace (which appears to be non critical 
as USB still works).

uhci_hcd 0000:00:1d.3: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0xb800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
usb 3-1: new full speed USB device using address 2
hub 5-0:1.0: 2 ports detected
slab error in kmem_cache_destroy(): cache `uhci_urb_priv': Can't free 
all objects
  [<c0104ddc>] dump_stack+0x17/0x19
  [<c013dfd5>] kmem_cache_destroy+0xea/0x15b
  [<c03e17eb>] uhci_hcd_init+0xc8/0xff
  [<c03ca89f>] do_initcalls+0x56/0xb3
  [<c01004f5>] init+0x81/0x189
  [<c01022f1>] kernel_thread_helper+0x5/0xb
drivers/usb/host/uhci-hcd.c: not all urb_priv's were freed!
Badness in remove_proc_entry at fs/proc/generic.c:688
  [<c0104ddc>] dump_stack+0x17/0x19
  [<c017c196>] remove_proc_entry+0x129/0x133
  [<c03e1810>] uhci_hcd_init+0xed/0xff
  [<c03ca89f>] do_initcalls+0x56/0xb3
  [<c01004f5>] init+0x81/0x189
  [<c01022f1>] kernel_thread_helper+0x5/0xb
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 
alt 0 proto 2 vid 0x03F0 pid 0x6204
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver

Reuben
