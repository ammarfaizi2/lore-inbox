Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbUBCNSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 08:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUBCNSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 08:18:40 -0500
Received: from aurora.fi.muni.cz ([147.251.50.200]:32930 "EHLO
	aurora.fi.muni.cz") by vger.kernel.org with ESMTP id S265998AbUBCNSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 08:18:38 -0500
Date: Tue, 3 Feb 2004 14:18:37 +0100
From: Martin =?iso-8859-2?Q?Povoln=FD?= <xpovolny@aurora.fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040203131837.GF3967@aurora.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have debian's 2.6.0-686-smp only with PNP BIOS disabled (fails to
boot with enabled, as described by other people).

I did

$ mount /cdrom/
$ ls /cdrom/

got listing of files and directories on the cdrom
then

$ cdrecord dev=/dev/hdc -blank=fast -v
...
Blanking time:   21.570s
$ mount /cdrom
$ ls /cdrom

got the listing again!
could even 'cd' to a directory, couldn't read files

$ umount /cdrom
$ eject /cdrom; eject -t /cdrom
$ mount /cdrom

now I got the error which I would expect after erasing the CD and trying
to mount it

seems to me like some cache should have been invalidated, but was not

cdrecord:
    Cdrecord-Clone 2.01a19 (i686-pc-linux-gnu)
cdrom:
    0,0,0     0) 'HL-DT-ST' 'RW/DVD GCC-4480B' '1.00' Removable CD-ROM

p.s. sorry if I'm reporting something already repaired, but I have
searched the archive, changelog and asked google before writing here

-- 
Martin Povolný, xpovolny@fi.muni.cz, http://www.fi.muni.cz/~xpovolny
