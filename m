Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263554AbSIQDQb>; Mon, 16 Sep 2002 23:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263570AbSIQDQb>; Mon, 16 Sep 2002 23:16:31 -0400
Received: from packet.digeo.com ([12.110.80.53]:59066 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263554AbSIQDQa>;
	Mon, 16 Sep 2002 23:16:30 -0400
Message-ID: <3D869FA8.7A50BC91@digeo.com>
Date: Mon, 16 Sep 2002 20:21:12 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Anton Blanchard <anton@samba.org>, Lev Makhlis <mlev@despammed.com>,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [RFC] [PATCH] [2.5.35] Run Queue Statistics
References: <20020917025907.GB15189@krispykreme> <Pine.LNX.4.44L.0209170007110.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 03:21:12.0731 (UTC) FILETIME=[464A4EB0:01C25DF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 17 Sep 2002, Anton Blanchard wrote:
> 
> > On a semi related note, vmstat wants to know the number of running,
> > blocked and swapped processes. strace vmstat one day and you will see it
> > currently opens /proc/*/stat (ie one open for each process) just to get
> > these stats.  Yet another place where the monitoring utilities disturb
> > the system way too much.
> >
> > Can we get some things in /proc/stat to give us these numbers? Does
> > "swapped" make any sense on Linux?

Certainly sounds good.  Opening every /proc/<pid>/stat is gross.

> Runnable can be done currently, blocked on IO is trivial once
> Andrew has pushed the iowait stats to Linus.
> 

That'll be a while off yet. I'd like to make sure that we have
all the externally visible changes stable for a week or so,
/proc/diskstats settled down, userspace updated and tested etc.

Just to minimise the disruption and churn which these changes
will cause.
