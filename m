Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbSJ0VgQ>; Sun, 27 Oct 2002 16:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbSJ0VgQ>; Sun, 27 Oct 2002 16:36:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:51427 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262631AbSJ0VgP>;
	Sun, 27 Oct 2002 16:36:15 -0500
Message-ID: <3DBC5DC3.8641A66C@digeo.com>
Date: Sun, 27 Oct 2002 13:42:27 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Pauses in 2.5.44 (some kind of memory policy change?)
References: <200210272127.NAA03536@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2002 21:42:27.0806 (UTC) FILETIME=[BEA09FE0:01C27E01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> ...
>  1  0  2      0  45252  31420 142520    0    0     0     0 3573   349  9 38 53
> 
> ...Started /usr/bin/mail around here...
> 
>  1  0  2      0  30024  31420 157636    0    0     0     0 6540   510 20 80  0
>  1  0  2      0  14908  31420 172544    0    0     0     0 6433   499 16 84  0
>  3  0  2      0   9196  31420 178172    0    0     0 17152 6939   259  3 97  0
>  1  0  1      0   2452  31420 185112    0    0     0  4056 4061   278  9 91  0
>  0  0  0      0   2636  31420 184848    0    0     0     0 1294   195  2  6 92
> 
> ...Pause occurred around here...
> 
>  1  0  1      0   2664  31420 184848    0    0     0  4004 1766    55  0 44 56
>  0  0  0      0   2676  31420 184848    0    0     0    40 1103   282  2  3 95
>  0  0  0      0   2676  31420 184848    0    0     0     0 1064   169  0  0 100

Sorry, don't know.

It's possible that your X server got paged out, but the system
doesn't seem to be under any sort of stress, and there's not
much page reclaim happening and no evidence of executable pagein.

I'm assuming that everything is on local disks apart from that
mail file.  Really, you haven't told me much.  What's all that
`bo' activity there?  What filesystems are in use?

Could it be a networking problem?  Are your keyboard and mouse
dependent on ethernet traffic in any way (eg: executables on
NFS).

Did the vmstat output exhibit any stalls?

What makes you believe it's a vm/fs thing rather than a keyboard/mouse
thing?

So hm.  You'll need to investigate further please.
