Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTBXLMt>; Mon, 24 Feb 2003 06:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTBXLMt>; Mon, 24 Feb 2003 06:12:49 -0500
Received: from mail.ithnet.com ([217.64.64.8]:34572 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266622AbTBXLMs>;
	Mon, 24 Feb 2003 06:12:48 -0500
Date: Mon, 24 Feb 2003 12:22:59 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with IDE-SCSI in 2.4.21-pre4/2.4.20
Message-Id: <20030224122259.7a468c82.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am experiencing a weird problem with ide-scsi. I try to do a simple CD mount
with above kernel versions. This results in spinning up cdrom drive, then
increasing cpu load and about 1 minute after that a complete freeze of the
system. To be honest I am not really sure if I am doing something wrong, but
cannot image what that could be.
I tried simple "mount /dev/sr0 /mnt" -> spinup, then freeze, "mount /dev/scd0
/mnt" -> spinup, then freeze. I even tried attaching a real SCSI cdrom, which
works as expected. I tried booting a live filesystem directly from the
questionable drive, it works (obviously does not use ide-scsi, but atapi). I
tried another ATAPI cdrom (first acer, then LiteOn), freeze. So it is no
hardware problem.
After beating this unbelievable problem for 5 hours I am now out-of-ideas. 
Any hints welcome.

-- 
Regards,
Stephan

PS: Resent, first try seems lost...

PPS: System is SMP with

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
01:02.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)
01:03.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
01:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
02:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
02:03.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:03.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

ide-scsi is on internal ServerWorks IDE.
