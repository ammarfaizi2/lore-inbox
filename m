Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUEKKyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUEKKyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 06:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUEKKyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 06:54:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:49876 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262837AbUEKKyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 06:54:09 -0400
Date: Tue, 11 May 2004 12:54:08 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: Alan Stern <stern@rowland.harvard.edu>, david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.0405071022221.1035-100000@ida.rowland.org>
Subject: Re: [linux-usb-devel] [linux-2.6.5] oops when plugging CDC USB network device...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <27198.1084272848@www53.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, David,

Thanks for your response - the problem observed in linux-2.6.5 is fixed in
2.6.6. Now I get a status code of -75 [1] and see no additional networking
devices.

Nothing jumps out from the ohci_q.c and related sources.

Any ideas?

--- [1]

ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [1] = 0x00010101 CSC PPS
CCS
hub 2-0:1.0: port 1, status 101, change 1, 12 Mb/s
hub 2-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
ohci_hcd 0000:00:02.1: GetStatus roothub.portstatus [1] = 0x00100103 PRSC
PPS PES CCS
usb 2-1: new full speed USB device using address 3
usb 2-1: skipped 3 class/vendor specific configuration descriptors
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-1: default language 0x0409
usb 2-1: Product: USB Cable Modem  
usb 2-1: adding 2-1:1.0 (config #1, interface 0)  
usbnet 2-1:1.0: usb_probe_interface
usbnet 2-1:1.0: usb_probe_interface - got id
ohci_hcd 0000:00:02.1: urb da0fef78 path 1 ep0in 82d60000 cc 8 --> status
-75
usbnet: probe of 2-1:1.0 failed with error -75
usb 2-1: adding 2-1:1.1 (config #1, interface 1)

> On Fri, 7 May 2004, Daniel Blueman wrote:
> 
> > When plugging a Motorola SurfBoard 5100 device into my box, khubd
> oopses.
> > Kernel is stock linux-2.6.5.
> > 
> > Chipset is nForce 2 (OHCI), USB 2 EHCI controller disabled, so just USB
> 1.1
> > controller active.
> > 
> > Please CC me if more information would be handy.
> > 
> > Harvested from kernel logs:
> 
> > usb 1-1: Product: USB Cable Modem
> > usb 1-1: registering 1-1:1.0 (config #1, interface 0)
> > usbnet 1-1:1.0: usb_probe_interface
> > usbnet 1-1:1.0: usb_probe_interface - got id
> > Unable to handle kernel NULL pointer dereference at virtual address
> 00000004
> >  printing eip:
> > c028ff64
> > *pde = 00000000
> > Oops: 0000 [#1]
> > DEBUG_PAGEALLOC
> > CPU:    0
> > EIP:    0060:[<c028ff64>]    Not tainted
> > EFLAGS: 00010296   (2.6.5) 
> > EIP is at usb_disable_interface+0x14/0x50
> 
> This has been fixed in 2.6.6.
> 
> Alan Stern

-- 
Daniel J Blueman

NEU : GMX Internet.FreeDSL
Ab sofort DSL-Tarif ohne Grundgebühr: http://www.gmx.net/dsl

