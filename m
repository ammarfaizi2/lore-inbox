Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbTAPPB4>; Thu, 16 Jan 2003 10:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbTAPPBz>; Thu, 16 Jan 2003 10:01:55 -0500
Received: from catv02.rosenet.ne.jp ([210.230.70.3]:64143 "EHLO
	catv02.rosenet.ne.jp") by vger.kernel.org with ESMTP
	id <S267133AbTAPPBy>; Thu, 16 Jan 2003 10:01:54 -0500
Date: Fri, 17 Jan 2003 00:10:48 +0900
To: linux-kernel@vger.kernel.org, hostap@shmoo.com
Subject: Prism wireless lan card is causing time-travel
Message-ID: <20030116151048.GA978@begemot.ajrh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anthony Heading <anthony@magix.com.sg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a wireless lan card based on the Prism 2 chipset, branded by Corega,
who are quite a big brand here in Japan. (details below)

Whenever I install the hostap driver (http://hostap.epitest.fi/),
using "modprobe hostap_plx", the module loads fine, but the whole
machine's sense of time gets very confused.

The problem continues even when I remove the module.

Asking on the hostap list a month or two ago brought no joy,
and I can't find anyone else reporting a similar problem, so
I'm wondering if it's just broken hardware.

The effect can be seen with a shell loop to call /bin/date.

Jan-16 23:07:00.947547000
Jan-16 23:07:00.952915000
Jan-16 23:07:00.958982000
Jan-16 23:07:00.964766000
Jan-16 23:07:00.970666000
Jan-16 23:07:00.976285000
Jan-17 00:18:35.949607000
Jan-17 00:18:35.955582000
Jan-17 00:18:35.961650000
Jan-16 23:07:01.000077000
Jan-16 23:07:01.005745000
Jan-16 23:07:01.011856000
Jan-16 23:07:01.017729000
Jan-16 23:07:01.023490000
Jan-16 23:07:01.029346000
Jan-16 23:07:01.035519000
Jan-16 23:07:01.041152000

For a few milliseconds around each second, the time jumps
forward more than an hour, and then resets itself.

Updating the firmware on the card doesn't improve things,
nor does installing the card in a different PC.

Can anyone suggest what the problem might be, or how I
could debug it further?

Thanks!

Anthony

Linux begemot.ajrh.net 2.4.20 #20 SMP Thu Jan 16 23:04:42 JST 2003 i686 Intel(R) Xeon(TM) CPU 2.66GHz GenuineIntel GNU/Linux

05:0d.0 Network controller: National Datacomm Corp Wireless PCI Card (rev 02)
	Subsystem: Allied Telesyn International: Unknown device a113
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at ff2ff400 (32-bit, non-prefetchable) [size=128]
	Region 2: Memory at ff2ff000 (32-bit, non-prefetchable) [size=1K]
	Region 3: I/O ports at ccc0 [size=64]

