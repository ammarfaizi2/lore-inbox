Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282176AbRK1Xbd>; Wed, 28 Nov 2001 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282179AbRK1XbY>; Wed, 28 Nov 2001 18:31:24 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:23481 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S282176AbRK1XbN>;
	Wed, 28 Nov 2001 18:31:13 -0500
Message-Id: <5.1.0.14.2.20011128232246.00aea8f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 28 Nov 2001 23:31:14 +0000
To: Jens Axboe <axboe@suse.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: 2.5.1-pre2 bio offset by one error in VIA IDE
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011128132000.T23858@suse.de>
In-Reply-To: <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
 <15364.3457.368582.994067@gargle.gargle.HOWL>
 <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

I just booted my Athlon VIA KT133 chipset box with 2.5.1-pre2 only to 
discover it dropped me into single user mode because /dev/hda2 could not be 
mounted. (Rebooting into 2.5.0+viro patch everything is ok, back into 
2.5.1-pre2 is broken...)

Looking with hexedit /dev/hda2 when booted into 2.5.1-pre2 the first sector 
contains junk, the second sector contains the real data that I see as the 
first sector when booted into 2.5.0+viro fix.

That suggests to me there is an off by one error in the VIA IDE driver in 
the 2.5.10pre2 kernel causing the partition to start one sector earlier 
than it should.

If you would like any further information / patch testing / whatever let me 
know.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

