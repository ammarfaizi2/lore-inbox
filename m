Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTE0XfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTE0XfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:35:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:46065 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264448AbTE0XfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:35:15 -0400
Date: Tue, 27 May 2003 16:46:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: WimMark I report for 2.5.70-mm1
Message-Id: <20030527164612.3249bfe5.akpm@digeo.com>
In-Reply-To: <20030527225519.GL32128@ca-server1.us.oracle.com>
References: <20030527225519.GL32128@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 23:48:29.0509 (UTC) FILETIME=[7953EF50:01C324AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> WimMark I report for 2.5.70
>
> Runs:  1005.78 958.80 947.23
>
> WimMark I report for 2.5.70-mm1
> 
> Runs (deadline): 717.27 1064.57 1089.13
> Runs (anticipatory):  1342.93 1121.47 1330.42
> ...
> 	WimMark I run results are archived at
> http://oss.oracle.com/~jlbec/wimmark/wimmark_I.html

This is nuts.  WimMark keeps on showing 2:1 swings in throughput when no
other test shows any variation at all.  I simply do not know what to make
of it.

Your results would appear to indicate that the regression between
2.5.69-mm5 and 2.5.69-mm8 was actually due to something in Linus's tree,
and it is now in 2.5.70.

I have an interdiff here between the linus.patch from mm5 and mm8 and it
contains nothing very interesting.

It's at http://www.zip.com.au/~akpm/linux/patches/stuff/wimmark-interdiff.txt

The actual diff is at
http://www.zip.com.au/~akpm/linux/patches/stuff/wimmark-interdiff.patch.gz

There is the bio split stuff in ll_rw_blk.c, but that shouldn't matter.

Which device driver are you using?
