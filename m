Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130517AbRCDUvS>; Sun, 4 Mar 2001 15:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130518AbRCDUvI>; Sun, 4 Mar 2001 15:51:08 -0500
Received: from mail.lightband.com ([199.79.199.3]:43529 "EHLO
	mail.lightband.com") by vger.kernel.org with ESMTP
	id <S130517AbRCDUuw>; Sun, 4 Mar 2001 15:50:52 -0500
Message-ID: <20010304205046.15690.qmail@alongtheway.com>
Date: Sun, 4 Mar 2001 20:50:46 +0000
From: Jim Breton <jamesb-kernel@alongtheway.com>
To: linux-kernel@vger.kernel.org
Subject: eject weirdness on NEC disc changer, kernel 2.4.2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I've gotten a response from the "eject" author and he seems to
agree that this is something in the kernel causing this issue.

Anyone got any ideas?  Thanks.

(P.S. I am not subscribed currently, please copy me on responses.
Gracias.)

----- Forwarded message from Jim Breton -----

From: Jim Breton
Date: Sat, 3 Mar 2001 21:34:47 +0000
Subject: eject weirdness on NEC disc changer, kernel 2.4.2

Package: eject
Version: 2.0.2-1
Severity: wishlist

Hi Jeff and Martin, I'm running a Debian 2.2r2 potato box which has an
ATAPI NEC cd changer:

$ grep NEC /var/log/dmesg 
hdd: NEC CD-ROM DRIVE:251, ATAPI CD/DVD-ROM drive

I have 4 audio CDs in the drive.  When I run the following command:

eject -c 1

it switches to slot 2 (as it should), but when I play a track off the
CD, it starts several seconds into the track rather than at the
beginning.

When I do the following:

eject -c 2
eject -c 3

I get the following in syslog:

Mar  3 16:11:30 tarkin kernel: VFS: Disk change detected on device
ide1(22,64)
Mar  3 16:11:51 tarkin kernel: hdd: irq timeout: status=0xd0 { Busy }
Mar  3 16:11:51 tarkin kernel: hdd: ATAPI reset complete

and the drive switches me back to the first slot.

If I have a data CD in a slot, I do not see this problem.

Any idea what is going on?  I tried a copy compiled straight from the
source and the same thing happens.  Considering data CDs do not make
this happen, do you think the kernel is doing something odd?  Should the
kernel really care what kind of CD is in the drive before I try to read
it?  Or is this something caused by eject?

Thanks.

P.S. I just tried cdctl ( http://sourceforge.net/projects/cdctl/ ) and
apparently the same thing occurs, so it's looking like this may be a
kernel issue.  My former kernel was 2.2.19pre9 and I didn't have any
problems there (or on any of my other 2.2.x kernels).

----- End forwarded message -----
