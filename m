Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268631AbSIRVfo>; Wed, 18 Sep 2002 17:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268915AbSIRVfo>; Wed, 18 Sep 2002 17:35:44 -0400
Received: from packet.digeo.com ([12.110.80.53]:20733 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268631AbSIRVfn>;
	Wed, 18 Sep 2002 17:35:43 -0400
Message-ID: <3D88F2D7.DD8519E6@digeo.com>
Date: Wed, 18 Sep 2002 14:40:39 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [BENCHMARK] contest results for 2.5.36
References: <1032360386.3d8891c2bc3d3@kolivas.net> <3D88ACB6.6374E014@digeo.com> <1032383868.3d88ed7c4cf2d@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Sep 2002 21:40:39.0053 (UTC) FILETIME=[07B1FBD0:01C25F5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> Quoting Andrew Morton <akpm@digeo.com>:
> 
> [snip..]
> 
> > page_add/remove_rmap.  Be interesting to test an Alan kernel too.
> 
> Just tell me which ones to test and I'll happily throw them in too.

That's OK - you're already doing -rmap.  I just can't read.

> ...
> > If the IO load was against the same disk 2.5 _should_ have sucked,
> > due to the writes-starves-reads problem which we're working on.  So
> > I assume it was against a different disk.  In which case 2.5 should not
> > have shown these improvements, because all the fixes for this are still
> > in -mm.  hm.  Helpful, aren't I?
> 
> It's the same disk. These are the correct values after I've fixed all known
> problems in contest. I need someone else to try contest with a different disk.
> Helpful? This is all new so it will take a while for _anyone_ to understand
> exactly what's going on I'm sure. Since we haven't had incremental benchmarks
> till now, who knows what it was that made IO full mem drop from 146 to 74 in the
> first place?

Strange.  2.5 should have done badly.  There are many variables...

We're on top of the VM latency problems now.  Jens is moving ahead
with the deadline scheduler which appears to provide nice linear
tunability of the read-versus-write policy.  Once we sort out the
accidental writes-starve-read problem we'll do well at this.
