Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUBZB3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbUBZB3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:29:15 -0500
Received: from [200.195.196.14] ([200.195.196.14]:942 "EHLO
	mail.ondacorp.com.br") by vger.kernel.org with ESMTP
	id S262598AbUBZB3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:29:10 -0500
Message-ID: <403D4BD3.7050703@arenanetwork.com.br>
Date: Thu, 26 Feb 2004 01:28:51 +0000
From: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Organization: ArenaNetwork Lan House & Cyber
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: 2.6.2: P4 ClockMod speed
References: <20040216213435.GA9680@dominikbrodowski.de> <40313AA9.1060906@arenanetwork.com.br> <20040217090939.GA9935@dominikbrodowski.de>
In-Reply-To: <20040217090939.GA9935@dominikbrodowski.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:

> 
> That's not the point: some hardware (e.g. ARM) needs different memory
> settings and different settings of the LCD controller  for different 
> CPU frequencies, as the Front Side Bus of the CPU is closely related 
> to the CPU frequency. On x86, all cpufreq techniques I've
> seen so far do not modify the FSB [*], so memory settings etc. do not need
> to be modified.
> 
> 	Dominik
> 
> [*] or scaling the FSB didn't work...

In x86 world, this info is wrong. The *multiplier* is locked inside 
processor (Intel P4) or by some "dips" on cpu core (AMD Athlon XP) -- 
unless you have such as "enginering samples", with didn't have this lock 
--, but front-side-bus is changeable via MoBo BIOS. Also, if you just 
add 0.5v in your CPU you can made it running faster than designed. The 
same applies to memory. That's why we bought DDR533 mems to run in 
DDR400 hardwares. We increase FSB and our mems could run with this new FSB.

Again, showing *max* from manufacturer instead of *actual* speed is 
wrong. Even if the machine has or not capabilities to run with more/less 
power than it has designed for, is not up to the OS decide it. The OS 
should run or not, but the user has chosen this path; it must only tell 
him what's *really* happening. "Your actual clock differs from 
manufacturer. Its *your* fault if any component fail or 
malfunctions/bugs arrives because of this."

-- 
dual_bereta_r0x -- Alexandre Hautequest
ArenaNetwork Lan House & Cyber -- www.arenanetwork.com.br
