Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRDCABL>; Mon, 2 Apr 2001 20:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbRDCABC>; Mon, 2 Apr 2001 20:01:02 -0400
Received: from blackhole.compendium-tech.com ([206.55.153.26]:3580 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S131586AbRDCAAs>; Mon, 2 Apr 2001 20:00:48 -0400
Date: Mon, 2 Apr 2001 16:59:30 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Boris Pisarcik <boris@acheron.sk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Question about SysRq
In-Reply-To: <20010331230454.A801@Boris>
Message-ID: <Pine.LNX.4.30.0104021654340.29684-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Mar 2001, Boris Pisarcik wrote:
> on say tty2. The processes get created pretty fast. After a short while
> I supposed a single solution to this to kill all session by alt+sysrq+k,
> but nothing happened. Under normal averagely loaded situation, this will
> imidiately kill all processes on current vt and bring getty prompt.
> Shouldn't it function similiarily in former case ? I see all processes on vt
> get SIGKILL, so what's hapenned ? Maybe I had to wait
> a bit longer for kernel to accomplish that ? Killing all processes with init
> (alt+sysrq+i) seems to be immediate.
>
>
> Thought, i really love all sysrq properties of linux, so i need less often
> to make hardware resets an then await and fear, what fsck will print.
> One more property, that i'd like to have should be request key to force the
> most basic text mode (say 80x25) on the console, when eg. X freezes and
> i kill its session, then last gfx mode resides on the screen and see no way
> to restore back the text mode - /usr/bin/reset or something alike will not
> do it. But it seems to be not a good idea at all, does it ?

I've noticed a similar situation:

I recently upgraded to XFree86 4.0.3 and have been having nothing but
problems with it. Often times, the machine will crash, with crap shot to
the screen. Howver, the IP stack still functions, routes packets, but none
of the user processes respond. I'll try and hit sysrq-s to sync the disks,
sysrq-u to unmount them, and sysrq-b to boot the machine. Unfortunately,
the only one that responds is sysrq-b, which boots the box without
syncing or unmounting the disks. Not only does that piss me off but it's
led to some fs corruption as well (which pisses me off even more). sysrq-b
is the *only* combination I can get working when this happens. However,
when the machine is *not* locked, sysrq-[su] work fine. Kernel is
2.4.3-pre6 on SMP i686.

 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

