Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318046AbSHCWcg>; Sat, 3 Aug 2002 18:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318030AbSHCWba>; Sat, 3 Aug 2002 18:31:30 -0400
Received: from dsl-213-023-022-101.arcor-ip.net ([213.23.22.101]:64701 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318020AbSHCWan>;
	Sat, 3 Aug 2002 18:30:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Sun, 4 Aug 2002 00:35:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17aiJv-0007cr-00@starship> <E17b725-00031K-00@starship> <3D4C5BBB.EBD49EA3@zip.com.au>
In-Reply-To: <3D4C5BBB.EBD49EA3@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17b7Up-0003FJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 August 2002 00:39, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > Wait a second guys, the problem is with the script, look at those CPU
> > numbers:
> > 
> > > ./daniel.sh  39.78s user 71.72s system 368% cpu 30.260 total
> > > quad:/home/akpm> time ./daniel.sh
> > > ./daniel.sh  38.45s user 70.00s system 365% cpu 29.642 total
> > 
> > They should be 399%!!  With my fancy script, the processes themselves are
> > getting serialized somehow.
> > 
> > Lets back up and try this again with this pair of scripts, much closer to
> > the original:
> 
> Still 360%.  I did have a version which achieved 398%, but it
> succumbed to the monthly "why is there so much junk in my home
> dir" disease.
> 
> But it doesn't matter, does it?  We're looking at deltas here.

It matters a whole lot.  If we aren't saturating the CPUs then we're not
testing what we think we're testing.

-- 
Daniel
