Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266106AbSKOLRr>; Fri, 15 Nov 2002 06:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266108AbSKOLRr>; Fri, 15 Nov 2002 06:17:47 -0500
Received: from pc3-stoc3-4-cust114.midd.cable.ntl.com ([80.6.255.114]:16905
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S266106AbSKOLRr>; Fri, 15 Nov 2002 06:17:47 -0500
Date: Fri, 15 Nov 2002 11:24:37 +0000
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic - Kernel or Hardware?
Message-ID: <20021115112437.GB1178@buzz.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I seem to have started getting a lot of kernel panic's on a box but am
not sure whether it's a kernel problem or a hardware problem.

It's a dual Celeron 500 in an Abit BP6 board with 640MB RAM and a 40GB
IDE HD. The HD is connected to the onboard UDMA interface (the A-bit
board has 2x normal ide channels and 2x udma channels with a HPT366
chipset).

2.4.40-rc1 with the new eepro100 driver seemed to happen every few
minutes so I recompiled it with the old eepro100 driver and it seemed
much better but died after a few hours of compiling. 2.4.19 seemed to do
the same.

All I could see in the log, is about the time it happened last was:

Nov 14 23:26:40 buzz kernel: hda: status error:
status=0x58 { DriveReady SeekComplete DataRequest }
Nov 14 23:26:40 buzz kernel: hda: drive not ready for command
Nov 14 23:28:47 buzz kernel: hda: status error:
status=0x58 { DriveReady SeekComplete DataRequest }
Nov 14 23:28:47 buzz kernel: hda: drive not ready for command
Nov 14 23:29:00 buzz kernel: APIC error on CPU0: 02(02)


The box always seems to respond to pings fine but I can not
ssh/telnet/anything else in and when I go to the console it's showing a
kernel panic and have to hard reset.

[ian@sooty:~]$ telnet 10.10.1.1
Trying 10.10.1.1...
Connected to 10.10.1.1.
Escape character is '^]'.
[stops]


Any ideas?


Thanks!

Ian

