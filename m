Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289161AbSCCV4A>; Sun, 3 Mar 2002 16:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSCCVzv>; Sun, 3 Mar 2002 16:55:51 -0500
Received: from ligur.expressz.com ([212.24.178.154]:36236 "EHLO expressz.com")
	by vger.kernel.org with ESMTP id <S289161AbSCCVzl>;
	Sun, 3 Mar 2002 16:55:41 -0500
Date: Sun, 3 Mar 2002 22:55:29 +0100 (CET)
From: "BODA Karoly jr." <woockie@expressz.com>
To: linux-kernel@vger.kernel.org
Subject: something's wrong with the ps/2 mouse driver (or devfs error?)
Message-ID: <Pine.LNX.3.96.1020303224656.16346A-100000@ligur.expressz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

	Sometimes the gpm segfaults I don't know why. Now X dropped the
mouse control too. Here is the log which gpm wrote:

Mar  3 22:41:46 binky /usr/sbin/gpm[194]: oops() invoked from gpm.c(182)
Mar  3 22:41:46 binky /usr/sbin/gpm[194]: /dev/psaux: No such device or address
Mar  3 22:43:30 binky /usr/sbin/gpm[10837]: oops() invoked from gpm.c(993)
Mar  3 22:43:30 binky /usr/sbin/gpm[10837]: /dev/psaux: No such device or address
Mar  3 22:46:27 binky /usr/sbin/gpm[10862]: PS/2 mouse failed init
Mar  3 22:46:27 binky /usr/sbin/gpm[10862]: oops() invoked from gpm.c(1019)
Mar  3 22:46:27 binky /usr/sbin/gpm[10862]: mouse initialization failed: Inappropriate ioctl for device

	The 3rd try to start gpm was successful. After I quit X and
restart didn't started:

(**) Option "Device" "/dev/input/mice"
(EE) xf86OpenSerial: Cannot open device /dev/input/mice
        No such file or directory.
(EE) Generic Mouse: cannot open input device
(EE) PreInit failed for input device "Generic Mouse"
(II) UnloadModule: "mouse"
(WW) No core pointer registered
No core pointer

	In ~20 sec I've tried to start X again and it works now. The gpm
did segfault earlier too but X did't drop the control over the mouse.

binky:~# uname -a
Linux binky 2.4.19-pre2-ac1 #1 Sat Mar 2 04:28:17 CET 2002 i686 unknown
binky:~# gpm -v
gpm 1.19.6, Thu Oct  4 00:21:21 CEST 2001

	There is devfs in the kernel but is not mounted.

-- 
						Woockie
..."what is there in this world that makes living worthwhile?"
Death thought about it. "CATS," he said eventually, "CATS ARE NICE."
			           (Terry Pratchett, Sourcery)

