Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVLCVNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVLCVNs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVLCVNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:13:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41384 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750863AbVLCVNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:13:47 -0500
Date: Sat, 3 Dec 2005 16:13:29 -0500
From: Dave Jones <davej@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203211329.GC25015@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <20051203205911.GX18919@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203205911.GX18919@marowsky-bree.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 09:59:11PM +0100, Lars Marowsky-Bree wrote:
 > On 2005-12-03T14:56:08, Adrian Bunk <bunk@stusta.de> wrote:
 > 
 > > The current kernel development model is pretty good for people who 
 > > always want to use or offer their costumers the maximum amount of the 
 > > latest bugs^Wfeatures without having to resort on additional patches for 
 > > them.
 > > 
 > > Problems of the current development model from a user's point of view 
 > > are:
 > > - many regressions in every new release
 > > - kernel updates often require updates for the kernel-related userspace 
 > >   (e.g. for udev or the pcmcia tools switch)
 > 
 > Your problem statement is correct, but you're fixing the symptoms, not
 > the cause.
 > 
 > What we need is an easier way for users to pull in kernel updates with
 > the matching kernel-related user-space.
 > 
 > This is provided, though with some lag, by Fedora, openSUSE, Debian
 > testing, dare I say gentoo and others.
 > 
 > The right way to address this is to work with the distribution of your
 > choice to make these updates available faster.

The big problem is though that we don't typically find out that
we've regressed until after a kernel update is in the end-users hands.

In many cases, submitters of changes know that things are going
to break. Maybe we need a policy that says changes requiring userspace updates
need to be clearly documented in the mails Linus gets (Especially if its
a git pull request), so that when the next point release gets released,
Linus can put a section in the announcement detailing what bits
of userspace are needed to be updated.

It still isn't to solve the problem of regressions in drivers, but
that's a problem that's not easily solvable.

		Dave

