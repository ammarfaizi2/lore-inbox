Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTAWEQQ>; Wed, 22 Jan 2003 23:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTAWEQQ>; Wed, 22 Jan 2003 23:16:16 -0500
Received: from [65.39.167.210] ([65.39.167.210]:55563 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S264844AbTAWEQP>;
	Wed, 22 Jan 2003 23:16:15 -0500
Date: Wed, 22 Jan 2003 23:25:24 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Andrew Morton <akpm@digeo.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: why isn't quota dependant on ext2?
In-Reply-To: <20030122134844.2a74c588.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301222323320.7312-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Andrew Morton wrote:
> > >> > ext3, ufs and udf also use the core quota code.
> > >>
> > >> The documentation says it only works with ext2 where would I find working
> > >> utilities to get it working on ext3 ?
> > >
> > > ext3 uses the same tools as ext2 - checkquota, quotaon, etc.
> > >
> > > http://quota-tools.sourceforge.net/ (site seems to be broken)
> >
> > The bad news is that quota on ext3 is virtually guaranteed
> > to deadlock, so you can do it, but you do not want to do it.
>
> Darnit, I had all that working 18 months ago ;)
>
> > The original memo describes a deadlock in RH 2.4.18-5, which
> > I assure you, was NOT fixed in Marcelo 2.4.20.
>
> Yes, that's a common ext3 problem.  A journal_start()/journal_stop() pair is
> the same, for locking purposes, as down()/up().  So they need to be ranked
> consistently.
>
> Let me crunch on that a bit...
>

Thanks for the warning .. I was just about to restart my attempt at
sparc+ext3+quota.

	Gerhard

PS the help item for quota states that it only functions with ext2.


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

