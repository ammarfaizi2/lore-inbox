Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319853AbSINEOg>; Sat, 14 Sep 2002 00:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319854AbSINEOg>; Sat, 14 Sep 2002 00:14:36 -0400
Received: from 96-39.everestkc.net ([64.126.96.39]:1287 "HELO
	alfred.home.cyborgworkshop.com") by vger.kernel.org with SMTP
	id <S319853AbSINEOg>; Sat, 14 Sep 2002 00:14:36 -0400
Date: Fri, 13 Sep 2002 18:20:11 -0500 (CDT)
From: Jason Baker <baker@cyborgworkshop.com>
X-X-Sender: baker@alfred.home.cyborgworkshop.com
To: Kernel Development List <linux-kernel@vger.kernel.org>
Subject: Bug in 2.4.19 RAM Disk handling
Message-ID: <Pine.LNX.4.44.0209131815480.2460-100000@alfred.home.cyborgworkshop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I may have come across a bug in the way that 2.4.19 handles RAM
disks.  When creating a RAM disk, you can only use /dev/ram0, regardless
of what device you specify to use.

I have a project that uses a lot of Ram Disks, and as such, I create them
on /dev/ram0, /dev/ram1, etc.  When I upgraded to kernel 2.4.19 from
2.4.18 doing a make oldconfig and not selecting any new options, I can now
only creat a ram disk on /dev/ram0.  If I try to create a ram disk on
/dev/ram1 after creating one on /dev/ram0, I get an error about /dev/ram0
already being in use.  Downgrading to kernel 2.4.18 does not exhibit this
behaviour, I can make multiple RAM disks.


                 Jason


