Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273383AbRINNJC>; Fri, 14 Sep 2001 09:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273382AbRINNIv>; Fri, 14 Sep 2001 09:08:51 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:30887 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S273380AbRINNIm>; Fri, 14 Sep 2001 09:08:42 -0400
Date: Fri, 14 Sep 2001 08:09:04 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200109141309.IAA86711@tomcat.admin.navo.hpc.mil>
To: otto.wyss@bluewin.ch, linux-kernel@vger.kernel.org
Subject: Re: How errorproof is ext2 fs?
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Wyss <otto.wyss@bluewin.ch>:
> While reading the thread about "HFS Plus on Linux?" at
> "debian-powerpc@list.debian.org" I had the following experience:
> 
> Within an hour I had to hard reset both of my computers, first my Linux-i386 due
> to a complete lockup of the system while using el3diag, second my MacOS-powermac
> due to an not responding USB-keyboard/-mouse (what a nice coincident). Now while
> the Mac restarted without any fuse I had to fix the ext2-fs manually for about
> 15 min. Luckily it seems I haven't lost anything on both system. 
> 
> This leaves me a bad taste of Linux in my mouth. Does ext2 fs really behave so
> worse in case of a crash? Okay Linux does not crash that often as MacOS does, so
> it does not need a good  error proof fs. Still can't ext2 be made a little more
> error proof?
> 
> Okay, there are other fs for Linux which cope better with such a situation, but
> are they really more errorproof or are they just better in fixing up the mess
> afterwards? Could there be more attention in not creating errors instead of
> fixing them afterwards?

I've used linux for about 8 years now. The only time I've had a catastrophic
failure was with a disk drive went south.

About the only times I've seen ext2fs require manual repair is a crash/power
failure during fsck on boot. It doesn't happen very often. Even then, it
may not be a serious falure, just the type of error that requires a choice
in fix - missing inode/partially written inode in the root file system will
usually require the choice of deleting, or putting in lost+found.

No file system is immune to that level of failure. Some are better at
hiding the damage (xfs will lose free data blocks like mad - 3 in a row lost
6GB out of 12, though no used data was (visibly) lost.

15 minutes isn't that bad - wait until you have to spend 30 minutes to
3 hours on an NTFS or FAT32 rebuild, only to find you have to reinstall.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
