Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTDVQKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTDVQKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:10:09 -0400
Received: from lucidpixels.com ([66.45.37.187]:46020 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263275AbTDVQKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:10:03 -0400
Date: Tue, 22 Apr 2003 12:22:06 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p300
To: linux-kernel@vger.kernel.org
cc: copycat@jx165.net
Subject: HPT366/368/370 IDE/SCSI-EMULATION PROBLEMS (2.4.x)
Message-ID: <Pine.LNX.4.55.0304221213510.25378@p300>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war@p300:~$ find /usr/src/linux-2.4.20/Documentation/ | grep -i hpt
war@p300:~$

The top of /usr/src/linux-2.4.20/drivers/ide/hpt366.c does not offer much
in terms of the documentation.

Hopefully my question is simple, why does this card only seem to work with
such a configuration?

I have 3 cards, 12 HDD.

If I try to boot with normal (no append), the box will sit there trying to
find the hard drives.

If I boot with the way most distros set it up (ie: sda=noprobe
sdb=noprobe) and so on, this works, but then it uses SCSI-EMULATION.

I am familiar with PROMISE BOARDS (100/133) and they do not have this
problem.

Is there something in particular one must do to achieve IDE access, to
have the kernel see the HDD's as IDE devices and not use SCSI-EMULATION
for HPT ROCKET ATA/100 cards?

Also, when you cat /proc/ide/hpt* it gives a segfault and the kernel
oopses, I've sent this e-mail a week or two ago.

So, to summarize:

Boot with IDE support only and no append, the box sits there looking for
the other IDE hard drives (using intel i845 chipset btw).
It looks forever, was on for 2 weeks, never found the disks.

Switched over to distro method, sda=noprobe,sdb=noprobe and so on for all
12 drives and testing with rh73/scsi-emulation/etc IS enabled, and the
kernel does a lot of running around and sets them up as SCSI devices.

Is it possible to have HPT rocket ATA/100 cards (3 of them) see hard
drives as IDE and not SCSI?


