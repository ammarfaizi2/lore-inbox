Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSIYAlG>; Tue, 24 Sep 2002 20:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSIYAlG>; Tue, 24 Sep 2002 20:41:06 -0400
Received: from packet.digeo.com ([12.110.80.53]:29623 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261855AbSIYAlF>;
	Tue, 24 Sep 2002 20:41:05 -0400
Message-ID: <3D910755.17280DD8@digeo.com>
Date: Tue, 24 Sep 2002 17:46:13 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
References: <20020924132031.GJ6070@holomorphy.com> <3D90A532.4B95C06B@digeo.com> <20020925001826.GM6070@holomorphy.com> <3D9103EB.FC13A744@digeo.com> <20020925003952.GF3530@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2002 00:46:13.0749 (UTC) FILETIME=[F2F84250:01C2642C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
>...
> c01053dc 9194801  60.668      poll_idle
> c01175db 1752528  11.5633     .text.lock.sched
> c0114c08 1281763  8.45717     load_balance
> c0106408 388517   2.56346     .text.lock.semaphore

lock_super in the ext2 block allocator, I bet.

Al was making noises about nailing that.  Per-blockgroup
rwlocks would be neat.
