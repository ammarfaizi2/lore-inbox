Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbTCYGrP>; Tue, 25 Mar 2003 01:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbTCYGrP>; Tue, 25 Mar 2003 01:47:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4369 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261568AbTCYGrE> convert rfc822-to-8bit;
	Tue, 25 Mar 2003 01:47:04 -0500
Date: Mon, 24 Mar 2003 22:57:39 -0800
From: Greg KH <greg@kroah.com>
To: Craig Dooley <cd5697@albany.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uhci kernel panic
Message-ID: <20030325065739.GB12590@kroah.com>
References: <200303241632.32818.cd5697@albany.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200303241632.32818.cd5697@albany.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 04:32:32PM -0500, Craig Dooley wrote:
> Reproducable kernel panic.  If I boot with a Microsoft Intellimouse Explorer 
> plugged in, I get the following panic
> 
> [<c02d24a8>]	uhci_tranfer_result+0x1d8/0x1f0
> [<c02d2d31>]	uhci_irq+0xd1/0x160
> [<c02c68ec>]	usb_hdc_irq+0x2c/0x60

Um, I don't see that oops down below.  I see some other strange stuff:

> Mar 21 21:33:48 broken kernel: ***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
> Mar 21 21:33:48 broken kernel: **************************************************************************************************************A5 
> Mar 21 21:33:48 broken kernel: Call Trace:
> Mar 21 21:33:48 broken kernel:  [check_poison_obj+347/416] check_poison_obj+0x15b/0x1a0
> Mar 21 21:33:48 broken kernel:  [kmalloc+361/448] kmalloc+0x169/0x1c0
> Mar 21 21:33:48 broken kernel:  [ip_rcv+776/1088] ip_rcv+0x308/0x440
> Mar 21 21:33:48 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
> Mar 21 21:33:48 broken kernel:  [alloc_skb+174/576] alloc_skb+0xae/0x240
> Mar 21 21:33:48 broken kernel:  [e100_rx_srv+388/960] e100_rx_srv+0x184/0x3c0
> Mar 21 21:33:48 broken kernel:  [e100intr+596/656] e100intr+0x254/0x290
> Mar 21 21:33:48 broken kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0x38/0x60
> Mar 21 21:33:48 broken kernel:  [do_IRQ+174/352] do_IRQ+0xae/0x160
> Mar 21 21:33:48 broken kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> Mar 21 21:33:48 broken kernel:  [acpi_processor_idle+346/495] acpi_processor_idle+0x15a/0x1ef
> Mar 21 21:33:48 broken kernel:  [default_idle+0/48] default_idle+0x0/0x30
> Mar 21 21:33:48 broken kernel:  [acpi_processor_idle+0/495] acpi_processor_idle+0x0/0x1ef
> Mar 21 21:33:48 broken kernel:  [default_idle+0/48] default_idle+0x0/0x30
> Mar 21 21:33:48 broken kernel:  [cpu_idle+49/64] cpu_idle+0x31/0x40
> Mar 21 21:33:48 broken kernel:  [rest_init+0/96] _stext+0x0/0x60
> Mar 21 21:33:48 broken kernel: 
> Mar 21 21:35:49 broken kernel: nvidia: no version magic, tainting kernel.
> Mar 21 21:35:49 broken kernel: nvidia: module license 'unspecified' taints kernel.
> Mar 21 21:37:57 broken kernel: nvidia: no version magic, tainting kernel.
> Mar 21 21:37:57 broken kernel: nvidia: module license 'unspecified' taints kernel.
> Mar 21 21:37:57 broken kernel: 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4191  Mon Dec  9 11:49:01 PST 2002

Um, sorry, I don't think this is a usb problem, unless you can duplicate
it without the nvidia driver in your kernel.

Can you?

If so, does the same thing happen if when you boot, you don't have the
device plugged in, and then plug it in after boot?

thanks,

greg k-h
