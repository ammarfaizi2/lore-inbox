Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVLERz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVLERz0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVLERz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:55:26 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:7879 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1751387AbVLERzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:55:25 -0500
Date: Mon, 5 Dec 2005 18:55:18 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, Mark Lord <lkml@rtr.ca>,
       Rob Landley <rob@landley.net>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205175518.GA21928@merlin.emma.line.org>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Mark Lord <lkml@rtr.ca>, Rob Landley <rob@landley.net>,
	Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <200512042131.13015.rob@landley.net> <4394681B.20608@rtr.ca> <1133800090.21641.17.camel@mindpipe> <20051205164418.GA12725@merlin.emma.line.org> <1133803048.21641.48.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133803048.21641.48.camel@mindpipe>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005, Lee Revell wrote:

> On Mon, 2005-12-05 at 17:44 +0100, Matthias Andree wrote:
> > This constant shifting the blame on someone else is becoming
> > offensive.
> > 
> > Diligent maintainers put "INCOMPATIBLE CHANGES" sections up front in
> > their release announcements or notes, that is the upstream
> > maintainer's chance to state "wpa_supplicant version >= 1.2.3
> > required" and really pass the buck on to the distros. Without such
> > upgrade-required-for: notes, it's just rude. "We break everything but
> > you need to find out for
> > yourself which..."
> > 
> 
> I'm not trying to shift blame, I am just saying that with their access
> to a larger hardware and user base the distros are in a much better
> position to regression test changes than the kernel developers.

You just described what shifting burden or blame means.

Are you seriously saying it's the distributors' fault for not trying the
random monkey patch on end users machines?

Heck, SUSE 9.2 ate a complete server because SUSE (they take the blame)
didn't manage to (1) notice in time, (2) therefore package a CRITICAL
(as in causes data corruption) MegaRAID bugfix. Do you really want such
things to happen as intrinsic part of the kernel development? Do the
upstream gurus such as Linus and Andrew want that? If so, they can say
so and we'll see the companies running for their sheer lives and putting
their money into other kernels.

BSD makes it only easier to provide binary modules, because you don't
even have to discuss with anyone if it's derived work or not, you can
just embrace, extend and lock the beast up and everyone in.

> And I didn't even mention the cases where the distros just don't do
> their homework.  For example in order to insulate users from internal
> changes ALSA has a kernel and userspace (alsa-lib) component and both
> must be upgraded in sync to properly support new hardware.  This is
> common knowledge.  But many distros keep shipping kernel upgrades that
> introduce new ALSA drivers but don't bother to make the kernel upgrade
> depend on an alsa-lib upgrade, or even to make a newer alsa-lib
> available.

Major distros usually aim for small and well-audited changes in order
not to make things worse, at least where end-user support is concerned.

Given the development pace and the ridiculous policy which is
effectively "you may break everything in the two weeks after release,
and we'll collect those fixes that come in until Linus's machine works
and ship without the rest".

Basically, no-one should have permission to touch any core parts, except
for fixes, until 2.7. Yes, that means going back to older models. Yes,
that means that the discussions will start all over. And yes, that means
that the cool stuff has to wait. Solution: release more often.

I'm so bold as to claim that a new minor release every 6 months with a
tight "only fixes allowed as core changes" policy would satisfy many. Of
course you cannot break the binary driver of the day that way, but it
also means fewer chances to break NFS, XFS, MegaRAID and whatnot.

-- 
Matthias Andree
