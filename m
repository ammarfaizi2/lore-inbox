Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132695AbRDOQXy>; Sun, 15 Apr 2001 12:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132696AbRDOQXp>; Sun, 15 Apr 2001 12:23:45 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:16228 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S132695AbRDOQXf>; Sun, 15 Apr 2001 12:23:35 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: lk@tantalophile.demon.co.uk, phillips@nl.linux.org
Subject: Re: [RFC] Ext2 Directory Index - File Structure
Cc: acahalan@cs.uml.edu, linux-kernel@vger.kernel.org
Message-Id: <20010415162320Z92253-21911+19@humbolt.nl.linux.org>
Date: Sun, 15 Apr 2001 18:23:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Daniel Phillips wrote:
> > Jamie Lokier wrote:
> > > Daniel Phillips wrote:
> > > > ls already can't handle the directories I'm working with on a regular
> > > > basis.  It's broken and needs to be fixed.  A merge sort using log n
> > > > temporary files is not hard to write.
> > >
> > > ls -U | sort
> > >
> > > should do the trick.
> >
> > Um, yep.  Now ls should do that itself instead of giving up with an error.
>
> Sorting 1 million 30-character strings does not require temporary files
> on a machine with > 35 MB anyway, and that can be virtual, so if anyone
> cares about ls sorting huge directories I suggest improving the
> in-memory sort.

I got this today:

	ls -U <big directory> 
	ls: Memory exhausted

Since this occured while nothing else was active, it's probably a MM bug
and I will chase it further.  However, it also shows that ls is well and
truly borked.  If anybody is going to work on it I'd suggest not only
improving the in-memory sort but adding a custom file-based sort or exec
sort as a fallback.
--
Daniel
