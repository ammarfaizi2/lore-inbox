Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268703AbTBZKPv>; Wed, 26 Feb 2003 05:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268704AbTBZKPv>; Wed, 26 Feb 2003 05:15:51 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:23560 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S268703AbTBZKPu>; Wed, 26 Feb 2003 05:15:50 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: About /etc/mtab and /proc/mounts
Date: Wed, 26 Feb 2003 10:26:07 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b3i4nv$sud$1@news.cistron.nl>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1046255167 29645 62.216.29.200 (26 Feb 2003 10:26:07 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3E5C8682.F5929A04@daimi.au.dk>,
Kasper Dupont  <kasperd@daimi.au.dk> wrote:
>A simpler solution, that does not require changes to the kernel
>would be to just move mtab to a more apropriate location. My
>suggestion would be to change it from /etc/mtab to /mtab.d/mtab.
>Then you could mount a tmpfs filesystem on /mtab.d. Or by making
>/mtab.d a symlink, you can get the mtab file whereever you want,
>including /etc.

/dev/shm ? Supposed to be there on many systems anyway. Fix
'mount' and 'umount' so that if they see /etc/mtab is a symlink,
they follow it and create the temp files etc in the destination
directory of the link instead of in /etc. Then
ln -sf /dev/shm/mtab /etc/mtab et voila

I've been thinking of doing this for Debian.

Mike.
-- 
Anyone who is capable of getting themselves made President should
on no account be allowed to do the job -- Douglas Adams.

