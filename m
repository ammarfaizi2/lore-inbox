Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292939AbSB1KIY>; Thu, 28 Feb 2002 05:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293232AbSB1KGK>; Thu, 28 Feb 2002 05:06:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30224 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293229AbSB1KCw>; Thu, 28 Feb 2002 05:02:52 -0500
Date: Thu, 28 Feb 2002 10:59:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: /proc/mounts: two different loop devices mounted on same mountpoint?!
Message-ID: <20020228095948.GG774@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernel 2.4.17:

pavel@amd:~/misc$ cat /proc/mounts
/dev/root / ext2 rw 0 0
/dev/hda3 /suse ext2 rw 0 0
none /proc proc rw 0 0
none /proc/bus/usb usbdevfs rw 0 0
/dev/cfs0 /overlay coda rw 0 0
/dev/loop0 /mnt ext2 rw 0 0
/dev/loop1 /mnt ext2 rw 0 0
pavel@amd:~/misc$

Both /dev/loop0 *and* /dev/loop1 mounted on /mnt at same time? Oops?
What's the semantics of that? [And I guess it should not be allowed)

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
