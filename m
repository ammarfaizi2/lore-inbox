Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbSLGGh3>; Sat, 7 Dec 2002 01:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267732AbSLGGh3>; Sat, 7 Dec 2002 01:37:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:57811 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264972AbSLGGh2>;
	Sat, 7 Dec 2002 01:37:28 -0500
Message-ID: <3DF198EC.CDAB69D1@digeo.com>
Date: Fri, 06 Dec 2002 22:45:00 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] max bomb segment tuning with read latency 2 patchin  
 contest
References: <3DF18D38.F493636C@digeo.com> <1039242017.2855.26.camel@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 06:45:00.0533 (UTC) FILETIME=[2A169250:01C29DBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GrandMasterLee wrote:
> 
> ...
> One interesting thing about my current setup, with all scsi or FC disks,
> is that bomb never displays > 0.
> Example:
> 
> elvtune /dev/sdn yields:
> 
> /dev/sdn elevator ID            17
>         read_latency:           8192
>         write_latency:          16384
>         max_bomb_segments:      0
> 
> elvtune -b 6 /dev/sdn yields:
> 
> /dev/sdn elevator ID            17
>         read_latency:           8192
>         write_latency:          16384
>         max_bomb_segments:      0
> 
> Is it because I just do volume management at the hardware level and use
> whole disks? Or is that something else?

You need a patched kernel.  max_bomb_segments is some old thing
which isn't implemented any more.  But I reused it for something
completely different in the patch which Con is testing.  So I
wouldn't have to futz around with patching userspace apps.
