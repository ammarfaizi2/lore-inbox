Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVBEAKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVBEAKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVBEAKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:10:35 -0500
Received: from zork.zork.net ([64.81.246.102]:7394 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264177AbVBEAGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:06:06 -0500
From: Sean Neakums <sneakums@zork.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc3-mm1
References: <20050204103350.241a907a.akpm@osdl.org>
	<6ud5vgezqx.fsf@zork.zork.net> <1107561472.2363.125.camel@gaston>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew
	Morton <akpm@osdl.org>, Linux Kernel list
	<linux-kernel@vger.kernel.org>
Date: Sat, 05 Feb 2005 00:05:55 +0000
In-Reply-To: <1107561472.2363.125.camel@gaston> (Benjamin Herrenschmidt's
	message of "Sat, 05 Feb 2005 10:57:52 +1100")
Message-ID: <6u7jlng9b0.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2005-02-04 at 22:17 +0000, Sean Neakums wrote:
>> I gave this a crack on the PowerBook5.4 -- somewhat more successful
>> than 2.6.11-rc2-mm2.  It boots, radeonfb works and X starts.  However,
>> suspend seems a tad faster than usual, and resume stops after setting
>> the hard disk's DMA mode, although the log below made it to disk.
>
> Looks like USB is dying on wakeup... Anyway, that's still better than
> 2.6.11 since your model will not sleep/wakeup at all without these
> patches.
>
> I'll have to look into the USB thing. From the error messages, it looks
> like at least some of my patches removing some old pmac IRQ cruft from
> the ohci driver didn't make it (I though david picked it up a while ago
> though). Or it could be a problem with the interrupt controller, I've
> had reports of cases where the PIC just stops working on resume, I'm
> still investigating.
>
> Is this totally reproduceable or does it wake up sometimes ? Have you
> tried with USB disabled ?

I tried it two or three times, same result each time.  I'll give it a
lash with USB disabled.
