Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUA3SDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUA3SDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:03:20 -0500
Received: from p5080BFA5.dip.t-dialin.net ([80.128.191.165]:22956 "EHLO
	fb04206.mathematik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S263062AbUA3SDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:03:16 -0500
To: linux-kernel@vger.kernel.org
From: Andre Noll <noll@mathematik.tu-darmstadt.de>
Subject: Re: [ANNOUNCE] udev 015 release
References: <20040126215036.GA6906@kroah.com> <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de>
Organization: No organization left on /dev/organization
Message-ID: <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de>
User-Agent: slrn/0.9.8.0 (Linux)
NNTP-Posting-Host: 127.0.0.1
Date: Fri, 30 Jan 2004 18:03:11 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004 17:45:41 +0100 you wrote in local.lists.kernel:
> Unable to handle kernel NULL pointer dereference at virtual address 0000001e
>   printing eip:
> f9b370cc
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<f9b370cc>]    Tainted: PF
> EFLAGS: 00010282
> EIP is at disconnect_scanner+0x2c/0x6d [scanner]
> eax: f685f0c0   ebx: f685f0d4   ecx: f9b370a0   edx: 00000007
> esi: 00000000   edi: f73194e8   ebp: f9b3abfc   esp: f78c3e50
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 983, threadinfo=f78c2000 task=f78da720)
> Stack: f685f0c0 f9b3ac78 f685f0c0 f9b3ace0 f9a4611b f685f0c0 f685f0c0 
> f685f100
>         f685f0d4 f9b3ad00 c026c214 f685f0d4 f685f100 f73194fc f73194c0 
> f9b36a4f
>         f685f0d4 f685f0c0 f73194fc f9b3ac0c 00000000 00000000 c021cbf8 
> f73194fc
> Call Trace:
>   [<f9a4611b>] usb_unbind_interface+0x7b/0x80 [usbcore]
>   [<c026c214>] device_release_driver+0x64/0x70
>   [<f9b36a4f>] destroy_scanner+0x4f/0xb0 [scanner]
>   [<c021cbf8>] kobject_cleanup+0x98/0xa0
>   [<f9a4611b>] usb_unbind_interface+0x7b/0x80 [usbcore]
>   [<c026c214>] device_release_driver+0x64/0x70
>   [<c026c345>] bus_remove_device+0x55/0xa0
>   [<c026b27d>] device_del+0x5d/0xa0
>   [<f9a4c6af>] usb_disable_device+0x6f/0xb0 [usbcore]
>   [<f9a46b76>] usb_disconnect+0x96/0xf0 [usbcore]
>   [<f9a492df>] hub_port_connect_change+0x30f/0x320 [usbcore]
>   [<f9a48c13>] hub_port_status+0x43/0xb0 [usbcore]
>   [<f9a495ba>] hub_events+0x2ca/0x340 [usbcore]
>   [<f9a4965d>] hub_thread+0x2d/0xf0 [usbcore]
>   [<c010925e>] ret_from_fork+0x6/0x14
>   [<c011c9e0>] default_wake_function+0x0/0x20
>   [<f9a49630>] hub_thread+0x0/0xf0 [usbcore]
>   [<c0107289>] kernel_thread_helper+0x5/0xc
>
> Code: 80 7e 1e 00 75 2e 85 f6 74 17 8d 46 3c 8b 5c 24 08 8b 74 24

Same problem here. Also with Epson Perfection (640U) and kernel
2.6.2-rc1:

Unable to handle kernel NULL pointer dereference at virtual address 0000001e 
 printing eip: 
c02ba64c 
*pde = 00000000 
Oops: 0000 [#1] 
CPU:    0 
EIP:    0060:[<c02ba64c>]    Not tainted 
EFLAGS: 00010282 
EIP is at disconnect_scanner+0x2c/0x6d 
eax: e7dc0bc0   ebx: e7dc0bd4   ecx: c02ba620   edx: 00000005 
esi: 00000000   edi: e7dbab68   ebp: c03b9dfc   esp: c17b1e50 
ds: 007b   es: 007b   ss: 0068 
Process khubd (pid: 5, threadinfo=c17b0000 task=e7f8e040) 
Stack: e7dc0bc0 c03b9e78 e7dc0bc0 c03b9ee0 c02aa0db e7dc0bc0 e7dc0bc0 e7dc0c00  
       e7dc0bd4 c03b9f00 c0265414 e7dc0bd4 e7dc0c00 e7dbab7c e7dbab40 c02b9fcf  
       e7dc0bd4 e7dc0bc0 e7dbab7c c03b9e0c 00000000 00000000 c0207b08 e7dbab7c  
Call Trace: 
 [<c02aa0db>] usb_unbind_interface+0x7b/0x80 
 [<c0265414>] device_release_driver+0x64/0x70 
 [<c02b9fcf>] destroy_scanner+0x4f/0xb0 
 [<c0207b08>] kobject_cleanup+0x98/0xa0 
 [<c02aa0db>] usb_unbind_interface+0x7b/0x80 
 [<c0265414>] device_release_driver+0x64/0x70 
 [<c0265545>] bus_remove_device+0x55/0xa0 
 [<c026447d>] device_del+0x5d/0xa0 
 [<c02b043f>] usb_disable_device+0x6f/0xb0 
 [<c02aa8f6>] usb_disconnect+0x96/0xe0 
 [<c02ad05f>] hub_port_connect_change+0x30f/0x320 
 [<c02ac993>] hub_port_status+0x43/0xb0 
 [<c02ad33a>] hub_events+0x2ca/0x340 
 [<c02ad3dd>] hub_thread+0x2d/0xf0 
 [<c010b25e>] ret_from_fork+0x6/0x14 
 [<c011e9a0>] default_wake_function+0x0/0x20 
 [<c02ad3b0>] hub_thread+0x0/0xf0 
 [<c0109289>] kernel_thread_helper+0x5/0xc 


> And that's it. I cannot do a clean shut-down anymore, as the scanner 
> module won't get unloaded. Is this an udev issue or is the module 
> faulty? I am using latest Linus kernel 2.6.2-rc2.

Not related to udev or modules IMHO, since my kernel does not have
module support compiled in and I'm not using udev.

Andre
-- 
Andre Noll, http://www.mathematik.tu-darmstadt.de/~noll

