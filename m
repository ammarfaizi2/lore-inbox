Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbTGDItO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265929AbTGDItO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:49:14 -0400
Received: from home.wiggy.net ([213.84.101.140]:35969 "EHLO
	tornado.home.wiggy.net") by vger.kernel.org with ESMTP
	id S265999AbTGDItC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:49:02 -0400
Date: Fri, 4 Jul 2003 11:03:29 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: 2.4.21 and 2.5.74 freeze on cardmgr start
Message-ID: <20030704090329.GA1975@wiggy.net>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I bought a new laptop recently (dell latitude d600) which seems to be
working reasonably well with Linux, with PCMCIA as the big exception.

When I start cardmgr I see log messages for IO port probes and than the
machine is completely frozen:

Starting PCMCIA services: cardmgr[309]: watching 2 sockets
cs: IO port probe 0x0c00-0x0cff: clean
cs: IO probt probe 0x0800-0x08ff:

At this point neither magic sysrq nor the hangtimer work. This
behaviour occurs with all of 2.4.18 (debian boot-floppies kernel), 
2.4.21, 2.5.73 and 2.5.74 (all unpatched).

Obligatory lspci output:

00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 01)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 01)
00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01)
02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702 Gigabit Ethernet (rev 02)
02:01.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7113 (rev 20)
02:01.1 CardBus bridge: O2 Micro, Inc.: Unknown device 7113 (rev 20)
02:03.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>      It is simple to make things.
http://www.wiggy.net/                     It is hard to make things simple.

