Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbRCMWdl>; Tue, 13 Mar 2001 17:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRCMWdF>; Tue, 13 Mar 2001 17:33:05 -0500
Received: from zeus.kernel.org ([209.10.41.242]:39395 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131232AbRCMWcV>;
	Tue, 13 Mar 2001 17:32:21 -0500
Message-Id: <m14cuLL-0005khC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: another Cyrix/mtrr problem?
To: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2001 13:20:27 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I've seen a few other posts on the subject, I might as well
poke my head out of the foxhole long enough to get shot at :-).

System is a Tyan S1590S motherboard (Apollo MVP3 chipset) with
Cyrix MII 300 processor, NVIDIA GeForce2 MX AGP video card, 2.4.2
kernel, XFree86-4.0.2, and the NVIDIA 0.9-6 driver.  Everything worked
great with the 2.4.1 kernel, XFree86-4.0.1, and the NVIDIA 0.9-5 driver
(patched to compile with 2.4.X kernels).  With the current setup, the
NVIDIA driver fails to set up a desired write-combining memory range and
disables AGP support.  If I try to force the issue by configuring
the NVIDIA driver to use the kernel's AGPGART support, the console
switches to graphics mode and then becomes completely unresponsive
to input other than tracking mouse cursor movement.  The only safe
way I've found to restore console functionality is to login remotely
and reboot the machine: killing the X server and associated apps won't
do the trick.

If anyone is interested in working this issue, I can/will forward a
copy of a representative /var/log/XFree86.0.log file showing what
happens for the case of using the NVIDIA driver's internal AGP support.
Within the log file are the following two lines that pretty much sum
it up:

(WW) NVIDIA(0): Failed to set up write-combining range (0xd8000000,0x2000000)
(II) NVIDIA(0): AGP is disabled

Jeff Hartmann (AGPGART support) thinks this is probably a MTRR issue.
I'm leaning that way, given a recent posting by someone else having
MTRR problems with his Cyrix 6x86.

Anyone that can help troubleshoot this and/or provide a fix would be
greatly appreciated.  Thanks in advance!

Sincerely,
--Bob Tracy
rct@frus.com
