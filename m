Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVAMM7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVAMM7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 07:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVAMM7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 07:59:07 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:10183 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S261610AbVAMM7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 07:59:03 -0500
Subject: Re: PCI lost interrupts and PLX chips
From: Dimitris Lampridis <soth@softhome.net>
To: linux-os@analogic.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501130728520.10535@chaos.analogic.com>
References: <1105573129.3218.11.camel@localhost>
	 <Pine.LNX.4.61.0501130647420.10398@chaos.analogic.com>
	 <1105617881.3203.4.camel@localhost>
	 <Pine.LNX.4.61.0501130728520.10535@chaos.analogic.com>
Message-Id: <1105621134.3203.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 Jan 2005 14:58:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thanks for your concern.

On Thu, 2005-01-13 at 14:49, linux-os wrote:
> You can look at /proc/interrupts to see if your device ever interrupted.
> If it did, then got shut off, you probably forgot to return IRQ_HANDLED
> in the interrupt-service-routine. The newer code requires a return-value
> from the ISR.
> 
No interrupt at /proc/interrupts. The ISR never gets called. If it
would, it returns IRQ_HANDLED.
As I mentioned on the first mail, using a logical analyzer I saw the
device generating interrupts behind the PCI bridge, but I didn't see
them pass through the bridge, so I didn't expect to read something at
/proc/interrupts.

> If it got a bunch of spurious interrupts that made it impossible
> to initialize the device properly, then use some flag to tell
> your ISR that the device wasn't enabled yet. If it got an interrupt
> before the device was enabled, the ISR writes 0 to the PLX CSR after
> reading and throwing away the existing value. That will quiet the
> device until it can be properly initialized.
> 
Same here, ISR never gets called.

> If you never got any interrupts, then you have some other bug.
> You can readily force the PLX to generate interrupts for testing
> purposes.

How can I do that? Don't bother explaining everything. Maybe a link 
to somewhere on the net where I can learn more?

Thanks,
Dimitris

