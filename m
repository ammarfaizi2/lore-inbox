Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbTGOUrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbTGOUrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:47:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:44506 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269672AbTGOUrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:47:48 -0400
Date: Tue, 15 Jul 2003 14:02:40 -0700
From: Greg KH <greg@kroah.com>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>,
       David Brownell <david-b@pacbell.net>
Cc: arjanv@redhat.com, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [More Info] Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpms installed)
Message-ID: <20030715210240.GA5345@kroah.com>
References: <1058196612.3353.2.camel@aurora.localdomain> <3F12FF53.7060708@pobox.com> <1058210139.5981.6.camel@laptop.fenrus.com> <1058217601.4441.1.camel@aurora.localdomain> <1058299838.3358.4.camel@aurora.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058299838.3358.4.camel@aurora.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 04:10:38PM -0400, Trever L. Adams wrote:
> kernel: ehci_hcd 0000:00:02.2: PCI device 10de:0068 (nVidia Corporation)
> kernel: irq 3: nobody cared!
> kernel: Call Trace:
> kernel:  [<c010c12a>] __report_bad_irq+0x2a/0x90
> kernel:  [<c010c21c>] note_interrupt+0x6c/0xb0
> kernel:  [<c010c42d>] do_IRQ+0xed/0x110
> kernel:  [<c010a9f8>] common_interrupt+0x18/0x20
> kernel:  [<c011f700>] do_softirq+0x40/0xa0
> kernel:  [<c010c414>] do_IRQ+0xd4/0x110
> kernel:  [<c010a9f8>] common_interrupt+0x18/0x20
> kernel:  [<c010c84e>] setup_irq+0x6e/0xb0
> kernel:  [<e087e310>] usb_hcd_irq+0x0/0x60 [usbcore]

Hm, but usb_hcd_irq() reports back the proper interrupt return value.  I
don't see how this could happen, unless the ehci driver was somehow
halted...

David, any ideas?

thanks,

greg k-h
