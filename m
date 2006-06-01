Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWFAKCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWFAKCp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWFAKCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:02:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964904AbWFAKCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:02:44 -0400
Date: Thu, 1 Jun 2006 03:06:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Barry Scott <barry.scott@onelan.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broadcom 5752 in HP dc7600U works on 2.6.13 but does not
 working on 2.6.16
Message-Id: <20060601030615.41b70b1f.akpm@osdl.org>
In-Reply-To: <447EB970.8030005@onelan.co.uk>
References: <4469E709.7080501@onelan.co.uk>
	<20060522035943.7829ee32.akpm@osdl.org>
	<447EB970.8030005@onelan.co.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 10:54:56 +0100
Barry Scott <barry.scott@onelan.co.uk> wrote:

> > It appears that the 2.6.13 kernel did not bring up the machine's io-APICs,
> > but 2.6.16 did.  However you are receiving eth0 interrupts on 2.6.16 so
> > perhaps that's not relevant.
> >
> > Don't know, sorry - tg3 works OK for most people.  You could try booting
> > with the `noapic' kernel paremeter, perhaps.
> >
> > Note that googling for "noapic" gets 212,000 hits - we've _really_ screwed
> > something up in there.  Maybe one day some developer will lay hands on one
> > of these machines and will fix something.
> >
> > If noapic doesn't work (and I suspect it won't) then a next step would be
> > to compile a kernel.org kernel and start enabling debug options.  It's
> > hard, when we don't know which kernel subsystem broke.
> >   
> I'm willing to help get this fixed. I'm happy working inside kernels and 
> drivers
> but will need some guidance to know where to focus to track this down.

ACPI, most likely.

> The obvious problem is solve is why are no interrupts being received by
> the tg3.c code.
> 
> Which kernel should I use to debug this? 2.6.17 latest RC?
> Which debug options do you suggest I turn on to get closer to the problem?
> What information should I collect?

A git-bisect search would be a suitable way of finding out where it broke.

But then, we don't know if this machine has _ever_ worked with IO-APIC's
enabled, do we?

