Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbTDMTsL (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTDMTsK (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 15:48:10 -0400
Received: from golf.rb.xcalibre.co.uk ([217.8.240.16]:51463 "EHLO
	golf.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S261715AbTDMTsJ (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 15:48:09 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm2
Date: Sun, 13 Apr 2003 20:59:11 +0100
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200304132059.11503.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:

[snip]
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000040
>  printing eip:
> c0223cf4
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c0223cf4>]    Not tainted VLI
> EFLAGS: 00010282
> EIP is at devclass_add_driver+0x34/0x8a
> eax: 00000040   ebx: fffffff8   ecx: fffffff0   edx: ffff0001
> esi: 00000040   edi: 00000000   ebp: c03af298   esp: c1297f50
> ds: 0007b   es: 007b   ss: 0068
> Process swapper: (pid: 1, threadinfo=c1296000 task=c1294080)
> Stack: c03af500 c03af2b4 c03ae7c4 00000000 c03ae780 c0223620 c03af298
> c03af280
>        00000001 00000000 00000000 c0223a72 c03af298 c0223a72 c03af048
>        fffffffc 00000034 c026d15d c03af298 c01afc02 c03af048 c0402ebe
>        c03af020 0000003c
> Call Trace:
>  [<c0223620>] bus_add_driver+0x82/0xd2
>  [<c0223a72>] driver_register+0x38/0x3c
>  [<c0223a72>] driver_register+0x38/0x3c
>  [<c026d15d>] usb_register+0x73/0xae
>  [<c01afc02>] pci_register_driver+0x47/0x57
>  [<c0402ebe>] uhci_hcd_init+0xd9/0x137
>  [<c0402f2b>] hid_init+0xf/0x21
>  [<c03ec6e0>] do_initcalls+0x28/0x94
>  [<c0129ce8>] init_workqueues+0xf/0x27
>  [<c0105099>] init+0x36/0x195
>  [<c0105063>] init+0x0/0x195
>  [<c0106ffd>] kernel_thread_helper+0x5/0xb
> 
> Code: 24 0c 89 6c 24 10 89 74 24 08 8b 6c 24 18 31 ff 8b 45 08 89 04 
24 e8
> f7 02 00 00 85 c0 89 c3 74 4a 8d 70 48 ba 01 00 ff ff 98 f0 <0f> c1 10 
85
> d2 0f 85 f 03 00 00 89 2c 24 e8 c0 fe ff ff 85 c0
>  <0>Kernel panic: Attempted to kill init!
> 
> This doesn't happen with 2.5.67{-bk4}. I looked at the USB changes for
> 2.5.67-mm2 and they are just about the same as in -bk4. I didn't look
> at every line, though.

I get the same thing on an mm2 boot. Are you certain it isn't a -bk4 
bug? kobject, bus_add_driver and friends have all been touched by greg 
in bk, and I can't see anything immediately obvious in the new -mm 
patches (-mm1 works fine).

I'll try with just the linus drop now.

Cheers,
Alistair.

