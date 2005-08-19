Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVHSJnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVHSJnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 05:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVHSJnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 05:43:22 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:49599
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S964794AbVHSJnV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 05:43:21 -0400
Date: Fri, 19 Aug 2005 05:45:00 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Nathan Becker <nbecker@physics.ucsb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lost ticks and Hangcheck
Message-ID: <20050819094500.GB16279@kurtwerks.com>
Mail-Followup-To: Nathan Becker <nbecker@physics.ucsb.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 12:41:07AM -0700, Nathan Becker took 37 lines to write:
> Hi,
> 
> I'm running kernel 2.6.12.5 with x86_64 target on an AMD X2 4800+ and 
> Gigabyte GA-K8NXP-SLI motherboard (bios version F8).  I'm having a problem 
> with lost clock ticks.  The dmesg says
> 
> warning: many lost ticks.
> Your time source seems to be instable or some driver is hogging interupts
> 
> Also if I enable hangcheck, then I get a huge number of Hangcheck messages 
> in dmesg.
> 
> The main other symptom is that the system clock runs fast and 
> inaccurately.  It seems to run more inaccurately when I'm using the CPU, 
> and be basically OK when idling.
> 
> I've tried various workarounds that I found suggested on this list and 
> others but the problem is still there.  I tried using noapic, turning on 
> RTC interrupt, also no_timer_check.  I also tried patching the CPU 
> frequency scaling code with the latest version from the AMD website 
> (1.50.03), and then finally turning that option off. Nothing helped.

I use the no_timer_check kernel parm and that keeps the clock from
running at double speed. I still see some other annoying boot-time
messages related to timers, but at least my time source is sane:

..MP-BIOS bug: 8254 timer not connected to IO-APIC
 failed.
timer doesn't work through the IO-APIC - disabling NMI Watchdog!
Uhhuh. NMI received for unknown reason 3d.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
 works.
Using local APIC timer interrupts.
Detected 12.436 MHz APIC timer.
testing NMI watchdog ... CPU#0: NMI appears to be stuck (1->1)!

Kurt
-- 
"I think it is true for all _n. I was just playing it safe with _n >= 3
because I couldn't remember the proof."
		-- Baker, Pure Math 351a
