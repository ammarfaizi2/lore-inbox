Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266553AbVBEAYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbVBEAYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265853AbVBEARh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:17:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:46051 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266561AbVBDX7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:59:08 -0500
Subject: Re: 2.6.11-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <6ud5vgezqx.fsf@zork.zork.net>
References: <20050204103350.241a907a.akpm@osdl.org>
	 <6ud5vgezqx.fsf@zork.zork.net>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 10:57:52 +1100
Message-Id: <1107561472.2363.125.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 22:17 +0000, Sean Neakums wrote:
> I gave this a crack on the PowerBook5.4 -- somewhat more successful
> than 2.6.11-rc2-mm2.  It boots, radeonfb works and X starts.  However,
> suspend seems a tad faster than usual, and resume stops after setting
> the hard disk's DMA mode, although the log below made it to disk.

Looks like USB is dying on wakeup... Anyway, that's still better than
2.6.11 since your model will not sleep/wakeup at all without these
patches.

I'll have to look into the USB thing. From the error messages, it looks
like at least some of my patches removing some old pmac IRQ cruft from
the ohci driver didn't make it (I though david picked it up a while ago
though). Or it could be a problem with the interrupt controller, I've
had reports of cases where the PIC just stops working on resume, I'm
still investigating.

Is this totally reproduceable or does it wake up sometimes ? Have you
tried with USB disabled ?

Ben.


