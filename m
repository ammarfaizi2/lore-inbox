Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSKISo0>; Sat, 9 Nov 2002 13:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262444AbSKISo0>; Sat, 9 Nov 2002 13:44:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:51631 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262442AbSKISoZ>;
	Sat, 9 Nov 2002 13:44:25 -0500
Message-ID: <3DCD5917.FEEA7C5D@digeo.com>
Date: Sat, 09 Nov 2002 10:51:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: kernel BUG at kernel/timer.c:333!
References: <aqj8bf$ff2$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2002 18:51:03.0428 (UTC) FILETIME=[F407D440:01C28820]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> 
> I can reliably crash 2.5.X on one of our newsservers (dual PIII/450, GigE,
> lots of disk- and network I/O).
> 
> The last crash I posted here was a bit garbled. So I tried again,
> this one is clean. Crash appears to be timer related ?
> 
> kernel BUG at kernel/timer.c:333!

There are timer fixes in Linus's current tree.  The problem which
they address could cause this BUG.

>..
> Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
> Call Trace:
>  [<c0117be8>] __might_sleep+0x54/0x58
>  [<c013578c>] set_shrinker+0x3c/0x7c
>  [<c01686b4>] mb_cache_create+0x1c4/0x244
>  [<c0168380>] mb_cache_shrink_fn+0x0/0x170
>  [<c01050ab>] init+0x47/0x1ac
>  [<c0105064>] init+0x0/0x1ac
>  [<c0106e8d>] kernel_thread_helper+0x5/0xc

That's different.  A fix for this is in Linus's tree.

So..  Please grab an update from
ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/
or retest 2.5.47.
