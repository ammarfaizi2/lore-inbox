Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWJMJU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWJMJU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 05:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWJMJU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 05:20:56 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:51922 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1750899AbWJMJUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 05:20:55 -0400
From: David Johnson <dj@david-web.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Hardware bug or kernel bug?
Date: Fri, 13 Oct 2006 10:20:50 +0100
User-Agent: KMail/1.9.5
References: <200610121753.23220.dj@david-web.co.uk> <Pine.LNX.4.64.0610121158490.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610121158490.3952@g5.osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610131020.51110.dj@david-web.co.uk>
X-Originating-Pythagoras-IP: [82.69.29.67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 20:13, you wrote:
>
> A reboot usually indicates a serious hardware problem - it could be an
> overheating sensor tripping, but it could be some serious corruption
> causing a triple-fault or something like that too.
>
> But the _most_ likely problem is just the power supply. If your power
> supply is border-line, having something that stresses CPU, disk,
> southbridge and networking at the same time may be just the way to cause a
> power-fail signal, which usually causes an instant reboot.

The power supplies in both machines on which I'm seeing the problem are brand 
new, supposedly good quality and from different manufacturers. Could it be 
that the motherboard has some fault which causes it to overload even good 
power supplies?

> I think it just changes timings, and there is something timing-related
> going on - like just instant power draw. The timer frequency should not
> have any serious impact on heat, so I doubt it's about overheating, but
> it's certainly worth opening the case and using one of those
> compressed-air things to cool down the CPU and/or southbridge chips.

The motherboard has all the usual heat sensors and will alarm if something 
gets too hot - I suspected overheating the first time this happened and 
checked the temps in the BIOS, but everything was well within limits.

> Interrupts generally aren't problematic, I'd be more likely to suspect CPU
> overclocking or similar (does the cpuinfo match the frequency claimed by
> the BIOS?) or just some strange motherboard problem (which could be
> firmware: bad programming of memory timings etc). So a BIOS upgrade is
> worth looking into.

The cpuinfo does indeed match the reported BIOS speed. The boards are already 
running the latest BIOS, so if it is a BIOS issue the motherboard 
manufacturer isn't aware of it...

> Soemtimes issues like this can be worked around - for example, maybe the
> problem is the chipset having issues with concurrent DMA or something, so
> turning off DMA on the disk drives could possibly at least _hide_ the
> problem.

I should have mentioned that of the two machines that are having the problem, 
one is using IDE and the other SATA. The SATA machine seems worst affected by 
it.

> But check the power supply first. And check to see if there is a BIOS
> upgrade available. You can double-check the cooling: check that all
> heat-sinks are properly seated and have appropriate amounts of thermal
> grease. And blowing air from a compressed-air can on top of the things
> until you see the frost over is certainly a good spot-check.

OK I'll give all that a go.

Thanks for your help,
David.
