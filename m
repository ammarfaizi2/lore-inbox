Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVBHPmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVBHPmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 10:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVBHPmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 10:42:25 -0500
Received: from sd291.sivit.org ([194.146.225.122]:9626 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261542AbVBHPmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 10:42:07 -0500
Date: Tue, 8 Feb 2005 16:43:44 +0100
From: Stelian Pop <stelian@popies.net>
To: lm@bitmover.com, Francois Romieu <romieu@fr.zoreil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050208154343.GH3537@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>, lm@bitmover.com,
	Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
References: <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com> <20050204170306.GB3467@crusoe.alcove-fr> <20050204183922.GC27707@bitmover.com> <20050204200507.GE5028@deep-space-9.dsnet> <20050204201157.GN27707@bitmover.com> <20050204214015.GF5028@deep-space-9.dsnet> <20050204233153.GA28731@electric-eye.fr.zoreil.com> <20050205193848.GH5028@deep-space-9.dsnet> <20050205233841.GA20875@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205233841.GA20875@bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 03:38:41PM -0800, Larry McVoy wrote:

> On Sat, Feb 05, 2005 at 08:38:48PM +0100, Stelian Pop wrote:
> > > Nope: he digs the bk-commit mailing list archives.
> > > 
> > Interesting, I fergot about those commit mails, thanks for remining
> > me.
> > 
> > I think those emails could provide the missing piece of the puzzle
> > and we could generate the missing branches based on them. 
> 
> Does that mean you don't need anything from us?

If the kernel development was linear, it could be enough.

But with the branch'n'merge nature of BK it is hard if not impossible
to extract enough data from those patches (I looked at the history
of the last 2 months and I had several patch conflits due to a
changeset being included on several branches which were merged later,
several mails whose date was not the same as the changeset[*]).

What you could make available in the bkcvs export would be, for each
changeset (both for the changesets and for the merged changesets),
include three BKRevs:  the changeset's one, the changeset's parent one,
and the changeset's merge parent one. 

That information could be used to reconstruct the entire tree,
using either bk-commit-head (preferred) or bkbits, provided you
put the BKRev: tag into the bk-commit-head posts too.

Technicaly speaking this should be very easy for you to implement.

What do you think ?

Stelian.

*: for example this one:

ChangeSet 1.2030, 2005/02/02 13:52:52-08:00, torvalds@ppc970.osdl.org

	Merge bk://drm.bkbits.net/drm-linus
	into ppc970.osdl.org:/home/torvalds/v2.6/linux

is translated in CVS into:

1.26549
date    2005.02.03.00.21.37;    author torvalds;        state Exp;

...

1.26549
log
@Merge bk://drm.bkbits.net/drm-linus
into ppc970.osdl.org:/home/torvalds/v2.6/linux

-- 
Stelian Pop <stelian@popies.net>
