Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTIGSNp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbTIGSNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:13:44 -0400
Received: from mailproxy3.netcologne.de ([194.8.194.221]:15276 "EHLO
	mailproxy3.netcologne.de") by vger.kernel.org with ESMTP
	id S263424AbTIGSNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:13:11 -0400
Date: Sun, 7 Sep 2003 20:13:10 +0200
From: Meinolf Sander <uce@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: "PCI: Error while updating region" with es1371 module
Message-ID: <20030907181310.GA738@messina.my-fqdn.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an Ensoniq sound card but can't load the appropriate module:

ms@pluto:~$ sudo modprobe es1371
es1371: version v0.32 time 19:28:00 Sep  7 2003
PCI: Enabling device 00:0a.0 (0001 -> 0003)
/lib/modules/2.4.22/kernel/drivers/sound/es1371.o: init_module:
No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
[...]

ms@pluto:~$ dmesg | grep 00:0a
PCI: Cannot allocate resource region 2 of device 00:0a.0
PCI: Error while updating region 00:0a.0/2 (00001001 != 00001009)
[ this message seems to come from ../arch/i386/kernel/pci-i386.c ]
PCI: Enabling device 00:0a.0 (0000 -> 0003)
PCI: Enabling device 00:0a.0 (0001 -> 0003)
[ last line another three times repeated ]

ms@pluto:~$ lspci | grep 1371
00:0a.0 Class 1371: Ensoniq ES1371 [AudioPCI-97] (rev 7c)

ms@pluto:/proc$ grep -B1 -A3 Ensoniq /proc/pci
Bus  0, device  10, function  0:
Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 8).
Master Capable.  No bursts.  Min Gnt=12.Max Lat=128.
Non-prefetchable 32 bit memory at 0x20000000 [0x2000003f].
I/O at 0x1000 [0x1007].

ms@pluto:~$ uname -a
Linux pluto 2.4.22 #4 Sun Sep 7 19:25:27 CEST 2003 i686 GNU/Linux


Any ideas what's going wrong here?


Thanks,
Meinolf
