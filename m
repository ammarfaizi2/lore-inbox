Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbUCSNuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbUCSNuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:50:00 -0500
Received: from ns.suse.de ([195.135.220.2]:17032 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262998AbUCSNt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:49:58 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Peter Zaitsev <peter@mysql.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <405AA9D9.40109@namesys.com>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
	 <1079642801.2447.369.camel@abyss.local>
	 <1079643740.11057.16.camel@watt.suse.com>
	 <1079644190.2450.405.camel@abyss.local>
	 <1079644743.11055.26.camel@watt.suse.com>  <405AA9D9.40109@namesys.com>
Content-Type: text/plain
Message-Id: <1079704347.11057.130.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Mar 2004 08:52:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 03:05, Hans Reiser wrote:
> Chris Mason wrote:
> 
> >On Thu, 2004-03-18 at 16:09, Peter Zaitsev wrote:
> >  
> >
> >>On Thu, 2004-03-18 at 13:02, Chris Mason wrote:
> >>
> >>    
> >>
> >>>>In the former case cache is surely not flushed. 
> >>>>
> >>>>        
> >>>>
> >>>Hmmm, is it reiser?  For both 2.4 reiserfs and ext3, the flush happens
> >>>when you commit.  ext3 always commits on fsync and reiser only commits
> >>>when you've changed metadata.
> >>>      
> >>>
> >>Oh. Yes. This is Reiser, I did not think it is FS issue.
> >>I'll know to stay away from ReiserFS now.
> >>    
> >>
> >
> >For reiserfs data=ordered should be enough to trigger the needed
> >commits.  If not, data=journal.  Note that neither fs does barriers for
> >O_SYNC, so we're just not perfect in 2.4.
> >
> >-chris
> >
> You are not listening to Peter.  As I understand it from what Peter says 
> and your words, your implementation is wrong, and makes fsync 
> meaningless.  If so, then you need to fix it.  fsync should not be 
> meaningless even for metadata only journaling.  This is a serious bug 
> that needs immediate correction, if Peter and I understand it correctly 
> from your words.

I am listening to Peter, Jens and I have spent a significant amount of
time on this code.  We can go back and spend many more hours testing and
debugging the 2.4 changes, or we can go forward with a very nice
solution in 2.6.

I'm planning on going forward with 2.6

-chris


