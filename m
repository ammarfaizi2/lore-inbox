Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSJJAUu>; Wed, 9 Oct 2002 20:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSJJAUu>; Wed, 9 Oct 2002 20:20:50 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:34505 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263137AbSJJAUs>; Wed, 9 Oct 2002 20:20:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>, Oleg Drokin <green@namesys.com>
Subject: Re: [Ext2-devel] Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Date: Thu, 10 Oct 2002 02:27:01 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
References: <20021001195914.GC6318@stingr.net> <20021004195315.A14062@namesys.com> <20021004170935.GX3000@clusterfs.com>
In-Reply-To: <20021004170935.GX3000@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021010002624Z16709-1663+72@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 19:09, Andreas Dilger wrote:
> On Oct 04, 2002  19:53 +0400, Oleg Drokin wrote:
> > On Tue, Oct 01, 2002 at 02:43:30PM -0600, Andreas Dilger wrote:
> > > What is very interesting from the above results is that the CPU usage
> > > is _much_ smaller for ext3+htree than for reiserfs.  It looks like
> > 
> > This is only in case of deletion, probably somehow related to constant item
> > shifting when some of the items are deleted.
> 
> Well, even for creates it is 19% less CPU.  The re-tested wall-clock
> time for htree creates is now less than the CPU usage of reiserfs, so
> it is impossible for reiserfs to achieve this number without
> optimization of the code somehow.  For deletes the cpu usage of htree
> is 40% less, but we are currently not doing leaf block compaction, so
> there would probably be a slight performance hit to merge blocks
> (although we have some plans to do that efficiently also).

I convinced myself at some point that compaction will cost no more
than a couple of percent for deletes and nothing for creates.

-- 
Daniel
