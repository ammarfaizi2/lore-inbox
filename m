Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268830AbTBZXIa>; Wed, 26 Feb 2003 18:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268891AbTBZXIa>; Wed, 26 Feb 2003 18:08:30 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:55980 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268830AbTBZXI3> convert rfc822-to-8bit; Wed, 26 Feb 2003 18:08:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: filesystem access slowing system to a crawl
Date: Thu, 27 Feb 2003 00:17:57 +0100
User-Agent: KMail/1.4.3
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de>
In-Reply-To: <20030219174940.GJ14633@x30.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302270017.36598.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 February 2003 18:49, Andrea Arcangeli wrote:

Hi Marcelo,

apply this, please!

> On Wed, Feb 19, 2003 at 05:42:34PM +0100, Marc-Christian Petersen wrote:
> > On Wednesday 05 February 2003 10:39, Andrew Morton wrote:
> >
> > Hi Andrew,
> >
> > > > Running just "find /" (or ls -R or tar on a large directory) locally
> > > > slows the box down to absolute unresponsiveness - it takes minutes
> > > > to just run ps and kill the find process. During that time, kupdated
> > > > and kswapd gobble up all available CPU time.
> > >
> > > Could be that your "low memory" is filled up with inodes.  This would
> > > only happen in these tests if you're using ext2, and there are a *lot*
> > > of directories.
> > > I've prepared a lineup of Andrea's VM patches at
> > > It would be useful if you could apply 10_inode-highmem-2.patch and
> > > report back.  It applies to 2.4.19 as well, and should work OK there.
> >
> > is there any reason why this (inode-highmem-2) has never been submitted
> > for inclusion into mainline yet?


Marcelo please include this:
http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre4aa3/10_inode-highmem-2
other fixes should be included too but they don't apply cleanly yet
unfortunately, I (or somebody else) should rediff them against mainline.
> Andrea


ciao, Marc


