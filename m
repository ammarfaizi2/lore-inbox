Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWFJNdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWFJNdl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 09:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWFJNdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 09:33:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2570 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751518AbWFJNdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 09:33:40 -0400
Date: Sat, 10 Jun 2006 15:33:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chase Venters <chase.venters@clientec.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610133343.GA11634@stusta.de>
References: <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <Pine.LNX.4.64.0606091356340.5541@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606091356340.5541@turbotaz.ourhouse>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 02:00:15PM -0500, Chase Venters wrote:
> On Fri, 9 Jun 2006, Chase Venters wrote:
> 
> >On Fri, 9 Jun 2006, Linus Torvalds wrote:
> >
> >>
> >>
> >> On Fri, 9 Jun 2006, Alex Tomas wrote:
> >>> 
> >>>  would "#if CONFIG_EXT3_EXTENTS" be a good solution then?
> >>
> >> Let's put it this way:
> >> - have you had _any_ valid argument at all against "ext4"?
> >>
> >> Think about it. Honestly. Tell me anything that doesn't work?
> >
> >Now, granted, I really do agree with you about the whole code sharing 
> >thing. A fresh start is often just what you need. I'm just questioning if 
> >it wouldn't be better to do this fresh start immediately after going 
> >48-bit, rather than before. That way, existing users that want that extra 
> >umph can have it today.
> >
> 
> Let me clarify that I don't have a final answer or opinion for whether or 
> not 48-bit belongs in ext3 or ext4. But I'm trying to illustrate that it's 
> an important question to raise.
> 
> In Group A we have some number of users that must have 48-bit support by 
> Date B. 48-bit support could be available in ext3 by Date A, before Date 
> B. It could also be available in ext4 by Date X, along with a handful of 
> other features.
> 
> Is Date X before Date B? If it's not, is it worth telling Group A to 
> suffer for a while, or asking them to use ext4 before it's ready? These 
> are the questions I'd have to know the answers to if I were the one 
> casting a final decision.

There are many points mentioned in this discussion like:
- possibility of regressions for existing users
- time until the new code is actually stable and well-tested
- long-term maintainability

The faster availability is a point, but it's only one amongst many 
points.

And it's not that we are talking about a feature not yet available in 
Linux at all. Instead of suffering, couldn't the few people in urgent 
need of 48-bit support use JFS or XFS?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

