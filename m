Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268345AbTBSQdF>; Wed, 19 Feb 2003 11:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268373AbTBSQdF>; Wed, 19 Feb 2003 11:33:05 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:23960 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268345AbTBSQdF> convert rfc822-to-8bit; Wed, 19 Feb 2003 11:33:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrew Morton <akpm@digeo.com>, t.baetzler@bringe.com
Subject: Re: filesystem access slowing system to a crawl
Date: Wed, 19 Feb 2003 17:42:34 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <20030205013909.6a8c04a3.akpm@digeo.com>
In-Reply-To: <20030205013909.6a8c04a3.akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302191742.02275.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 February 2003 10:39, Andrew Morton wrote:

Hi Andrew,

> > Running just "find /" (or ls -R or tar on a large directory) locally
> > slows the box down to absolute unresponsiveness - it takes minutes
> > to just run ps and kill the find process. During that time, kupdated
> > and kswapd gobble up all available CPU time.
> Could be that your "low memory" is filled up with inodes.  This would
> only happen in these tests if you're using ext2, and there are a *lot*
> of directories.
> I've prepared a lineup of Andrea's VM patches at
> It would be useful if you could apply 10_inode-highmem-2.patch and
> report back.  It applies to 2.4.19 as well, and should work OK there.
is there any reason why this (inode-highmem-2) has never been submitted for 
inclusion into mainline yet?

ciao, Marc
