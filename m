Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277633AbRJRJ11>; Thu, 18 Oct 2001 05:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277636AbRJRJ1R>; Thu, 18 Oct 2001 05:27:17 -0400
Received: from mk-smarthost-2.mail.uk.worldonline.com ([212.74.112.72]:20753
	"EHLO mk-smarthost-2.mail.uk.worldonline.com") by vger.kernel.org
	with ESMTP id <S277633AbRJRJ1I>; Thu, 18 Oct 2001 05:27:08 -0400
To: linux-kernel@vger.kernel.org
From: kernelhacker@lineone.net
Subject: Success report:[CFT][PATCH] hogstop + eatcache fixes 2.4.12-ac3
Message-Id: <E15u9Sm-0002jb-00@mk-smarthost-2.mail.uk.worldonline.com>
Date: Thu, 18 Oct 2001 10:27:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have found the above patch to provide _massive_ performance/responsivity gains in everyday, workstation use.

System:
1.2Ghz Athlon in abit KT7A board
256MB PC100 SDRAM

Typical session uses:
- ximian gnome 1.4
- multiple nautilus windows
- multiple mozilla windows
- staroffice
- Forte IDE (Sun, Java)
- Evolution PIM
- large image manipulation in GIMP
- kernel recompiles
- dd'ing and burning of CD images
- mp3 streaming.

Up until now the system has swapped prematurely (failing to dump the disk cache left over after e2fsck on reboot), has become very unresponsive and mp3 playback often breaks up.

With this patch I am unable to get mp3 playback to break up, with all but the most excessive loads (fork of death, "ls -w 100000" etc).  It is really nice to see memory being freed up in advance of it being needed, so that the system is not reduced to thrashing when loading a heavy weight app like Forte.

Good work Rik; this is 2.4 vm/mm as it should be.  A good iterative step for the next 2.4 -ac patch :)

Andrew
