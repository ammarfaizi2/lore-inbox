Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWAEX0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWAEX0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWAEX0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:26:45 -0500
Received: from h-64-105-110-66.cmbrmaor.covad.net ([64.105.110.66]:10553 "EHLO
	mail.w1nr.net") by vger.kernel.org with ESMTP id S1750969AbWAEX0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:26:44 -0500
From: "Mike McCarthy, W1NR" <mike@w1nr.net>
To: <linux-hams@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <ralf@linux-mips.org>
Subject: 2.6.15 ax25 system lockup with kissattach
Date: Thu, 5 Jan 2006 18:26:43 -0500
Message-ID: <008401c6124f$7ceed0e0$3849a8c0@lan.w1nr.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
thread-index: AcYST3zE4MhQWdo2RvODWzGRuSUTAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using SuSE 10.0 with 2.6.15 kernel built from source or via SuSE kotd
rpm.  The system will hang when issuing kissattach command.

># /etc/ax25/ax25d.conf
>#
># ax25d Configuration File.
>#
># AX.25 Ports begin with a '['.
>#
>[W1NR VIA 2m]
>parameters      2 1 6 900 * 15 0
>NOCALL   * * * * * * L
>default  * * * * * * - root /spider/src/client client %s ax25

># /etc/ax25/axports
>#
># The format of this file is:
>#
># name callsign speed paclen window description
>#
>2m      W1NR-9          19200   255     2       145.650 MHz (1200 bps)


Following is a trace of commands issued:


>worf:~ # modprobe -v mkiss
>insmod /lib/modules/2.6.15-20060103193109-debug/kernel/lib/crc16.ko
>insmod /lib/modules/2.6.15-20060103193109-debug/kernel/net/ax25/ax25.ko
>insmod
/lib/modules/2.6.15-20060103193109-debug/kernel/drivers/net/hamradio/mkiss.k
o
>worf:~ # kissattach /dev/ttyS0 2m 44.56.10.3
>AX.25 port 2m bound to device ax0


That's all folks.  System locked up hard.  Caps lock and scroll lock lights
flashing.  System needs a hard reset.

2.6.14-5 appears to be fine.  Tried recompiled tools and libraries as well.
Others report similar problems on Debian systems with 2.6.15 kernel as well.

Mike McCarthy, W1NR

