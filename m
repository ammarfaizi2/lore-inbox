Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWALPx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWALPx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWALPx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:53:29 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:26539 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751417AbWALPx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:53:28 -0500
Date: Thu, 12 Jan 2006 10:53:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Reuben Farrelly <reuben-lkml@reub.net>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>,
       Neil Brown <neilb@cse.unsw.edu.au>, <linux-acpi@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
In-Reply-To: <43C6194C.1070107@reub.net>
Message-ID: <Pine.LNX.4.44L0.0601121052190.5383-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006, Reuben Farrelly wrote:

> >> Initializing USB Mass Storage driver...
> >> irq 193: nobody cared (try booting with the "irqpoll" option)

> >> handlers:
> >> [<c027017e>] (usb_hcd_irq+0x0/0x56)
> >> Disabling IRQ #193
> > 
> > USB lost its interrupt.  Could be USB, more likely ACPI.
> 
> I've seen this one happen nearly every boot since then including bootups that 
> are otherwise OK (no oopses), so it's probably worth more looking into rather 
> than being written off as a 'once off':
> 
> uhci_hcd 0000:00:1d.3: Unlink after no-IRQ?  Controller is probably using the 
> wrong IRQ.

> It's a new regression to -mm3.

Did the same IRQ get assigned to that controller in earlier kernel 
versions?

Alan Stern

