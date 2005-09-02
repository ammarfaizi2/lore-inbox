Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbVIBGaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbVIBGaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbVIBGaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:30:05 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10135 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161001AbVIBGaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:30:01 -0400
Date: Fri, 2 Sep 2005 16:29:31 +1000
From: Nathan Scott <nathans@sgi.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050902162931.A4496772@wobbly.melbourne.sgi.com>
References: <20050902003915.GI3657@stusta.de> <20050902053356.GA20603@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050902053356.GA20603@taniwha.stupidest.org>; from cw@f00f.org on Thu, Sep 01, 2005 at 10:33:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 10:33:56PM -0700, Chris Wedgwood wrote:
> On Fri, Sep 02, 2005 at 02:39:15AM +0200, Adrian Bunk wrote:
> 
> > 4Kb kernel stacks are the future on i386, and it seems the problems
> > it initially caused are now sorted out.
> 
> Not entirely.
> 
> XFS when mixed with raid/lvm/nfs still blows up.  It's probably not
> alone in this respect but worse than ext2/3.

To clarify, you mean AND not OR (/) there -- in other words,
raid[+raid]+dm[+dm]+xfs+nfs can be fatal, yes.

We have no known failing cases other than several-deep stacked
driver cases which are also likely evil for other filesystems,
as you say.  Which is not to say I'm in support of this patch..
just don't keep dissing XFS for this, we went and made a number
of at-times-painful changes to make this option work as best it
can.

cheers.

-- 
Nathan
