Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317770AbSGPPIZ>; Tue, 16 Jul 2002 11:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317857AbSGPPIY>; Tue, 16 Jul 2002 11:08:24 -0400
Received: from h209-71-227-55.gtconnect.net ([209.71.227.55]:27155 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S317770AbSGPPIY>;
	Tue, 16 Jul 2002 11:08:24 -0400
Date: Tue, 16 Jul 2002 11:11:20 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Stelian Pop <stelian.pop@fr.alcove.com>
cc: Mathieu Chouquet-Stringer <mathieu@newview.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <20020716124956.GK7955@tahoe.alcove-fr>
Message-ID: <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Stelian Pop wrote:

> Date: Tue, 16 Jul 2002 14:49:56 +0200
> From: Stelian Pop <stelian.pop@fr.alcove.com>
> To: Gerhard Mack <gmack@innerfire.net>
> Cc: Mathieu Chouquet-Stringer <mathieu@newview.com>,
>      linux-kernel@vger.kernel.org
> Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
>
> On Tue, Jul 16, 2002 at 08:22:53AM -0400, Gerhard Mack wrote:
>
> > > This needs to be "according to Linus, dump is deprecated". Given the
> > > interest Linus has manifested for backups, I wouldn't really rely on
> > > his statement :-)
> >
> > Either way dump is not likely to give you a reliable backup when used
> > with a 2.4.x kernel.
>
> Since you are so well informed, maybe you could share your knowledge
> with us.
>
> I'm the dump maintainer, so I'll be very interested in knowing how
> comes that dump works for me and many other users... :-)
>

I'll save myself the trouble when Linus said it better than I could:

     Note that dump simply won't work reliably at all even in
     2.4.x: the buffer cache and the page cache (where all the
     actual data is) are not coherent. This is only going to
     get even worse in 2.5.x, when the directories are moved
     into the page cache as well.

     So anybody who depends on "dump" getting backups right is
     already playing russian rulette with their backups.  It's
     not at all guaranteed to get the right results - you may
     end up having stale data in the buffer cache that ends up
     being "backed up".


In other words you have a backup system that works some of the time or
even most of the time... brilliant!

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

