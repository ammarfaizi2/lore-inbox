Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRJHCSz>; Sun, 7 Oct 2001 22:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276764AbRJHCSp>; Sun, 7 Oct 2001 22:18:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57401 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276761AbRJHCSi>; Sun, 7 Oct 2001 22:18:38 -0400
To: Pavel Machek <pavel@Elf.ucw.cz>
Cc: Jeremy Elson <jelson@circlemud.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices
In-Reply-To: <20011002204836.B3026@bug.ucw.cz>
	<200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu>
	<20011005205136.A1272@elf.ucw.cz>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 07 Oct 2001 20:09:11 -0600
In-Reply-To: <20011005205136.A1272@elf.ucw.cz>
Message-ID: <m1n132x4qg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@Elf.ucw.cz> writes:

> Hi!
> 
> > >> Sorry to follow-up to my own post.  A few people pointed out that
> > >> v1.00 had some Makefile problems that prevented it from building.
> > >> I've released v1.02, which should be fixed.
> > >
> > >This should be forwared to linmodem list... Killing all those
> > >binary-only modem drivers from kernel modules would be good
> > >thing... Hmm, and maybe we can just hack telephony API over ltmodem
> > >and be done with that. That would be good.
> [snip]
> > Perhaps I don't understand how linmodems work to understand well
> > enough how FUSD would apply - do you talk to linmodems through the
> > serial driver?  If so, sounds like a good application - but we might
> 
> Yep. And linmodem driver does signal processing, so it is big and
> ugly. And up till now, it had to be in kernel. With your patches, such
> drivers could be userspace (where they belong!). Of course, it would be 
> very good if your interface did not change...

I don't see how linmodem drivers apply.  At least not at the low-level
because you actually have to driver the hardware, respond to interrupts
etc.  On some of this I can see a driver split like there is for the video
card drivers, so the long running portitions don't have to be in the kernel.

I actually don't see what devices could be done in user space with
this context except possibly forwarding device calls across the
network.

Eric
