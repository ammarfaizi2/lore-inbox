Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTDPNNy (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTDPNNy 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:13:54 -0400
Received: from mail.ithnet.com ([217.64.64.8]:60168 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264358AbTDPNNx 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 09:13:53 -0400
Date: Wed, 16 Apr 2003 15:12:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: ISDN massive packet drops while DVD burn/verify
Message-Id: <20030416151221.71d099ba.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I just experienced a massive ISDN problem while writing DVDs.
It looks like bigger IP packets (bigger than normal ICMP ping)
get simply dropped most of the time.
I think the packets get lost because some allocation continously fails and disk
i/o is faster in re-gaining the mem, but I am not quite sure. Could as well be
ide-scsi is partially busy-looping the box to death.
As soon as DVD writing is stopped everything comes back to normal.
Reading DVDs does not show the problem btw.
ping -s 1500 a.b.c.d shows about 5 packets, then stops.

This is with 2.4.21-pre6.

The box is:

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:04.0 Network controller: Elsa AG QuickStep 1000 (rev 01)
00:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks: Unknown device 0225
01:02.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
01:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
02:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
02:03.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:03.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

/proc/meminfo

Mem:  3180371968 3171123200  9248768        0 544501760 2174619648
Swap: 2147467264 129138688 2018328576
MemTotal:      3105832 kB
MemFree:          9032 kB
MemShared:           0 kB
Buffers:        531740 kB
Cached:        2100388 kB
SwapCached:      23264 kB
Active:         724880 kB
Inactive:      2157696 kB
HighTotal:     2228204 kB
HighFree:         2896 kB
LowTotal:       877628 kB
LowFree:          6136 kB
SwapTotal:     2097136 kB
SwapFree:      1971024 kB


DVD is connected via ide-scsi. Data is on a disk connected to 3ware controller.

-- 
Regards,
Stephan
