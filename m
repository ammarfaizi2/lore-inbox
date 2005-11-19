Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVKTIQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVKTIQG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 03:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVKTIQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 03:16:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20454 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751083AbVKTIQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 03:16:05 -0500
Date: Sat, 19 Nov 2005 23:32:03 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Mark Lord <lkml@rtr.ca>
Cc: Phillip Susi <psusi@cfl.rr.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA SATA Raid needs a long time to recover from suspend
Message-ID: <20051119233202.GB3361@spitz.ucw.cz>
References: <437AA996.9080505@cfl.rr.com> <20051116170642.313aeada.akpm@osdl.org> <437BFF4A.4060402@cfl.rr.com> <437D1B81.7000402@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437D1B81.7000402@rtr.ca>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> >>This change will increase the minimum delay in both ata_wait_idle() and
> >>ata_busy_wait() from 10 usec to 100 usec, which is not a good change.
> >>
> >>It would be less damaging to increase the delay in ata_wait_idle() from
> >>1000 to 100,000.  A one second spin is a bit sad, but the hardware's 
> >>bust,
> 
> I wonder if this the same problem that prevents resume-from-ram
> from working on my system when I use an older hard drive,
> rather than the newer model that came installed (notebook)..
> 
> Whenever resume fails, the hard drive light is on solid
> and the system is unresponsive.  And the backlight is off so no
> debug info available (no serial ports, either).

Debugging this sucks, sorry. Usefull methods are keyboard leds and system
beeper. printk-over-morse comes to mind :-).
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

