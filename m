Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268491AbTBNXrO>; Fri, 14 Feb 2003 18:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268489AbTBNXpR>; Fri, 14 Feb 2003 18:45:17 -0500
Received: from wall.ttu.ee ([193.40.254.238]:5903 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id <S268482AbTBNXot>;
	Fri, 14 Feb 2003 18:44:49 -0500
Date: Sat, 15 Feb 2003 01:54:42 +0200 (EET)
From: Siim Vahtre <siim@pld.ttu.ee>
To: <linux-kernel@vger.kernel.org>
Subject: swap never cleaned up
Message-ID: <Pine.SOL.4.31.0302150140440.28624-100000@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Since moving from 2.5.59 to 2.5.60 I've noticed some strange
behaviour with swap managment. For some unknown reason the
swapspace starts to fill up but it will NEVER get freed.
Hence, it is first time in my life when I actually see swap
used more than 20M on this computer!

Anyway, after some time I am in situation where swap is 100% used
and I can't do anything (fork: Cannot allocate memory) although
I have practically no programs running at all.

Making more swapspace is useless, because new swap will eventually
be bloated aswell. The only solution I found was to use "swapoff",
which makes some heavy i/o and sometimes kills few random processes
(bash, screen) but frees the swap. After using "swapon", it starts to
be filled up again. Using "swapoff" also mysteriously frees about 50M
of RAM from nowhere. Otherwise the memory managment seems to be OK.

Swap that I use (according to "file") is "Linux/i386 swap file
(new style) 1 (4K pages) size 15623 pages (64M)". Note that it
doesn't matter if the swap is in /dev/hda2 or in /swapfile, either
way it is never cleaned up.

I don't know if it matters but I've got 128M of RAM (which is more
than enough for me) and have tmpfs mounted.

I would be glad to test this oddness further if you wish.
Just tell me what to do.


