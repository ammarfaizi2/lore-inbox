Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262501AbTCZVic>; Wed, 26 Mar 2003 16:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262505AbTCZVic>; Wed, 26 Mar 2003 16:38:32 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:42697 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S262501AbTCZVia>;
	Wed, 26 Mar 2003 16:38:30 -0500
From: Craig Dooley <cd5697@albany.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: uhci kernel panic
Date: Wed, 26 Mar 2003 07:55:19 -0500
User-Agent: KMail/1.5.1
References: <200303241632.32818.cd5697@albany.edu> <20030325065739.GB12590@kroah.com>
In-Reply-To: <20030325065739.GB12590@kroah.com>
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303260755.19407.cd5697@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was a message I wrote down by hand.  The bootmessages is a previous boot 
from the same kernel, but I wrote to the list with that problem.  I have a 
null modem cable now, but because of some wierd problem I had to swap 
motherboards yesterday.  The probably was that with the mouse plugged in I 
would get either that panic, or 

usb/host/uhci-hcd.c: d800: host controller process error.  something bad 
happened
usb/host/uhci-hcd.c: d800: host controller halted.  very bad
usb/core/message.c: usb_control/bulk_msg: timeout
and then freeze

Im building 2.5.66 now to see if it helps the problem.  I should have stripped 
that dmesg output, but it was mostly there for a system config

-Craig

On Tuesday 25 March 2003 01:57, you wrote:
> On Mon, Mar 24, 2003 at 04:32:32PM -0500, Craig Dooley wrote:
> > Reproducable kernel panic.  If I boot with a Microsoft Intellimouse
> > Explorer plugged in, I get the following panic
> >
> > [<c02d24a8>]	uhci_tranfer_result+0x1d8/0x1f0
> > [<c02d2d31>]	uhci_irq+0xd1/0x160
> > [<c02c68ec>]	usb_hdc_irq+0x2c/0x60
>
> Um, I don't see that oops down below.  I see some other strange stuff:
> > Mar 21 21:33:48 broken kernel:
> > *************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >**************************************************************************
> >********************************** Mar 21 21:33:48 broken kernel:
> > *************************************************************************
> >*************************************A5 Mar 21 21:33:48 broken kernel:
> > Call Trace:
> > Mar 21 21:33:48 broken kernel:  [check_poison_obj+347/416]
> > check_poison_obj+0x15b/0x1a0 Mar 21 21:33:48 broken kernel: 
> > [kmalloc+361/448] kmalloc+0x169/0x1c0 Mar 21 21:33:48 broken kernel: 
> > [ip_rcv+776/1088] ip_rcv+0x308/0x440 Mar 21 21:33:48 broken kernel: 
> > [alloc_skb+174/576] alloc_skb+0xae/0x240 Mar 21 21:33:48 broken kernel: 
> > [alloc_skb+174/576] alloc_skb+0xae/0x240 Mar 21 21:33:48 broken kernel: 
> > [e100_rx_srv+388/960] e100_rx_srv+0x184/0x3c0 Mar 21 21:33:48 broken
> > kernel:  [e100intr+596/656] e100intr+0x254/0x290 Mar 21 21:33:48 broken
> > kernel:  [handle_IRQ_event+56/96] handle_IRQ_event+0x38/0x60 Mar 21
> > 21:33:48 broken kernel:  [do_IRQ+174/352] do_IRQ+0xae/0x160 Mar 21
> > 21:33:48 broken kernel:  [common_interrupt+24/32]
> > common_interrupt+0x18/0x20 Mar 21 21:33:48 broken kernel: 
> > [acpi_processor_idle+346/495] acpi_processor_idle+0x15a/0x1ef Mar 21
> > 21:33:48 broken kernel:  [default_idle+0/48] default_idle+0x0/0x30 Mar 21
> > 21:33:48 broken kernel:  [acpi_processor_idle+0/495]
> > acpi_processor_idle+0x0/0x1ef Mar 21 21:33:48 broken kernel: 
> > [default_idle+0/48] default_idle+0x0/0x30 Mar 21 21:33:48 broken kernel: 
> > [cpu_idle+49/64] cpu_idle+0x31/0x40 Mar 21 21:33:48 broken kernel: 
> > [rest_init+0/96] _stext+0x0/0x60 Mar 21 21:33:48 broken kernel:
> > Mar 21 21:35:49 broken kernel: nvidia: no version magic, tainting kernel.
> > Mar 21 21:35:49 broken kernel: nvidia: module license 'unspecified'
> > taints kernel. Mar 21 21:37:57 broken kernel: nvidia: no version magic,
> > tainting kernel. Mar 21 21:37:57 broken kernel: nvidia: module license
> > 'unspecified' taints kernel. Mar 21 21:37:57 broken kernel: 0: nvidia:
> > loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4191  Mon Dec  9
> > 11:49:01 PST 2002
>
> Um, sorry, I don't think this is a usb problem, unless you can duplicate
> it without the nvidia driver in your kernel.
>
> Can you?
>
> If so, does the same thing happen if when you boot, you don't have the
> device plugged in, and then plug it in after boot?
>
> thanks,
>
> greg k-h

