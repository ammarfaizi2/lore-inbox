Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbUAZRkT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 12:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUAZRkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 12:40:19 -0500
Received: from gprs40-2.eurotel.cz ([160.218.40.2]:23868 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264574AbUAZRkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 12:40:15 -0500
Date: Mon, 26 Jan 2004 18:39:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Bluetooth USB oopses on unplug (2.6.1)
Message-ID: <20040126173958.GA310@elf.ucw.cz>
References: <20040126102041.GA1112@elf.ucw.cz> <1075124726.25442.2.camel@pegasus> <20040126161625.GB227@elf.ucw.cz> <1075136997.25442.99.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075136997.25442.99.camel@pegasus>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'll have to hand-copy the oops, as machine dies after unplug. Here it
> > is:
> > 
> > Oops: 2
> > EIP  is at uhci_remov_pending_qhs
> > Call trace:
> > 	uhci_irq
> > 	usb_hcd_irq
> > 	handle_irq_event
> > 	do_IRQ
> > 	common_interrupt_1
> 
> as I expected. It is an UHCI host adapter and it looks like the uhci_hcd
> driver has problems to unlink the ISOC URB's. Look at the LKML and USB
> mailing lists for similiar post. At the moment I don't know of any patch
> for it. Sorry.

No problem. For the record, it works okay without SCO. Thanks for that.
									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
