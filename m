Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265830AbTL3PNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 10:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbTL3PNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 10:13:40 -0500
Received: from solo.solosystem.com ([64.191.18.27]:8336 "EHLO
	solo.solosystem.com") by vger.kernel.org with ESMTP id S265830AbTL3PNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 10:13:38 -0500
Message-ID: <3FF19681.1060906@moosoft.net>
Date: Tue, 30 Dec 2003 15:15:13 +0000
From: adam mcmaster <madcow@moosoft.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i810fb problems in 2.6.0
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - solo.solosystem.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - moosoft.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using kernel 2.6.0 with the i810fb driver, which works almost 
perfectly - the only problem comes when booting the system for the first 
time. (i.e. the system has been halted then powered on, not simply 
rebooted.)

The problem is this:  after the kernel is decompressed, when it switches 
to framebuffer mode the screen goes blank and stays that way.  The only 
way I have found to get it to work is to first boot the other kernel I 
have (2.4.20 with the i810fb patch from sourceforge) then reboot into 
2.6.0.  The framebuffer works perfectly in 2.4.20.

I've been thinking about this a lot and I'm pretty sure it must be 
something to do with my BIOS, since (if my understanding is correct) the 
BIOS is the only thing that will stay running during a reboot.

I'm running a Sony Vaio laptop (PCG-FX101), the BIOS gives the following 
version info:
	PhoenixBIOS 4.0 Release 6.0
	BIOS Version:	R021140
	KBR Version:	RK21140
	Video BIOS:	U0IS2_30  (Maybe U0I52_30, I can't read my own writing)

 From lspci:
00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset 
Graphics Controller] (rev 11) (prog-if 00 [VGA])
         Subsystem: Sony Corporation Vaio PCG-FX403
         Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 9
         Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Memory at f4000000 (32-bit, non-prefetchable) [size=512K]
         Capabilities: [dc] Power Management version 2

I've uploaded dmesg output and kernel config to:
	http://moosoft.net/lkml/

Also, the distribution I'm using is Gentoo - I downloaded the kernel 
source from kernel.org and haven't patched/modified it in any way (well, 
other than config).

Any help with this would be appreciated; it's awkward having to first 
boot one kernel in order to use the other.

-- 
- adam mcmaster
