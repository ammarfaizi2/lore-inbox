Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRB0QvI>; Tue, 27 Feb 2001 11:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129607AbRB0QvA>; Tue, 27 Feb 2001 11:51:00 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:31475 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129595AbRB0Qu2>; Tue, 27 Feb 2001 11:50:28 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102271650.f1RGoGr27040@webber.adilger.net>
Subject: Re: Massive Corruption
In-Reply-To: <20010226181009.B25911@lapurapus.ver.megared.net.mx> from MC_Vai
 at "Feb 26, 2001 06:10:09 pm"
To: MC_Vai <estoy@ver.megared.net.mx>
Date: Tue, 27 Feb 2001 09:50:16 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MC Vai writes:
> 	I have a problem with my filesystem, the kernel panics
> 	as soon as it tries to mount the root filesystem.
> 
> 	I guess it is because of the IDE bug in the driver
> 	Russell found, but he (Russell) suggest me to post
> 	my message here.
> 
> 	What I've tried up to now:
> 	~~~~~~~~~~~~~~~~~~~~~~~~~
> 	% e2fsck -B 4096 /dev/<part>
> 	% e2fsck -B 8192 /dev/<part>
> 	... (16384, 32768, etc.)
> 
> 	% e2fsck -b 4097 /dev/<part>
> 	% e2fsck -b 8193 /dev/<part>
> 	... (16385, 32769, etc.)

There is a tool called gpart which will search a disk for filesystem
headers and such, and will optionally re-build your partition table
(if it is corrupted).  You should give it a try.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
