Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129965AbRAOAkK>; Sun, 14 Jan 2001 19:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbRAOAkB>; Sun, 14 Jan 2001 19:40:01 -0500
Received: from alex.intersurf.net ([216.115.129.11]:26380 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S129965AbRAOAjz>; Sun, 14 Jan 2001 19:39:55 -0500
Message-ID: <XFMail.20010114183953.markorr@intersurf.com>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sun, 14 Jan 2001 18:39:53 -0600 (CST)
Reply-To: Mark Orr <markorr@intersurf.com>
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-ac9 works, but slower and swappier
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been running 2.4.0-ac9 for a day and a half now.

I have pretty low-end hardware (Pentium 1/ 100MHz, 16Mb RAM,
17Mb swap)  and it really seems to bog down with anything
heavy in memory.    Netscape seems to really drag, and any
Java applets I encounter positively crawl -- you can see
the individual widgets being drawn.

My previous kernel was 240-ac4, and it was fine.


Oh, one other thing...cat /proc/filesystems shows:

nodev   sockfs
nodev   swapfs
nodev   shm
nodev   pipefs
nodev   proc
        ext2
nodev   devpts

I thought swapfs _replaces_  shm?   I mention this because
my startup scripts mount'ed shm the way it always does.
I figured it'd fail because shm wouldnt be there.  I've
since disabled that.

So,  mount swapfs to /dev/shm, and leave the shm filesystem
unmounted?   Go back to the way it was before (mounting to
/var/shm) ??

W/ swapfs (only) mounted,  MITSHM apps like MpegTV, Virtual
Gameboy, Xanim, etc.  seem to work okay.

--
Mark Orr
markorr@intersurf.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
