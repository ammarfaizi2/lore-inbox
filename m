Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130375AbRCBJBB>; Fri, 2 Mar 2001 04:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130380AbRCBJAw>; Fri, 2 Mar 2001 04:00:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3603 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130375AbRCBJAl>; Fri, 2 Mar 2001 04:00:41 -0500
Date: Fri, 2 Mar 2001 10:00:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Pavel Machek <pavel@suse.cz>, Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
Message-ID: <20010302100036.H15061@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20000101020213.D28@(none)> <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Mar 01, 2001 at 03:54:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  I was hoping to point out that in real life, most systems that
> > > need to access large numbers of files are already designed to do
> > > some kind of hashing, or at least to divide-and-conquer by using
> > > multi-level directory structures.
> > 
> > Yes -- because their workaround kernel slowness.
> 
> Pavel, I'm afraid that you are missing the point. Several, actually:
> 	* limits of _human_ capability to deal with large unstructured
> sets of objects

Okay, then. Let's take example where I met with huge directories.

I'm working with timetables (timetab.sourceforge); at one point, I
download 100000 html files, each with one train. I'm able to deal with
that, just fine. After all, there is no structure in there. If I
wanted to add structure there, I'd have to invent some. I don't want
to. I feel just fine with 100000 files. I type its number, and it
works.

Due to kernel/nfs slowness with such huge directories, I had to split
it into several directories (each with 10000 entries). Now it gets
ugly. I was perfectly able to deal with 100000 entries, but having 10
directories is real pain.

> The point being: applications and users _do_ know better what structure
> is there. Kernel can try to second-guess them and be real good at

And if there's none? Did you take a look at netscape cache? It does
hashing to workaround kernel slowness. Yes, I think it would be much
nicer if it did not workaround anything.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
