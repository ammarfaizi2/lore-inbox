Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129799AbRBYDfz>; Sat, 24 Feb 2001 22:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129800AbRBYDfp>; Sat, 24 Feb 2001 22:35:45 -0500
Received: from mnh-1-08.mv.com ([207.22.10.40]:49415 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129799AbRBYDfj>;
	Sat, 24 Feb 2001 22:35:39 -0500
Message-Id: <200102250446.XAA03828@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.39-2.4.2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 24 Feb 2001 23:46:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.2 is available.

For the particularly paranoid, the ubd device now has the option of doing all 
writes O_SYNC, either as a config option for all devices or on a 
device-by-device basis.  This is thanks to Lennert Buytenhek.

A couple of hostfs bugs were fixed.

A crash involving breakpoints set at the very beginning or very end of an 
interrupt handler was fixed.

SIGFPE is now passed along to processes correctly.

The SIGIO handler tries harder to empty file descriptors by giving tasklets 
more chances to feed the input to a process.

A crash involving the tracing thread trying, and failing, to allocate memory 
was fixed.

Fixed a race which caused timer interrupts to stop being handled.

Temporary files are not created in /tmp.  This apparently provides a noticable 
performance improvement when tmpfs is mounted on /tmp.  This is also due to 
Lennert.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at http://sourceforge.net/project/filelist.php?group_id
=429 (which Sourceforge has managed to break) and ftp://ftp.nl.linux.org/pub/um
l/

				Jeff


