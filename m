Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131005AbRACUtI>; Wed, 3 Jan 2001 15:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131051AbRACUs7>; Wed, 3 Jan 2001 15:48:59 -0500
Received: from [216.151.155.116] ([216.151.155.116]:63236 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S131005AbRACUsx>; Wed, 3 Jan 2001 15:48:53 -0500
To: shawn.starr@home.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: SHM Not working in 2.4.0-prerelease
In-Reply-To: <3A537EA8.45889173@home.net>
From: Doug McNaught <doug@wireboard.com>
Date: 03 Jan 2001 15:15:13 -0500
In-Reply-To: Shawn Starr's message of "Wed, 03 Jan 2001 14:34:01 -0500"
Message-ID: <m3g0j0l7e6.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr <shawn.starr@home.net> writes:

> [spstarr@coredump /etc]$ free
>              total       used       free     shared    buffers
> cached
> Mem:         62496      61264       1232          0       1248
> 28848
> 
> 
> There's no shared memory being used?

[...]

> the shmfs is mounted. Is there any configuration i need to get shm
> memory activiated?

The 'shared' field in /proc/meminfo (source for 'top' and 'free') has
nothing to do with {SysV,POSIX} shared memory.  The 'shared' field
referred to memory that was used by more than one process (shared
libraries, shared text segments etc).  As I understand it, under 2.4
the 'shared' field is very expensive to calculate, so we don't--the
zero value is there to avoid breaking programs that parse
/proc/meminfo. 

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
