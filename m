Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292911AbSCIUfc>; Sat, 9 Mar 2002 15:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292915AbSCIUfW>; Sat, 9 Mar 2002 15:35:22 -0500
Received: from web14808.mail.yahoo.com ([216.136.224.224]:8714 "HELO
	web14808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292911AbSCIUfJ>; Sat, 9 Mar 2002 15:35:09 -0500
Message-ID: <20020309203507.19088.qmail@web14808.mail.yahoo.com>
Date: Sat, 9 Mar 2002 12:35:07 -0800 (PST)
From: Rock Gordon <rockgordon@yahoo.com>
Subject: kswapd/kupdated
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel version: 2.4.16

What does kupdated actually do ? I have a system where
kupdated and bdflush take over both cpus, and the
system freezes for 10 minutes ... there's no disk
space left on the 2TB XFS file system, striped RAID0
by an MD device over 2 1TB arrays. Assuming normal
UNIX/POSIX functionality, XFS should return ENOSPC ...
but it doesn't ... it still spins like hell trying to
scavenge the 40k of disk space that's left of the 2TB
filesystem.

This seems to cause kupdated/bdflush to spin like
crazy ...

The 2 1TB arrays are 13 disk hardware RAID5 arrays,
with no hot spare.

Any clues ?


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
