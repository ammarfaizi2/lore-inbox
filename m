Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSD3TG2>; Tue, 30 Apr 2002 15:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSD3TG1>; Tue, 30 Apr 2002 15:06:27 -0400
Received: from omega.erc.wisc.edu ([128.104.186.172]:59144 "EHLO
	omega.erc.wisc.edu") by vger.kernel.org with ESMTP
	id <S315170AbSD3TG0>; Tue, 30 Apr 2002 15:06:26 -0400
Date: Tue, 30 Apr 2002 14:06:20 -0500
From: John Moser <jmoser@erc.wisc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18 + ide timeout
Message-ID: <Pine.SGI.4.33.0204301400080.5566404-100000@erc2000.erc.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You'll have to excuse my lack of exact details, as I'm at work and the
machine in question is at home.

In any case, I'm using the 2.4.18 kernel patched with Hedrick's 2.4.18 IDE
patch (I needed this to detect the full size of my 160 GB drives).

I'm utilizing Promise ATA 100 (aka PDC20268 iirc) controllers (support has
been compiled into the kernel).

However, on bootup, I get the following messages (or very very similar.  I
had to copy it off another msg I found elsewhere)

hdf: set_drive_speed_status: status=0xff { Busy }
Warning: Primary channel requires an 80-pin cable for operation.
hdf reduced to Ultra33 mode.
hdf: set_drive_speed_status: status=0xff { Busy }
hdf: status timeout: status=0xff { Busy }
hdf: drive not ready for command

etc per drive

However, I'm definately using a high quality 80-conductor cable.
Furthermore,

Apr 29 09:44:44 cerberus kernel:  hde:hde: status timeout: status=0xff {
Busy }
Apr 29 09:44:44 cerberus kernel:  hdf:hdf: status timeout: status=0xff {
Busy }
Apr 29 09:44:44 cerberus kernel:  hdg:hdg: status timeout: status=0xff {
Busy }
Apr 29 09:44:44 cerberus kernel:  hdh:hdh: status timeout: status=0xff {
Busy }

is displayed in the system log.

Obviously  I can't access the drives at this point.  I'm pretty sure this
is a known error, as I've seen several references to it elsewhere.
However, I have yet to find a solution.

This wasn't a problem with 2.5.0, but I couldn't find a 2.5.0 IDE patch
that supports > 128 GB drives (2.5.8 wouldn't compile for me).

Thanks in advance,
-John Moser

