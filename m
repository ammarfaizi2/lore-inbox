Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbUCCTMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCCTMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:12:19 -0500
Received: from poup.poupinou.org ([195.101.94.96]:7434 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id S262548AbUCCTMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:12:12 -0500
Date: Wed, 3 Mar 2004 20:12:06 +0100
To: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: 2.6.2: P4 ClockMod speed
Message-ID: <20040303191206.GL2869@poupinou.org>
References: <20040216213435.GA9680@dominikbrodowski.de> <40313AA9.1060906@arenanetwork.com.br> <20040217090939.GA9935@dominikbrodowski.de> <403D4BD3.7050703@arenanetwork.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D4BD3.7050703@arenanetwork.com.br>
User-Agent: Mutt/1.5.4i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 01:28:51AM +0000, dual_bereta_r0x wrote:
> Dominik Brodowski wrote:
> 
> >
> >That's not the point: some hardware (e.g. ARM) needs different memory
> >settings and different settings of the LCD controller  for different 
> >CPU frequencies, as the Front Side Bus of the CPU is closely related 
> >to the CPU frequency. On x86, all cpufreq techniques I've
> >seen so far do not modify the FSB [*], so memory settings etc. do not need
> >to be modified.
> >
> >	Dominik
> >
> >[*] or scaling the FSB didn't work...
> 
> In x86 world, this info is wrong. The *multiplier* is locked inside 
> processor (Intel P4) or by some "dips" on cpu core (AMD Athlon XP) -- 
> unless you have such as "enginering samples", with didn't have this lock 
> --, but front-side-bus is changeable via MoBo BIOS. Also, if you just 
> add 0.5v in your CPU you can made it running faster than designed. The 
> same applies to memory. That's why we bought DDR533 mems to run in 
> DDR400 hardwares. We increase FSB and our mems could run with this new FSB.
> 
> Again, showing *max* from manufacturer instead of *actual* speed is 
> wrong. Even if the machine has or not capabilities to run with more/less 
> power than it has designed for, is not up to the OS decide it. The OS 
> should run or not, but the user has chosen this path; it must only tell 
> him what's *really* happening. "Your actual clock differs from 
> manufacturer. Its *your* fault if any component fail or 
> malfunctions/bugs arrives because of this."
> 

The problem is that you can not trust /proc/cpuinfo when you compile
with SMP.  Go UP and that should be ok.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
