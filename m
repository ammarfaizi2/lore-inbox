Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262422AbSJNUno>; Mon, 14 Oct 2002 16:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262424AbSJNUno>; Mon, 14 Oct 2002 16:43:44 -0400
Received: from packet.digeo.com ([12.110.80.53]:46784 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262422AbSJNUnm>;
	Mon, 14 Oct 2002 16:43:42 -0400
Message-ID: <3DAB2DD9.B78639C5@digeo.com>
Date: Mon, 14 Oct 2002 13:49:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Mansfield <lkml@dm.cobite.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] raw over raid5: BUG at drivers/block/ll_rw_blk.c:1967
References: <Pine.LNX.4.44.0210141627360.2876-100000@admin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2002 20:49:29.0492 (UTC) FILETIME=[30D5A540:01C273C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield wrote:
> 
> Hi everyone,
> 
> I haven't been able to run raw over raid5 since 2.5.30 or so, but every
> time I'm about to report it, a new kernel comes out and the problem
> changes completely :-( Now I'm finally going to start getting out the info
> it the hopes someone can fix it.  The oops was triggered by attempting to
> read from /dev/raw/raw1 (bound to /dev/md0) using dd.  System info
> follows oops:
> 
> ------------[ cut here ]------------
> kernel BUG at drivers/block/ll_rw_blk.c:1967!

I don't think you told us the kernel version?

There have been recent fixes wrt sizing of the BIOs which the
direct-io layer sends down.  So please make sure that you're
testing Linus's current -bk, or 2.5.42 plus

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.42/2.5.42-mm2/broken-out/dio-bio-add-fix-1.patch

Either that, or raid5 is bust ;)
