Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263589AbUEGOXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUEGOXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbUEGOXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:23:35 -0400
Received: from ida.rowland.org ([192.131.102.52]:5124 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263589AbUEGOXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:23:32 -0400
Date: Fri, 7 May 2004 10:23:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Daniel Blueman <daniel.blueman@gmx.net>
cc: linux-kernel@vger.kernel.org, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [linux-2.6.5] oops when plugging CDC USB
 network device...
In-Reply-To: <8293.1083936045@www3.gmx.net>
Message-ID: <Pine.LNX.4.44L0.0405071022221.1035-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004, Daniel Blueman wrote:

> When plugging a Motorola SurfBoard 5100 device into my box, khubd oopses.
> Kernel is stock linux-2.6.5.
> 
> Chipset is nForce 2 (OHCI), USB 2 EHCI controller disabled, so just USB 1.1
> controller active.
> 
> Please CC me if more information would be handy.
> 
> Harvested from kernel logs:

> usb 1-1: Product: USB Cable Modem
> usb 1-1: registering 1-1:1.0 (config #1, interface 0)
> usbnet 1-1:1.0: usb_probe_interface
> usbnet 1-1:1.0: usb_probe_interface - got id
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> c028ff64
> *pde = 00000000
> Oops: 0000 [#1]
> DEBUG_PAGEALLOC
> CPU:    0
> EIP:    0060:[<c028ff64>]    Not tainted
> EFLAGS: 00010296   (2.6.5) 
> EIP is at usb_disable_interface+0x14/0x50

This has been fixed in 2.6.6.

Alan Stern

