Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbRBPJet>; Fri, 16 Feb 2001 04:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129887AbRBPJej>; Fri, 16 Feb 2001 04:34:39 -0500
Received: from mx1.nameplanet.com ([213.203.30.51]:23311 "HELO
	mx1.nameplanet.com") by vger.kernel.org with SMTP
	id <S129886AbRBPJe0>; Fri, 16 Feb 2001 04:34:26 -0500
Date: Fri, 16 Feb 2001 10:37:08 +0100 (CET)
From: Ketil Froyn <ketil@froyn.com>
To: <linux-kernel@vger.kernel.org>
Subject: out of memory?
Message-ID: <Pine.LNX.4.30.0102161009230.829-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm getting lots of this on a computer:
VM: do_try_to_free_pages failed for myprog.pl
VM: do_try_to_free_pages failed for myprog.pl
VM: do_try_to_free_pages failed for myprog.pl
....
VM: do_try_to_free_pages failed for kupdate (just saw this once)

myprog is basically making lots of directories, and is not using lots of
memory. Here's the info from 'ps auxw':

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root       994 22.6  0.3  2568  364 tty1     R    Feb15 230:40 perl -w myprog.pl

It doesn't seem like I'm out of memory:
$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  97730560 96149504  1581056  2125824  5447680  5115904
Swap: 68083712 35213312 32870400
MemTotal:     95440 kB
MemFree:       1544 kB
MemShared:     2076 kB
Buffers:       5320 kB
Cached:        4996 kB
SwapTotal:    66488 kB
SwapFree:     32100 kB
$ uname -a
Linux localhost.localdomain 2.2.18RAID #6 Wed Feb 14 19:15:49 CET 2001 \
i586 unknown

The kernel is compiled with the rh-7.0 kgcc (egcs-2.91.66), and I've
patched it to get raid 0.90 and reiserfs 3.5.29.

What's going on? How bad is this?

Ketil Froyn

