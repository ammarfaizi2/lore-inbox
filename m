Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUDOHl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 03:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUDOHl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 03:41:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:28610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261790AbUDOHl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 03:41:58 -0400
Date: Thu, 15 Apr 2004 00:41:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Hoogerhuis <alexh@boxed.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm6
Message-Id: <20040415004137.437b679c.akpm@osdl.org>
In-Reply-To: <87d669hfaa.fsf@dorker.boxed.no>
References: <20040414230413.4f5aa917.akpm@osdl.org>
	<87d669hfaa.fsf@dorker.boxed.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@boxed.no> wrote:
>
> And the mandatory mail about what goes oops on a new kernel:

If I had a dollar for every usb->sysfs/kobject oops...

> [booting...]
> ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 6 ports detected
> usb 3-1: USB disconnect, address 2
> Unable to handle kernel NULL pointer dereference at virtual address 00000070
>  printing eip:
> c017efc1
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT 
> CPU:    0
> EIP:    0060:[<c017efc1>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.5-mm6) 
> EIP is at sysfs_hash_and_remove+0x2b/0x90
> eax: 00000000   ebx: 00000070   ecx: 00000070   edx: 00000000
> esi: 00000000   edi: c02bc0f4   ebp: f5fd4e70   esp: f5fd4e60
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 5218, threadinfo=f5fd4000 task=f5efa3b0)
> Stack: f5925a80 f8962ac0 f5b27530 f8962a60 f5fd4e8c c01f6406 f8962ac0 f8962aac 
>        f5b27400 f5b27400 f5f6c690 f5fd4e98 f8959003 f5f6c280 f5fd4eb4 f8935c52 
>        f88deb59 f5f6d800 f5f6c680 f5f6c680 f8937240 f5fd4ec4 f88d90c6 f5f6c690 
> Call Trace:
>  [<c01f6406>] class_device_del+0x88/0xb9
>  [<f8959003>] hci_unregister_dev+0xb/0x94 [bluetooth]

Apparently bluetooth is known-broken.  Do you actually have any bluetooth
hardware there?

