Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265778AbUFORY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUFORY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUFORY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:24:27 -0400
Received: from palrel10.hp.com ([156.153.255.245]:51081 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265778AbUFORYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:24:20 -0400
Date: Tue, 15 Jun 2004 10:01:58 -0700
To: William Lee Irwin III <wli@holomorphy.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [3/12] remove irda usage of isa_virt_to_bus()
Message-ID: <20040615170158.GE11105@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040615014344.GA17657@bougret.hpl.hp.com> <20040615091219.GR1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615091219.GR1444@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 02:12:19AM -0700, William Lee Irwin III wrote:
> On Mon, Jun 14, 2004 at 06:43:44PM -0700, Jean Tourrilhes wrote:
> > 	Could you please send this directly to me. I hate scrubbing
> > large patches from the mailing list archive.
> > 	Note that before even thinking of pushing this patch in the
> > kernel, we need to perform testing with the hardware on i386 and
> > potentially on ARM. The author only tried with irtty that doesn't use
> > this function, so that's not a valid test at all. Finding people test
> > those changes is going to be tough, as usual.
> > 	I'm also wondering about the validity of those changes, but
> > that's another matter I need to go through. During 2.5.X, some people
> > assured me that using isa_virt_to_bus was safe on all platform with an
> > ISA bus...
> 
> Okay, well, I myself didn't produce this, and I couldn't tell offhand
> if it was bogus or not.

	I can't either, that's why we need to check it.

> I presumed bugreporter made happy and spraying
> it across the debian userbase was enough to verify it at runtime. From
> what you're telling me, this is not the case.

	IrDA is a special case because there are few users and most
are still using 2.4.X.

> Can you recommend people to do this kind of testing?

	Me. I'll also post the patch to the linux-irda mailing list.

> Apparently people aren't entirely happy with "dump it on lkml and wait
> for an ack or nak", which I've noted for future reference, but probably
> won't have a need to consider again (it's very rare that I have to deal
> with changes I didn't write myself or are otherwise in areas I don't
> have much knowledge about).

	I'm not a full time Linux hacker, I follow lkml from the
archive. No big deal.

> OTOH, it was easier to find than buried in
> a distro BTS and/or cvs, not that that makes it ideal.

	Debian is usually very good sending me bug reports (especiall
on wireless tools), so I'm a bit surprised that it did not work this
time. But I've seen a recent trend by Debian to do more Debian
specific stuff for system level config, which I find disturbing.

> -- wli

	Thanks !

	Jean
