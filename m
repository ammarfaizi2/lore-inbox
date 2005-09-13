Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVIMIF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVIMIF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVIMIF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:05:57 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:18573 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932435AbVIMIF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:05:56 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Tue, 13 Sep 2005 10:05:52 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Neil Brown <neilb@suse.de>
Cc: Nathan Scott <nathans@sgi.com>, Chris Wedgwood <cw@f00f.org>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050913080552.GA1815@localhost.localdomain>
References: <20050902003915.GI3657@stusta.de> <20050902053356.GA20603@taniwha.stupidest.org> <20050902162931.A4496772@wobbly.melbourne.sgi.com> <17175.62454.623678.209697@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17175.62454.623678.209697@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 04:40:54PM +1000 Neil Brown wrote:

> On Friday September 2, nathans@sgi.com wrote:
> > On Thu, Sep 01, 2005 at 10:33:56PM -0700, Chris Wedgwood wrote:
> > > On Fri, Sep 02, 2005 at 02:39:15AM +0200, Adrian Bunk wrote:
> > > 
> > > > 4Kb kernel stacks are the future on i386, and it seems the problems
> > > > it initially caused are now sorted out.
> > > 
> > > Not entirely.
> > > 
> > > XFS when mixed with raid/lvm/nfs still blows up.  It's probably not
> > > alone in this respect but worse than ext2/3.
> > 
> > To clarify, you mean AND not OR (/) there -- in other words,
> > raid[+raid]+dm[+dm]+xfs+nfs can be fatal, yes.
> 
> It should be reasonably simple to remove this problem of stacked
> drivers.
> There really isn't any need for md and dm (or md and md or ..) to use
> the stack and the same time.
> 

Sorry to bump in so late - but there seems to be a reporter who is
suffering from these issues now:

http://bugzilla.kernel.org/show_bug.cgi?id=5210
