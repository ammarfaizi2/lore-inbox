Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSGPPTW>; Tue, 16 Jul 2002 11:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSGPPTV>; Tue, 16 Jul 2002 11:19:21 -0400
Received: from [195.223.140.120] ([195.223.140.120]:50706 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317861AbSGPPTU>; Tue, 16 Jul 2002 11:19:20 -0400
Date: Tue, 16 Jul 2002 17:22:11 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716152211.GA29154@dualathlon.random>
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 11:11:20AM -0400, Gerhard Mack wrote:
> On Tue, 16 Jul 2002, Stelian Pop wrote:
> 
> > Date: Tue, 16 Jul 2002 14:49:56 +0200
> > From: Stelian Pop <stelian.pop@fr.alcove.com>
> > To: Gerhard Mack <gmack@innerfire.net>
> > Cc: Mathieu Chouquet-Stringer <mathieu@newview.com>,
> >      linux-kernel@vger.kernel.org
> > Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
> >
> > On Tue, Jul 16, 2002 at 08:22:53AM -0400, Gerhard Mack wrote:
> >
> > > > This needs to be "according to Linus, dump is deprecated". Given the
> > > > interest Linus has manifested for backups, I wouldn't really rely on
> > > > his statement :-)
> > >
> > > Either way dump is not likely to give you a reliable backup when used
> > > with a 2.4.x kernel.
> >
> > Since you are so well informed, maybe you could share your knowledge
> > with us.
> >
> > I'm the dump maintainer, so I'll be very interested in knowing how
> > comes that dump works for me and many other users... :-)
> >
> 
> I'll save myself the trouble when Linus said it better than I could:
> 
>      Note that dump simply won't work reliably at all even in
>      2.4.x: the buffer cache and the page cache (where all the
>      actual data is) are not coherent. This is only going to
>      get even worse in 2.5.x, when the directories are moved
>      into the page cache as well.
> 
>      So anybody who depends on "dump" getting backups right is
>      already playing russian rulette with their backups.  It's
>      not at all guaranteed to get the right results - you may
>      end up having stale data in the buffer cache that ends up
>      being "backed up".
> 
> 
> In other words you have a backup system that works some of the time or
> even most of the time... brilliant!

just to clarify, the above implicitly assumes the fs is mounted
read-write while you're dumping it. if the fs is mounted readonly or if
it's unmounted, there is no problem with dumping it. Also note that dump
has the same problem with read-write mounted fs also in 2.2, and I guess
in 2.0 too, it's nothing new of 2.4, it just gets more visible the more
logical dirty caches we have.

Andrea
