Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265741AbRGDIdC>; Wed, 4 Jul 2001 04:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266541AbRGDIcx>; Wed, 4 Jul 2001 04:32:53 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:14093 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S265741AbRGDIcm>; Wed, 4 Jul 2001 04:32:42 -0400
Date: Wed, 4 Jul 2001 10:32:40 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>, <mike_phillips@urscorp.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <01070320292709.00338@starship>
Message-ID: <Pine.LNX.4.33.0107041026140.4236-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001, Daniel Phillips wrote:

> On Monday 02 July 2001 20:42, Rik van Riel wrote:
> > On Thu, 28 Jun 2001, Marco Colombo wrote:
> > > I'm not sure that, in general, recent pages with only one access are
> > > still better eviction candidates compared to 8 hours old pages. Here
> > > we need either another way to detect one-shot activity (like the one
> > > performed by updatedb),
> >
> > Fully agreed, but there is one problem with this idea.
> > Suppose you have a maximum of 20% of your RAM for these
> > "one-shot" things, now how are you going to be able to
> > page in an application with a working set of, say, 25%
> > the size of RAM ?
>
> Easy.  What's the definition of working set?  Those pages that are frequently
> referenced.  So as the application starts up some of its pages will get
> promoted from used-once to used-often.  (On the other hand, the target
> behavior here conflicts with the goal of grouping together several
> temporally-related accesses to the same page together as one access, so
> there's a subtle distinction to be made here, see below.)
[...]

In Rik example, the ws is larger than available memory. Part of it
(the "hottest" one) will get double-accesses, but other pages will keep
condending the few available (physical) pages with no chance of being
accessed twice.  But see my previous posting...

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

