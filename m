Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129327AbRBFOP5>; Tue, 6 Feb 2001 09:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129350AbRBFOPr>; Tue, 6 Feb 2001 09:15:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64779 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129327AbRBFOPf>; Tue, 6 Feb 2001 09:15:35 -0500
Subject: Re: Linux interrupt latency
To: steveu@coppice.org (Steve Underwood)
Date: Tue, 6 Feb 2001 14:15:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A800476.46F0555E@coppice.org> from "Steve Underwood" at Feb 06, 2001 10:04:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Q8uI-0005cg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A 450MHz PII processor isn't really up to the task. Jim Dixon, who
> designed the card, recommends at least a 733MHz PIII, based on his
> experience with the original BSD driver. I am able to run one as a dual

It shouldnt matter. If its entirely tied to ISA bus performance you should
be able to run it on 486 quite honestly.

> card, and about 1/2 the time for a dual E1 card. This really sucks, and
> needs to be addressed when the more serious long term PCI version of the
> card goes through.

or hang a small CPU on it and shove it on USB since USB can do isosynchronous

> > >chipsets, particularly what event might be occuring once per second and
> > >disabling interrupts for a couple of hundred microseconds?  Thanks!
> 
> I think you are trying one board that is close to the limit, and one
> just beyond. Simple as that.

And quite a few chipsets steal cycles for other things (memory refresh, ram
thermal limiting and the like). With the Z85230 driver which also at high
speed really tests ISA bus throughput I regularly saw PCI boxes getting
worse performance  than ancient all ISA relics. Throughput was also comparable
between a K5 and a PII/233

> Good idea. I'll have to try that. There always seem to be lots of
> problem reports about IOAPIC, though. Should I trust it?

The problems with the IO apic are generally bios, however there is one 
concern I have. APIC is a message passing bus so doesnt have a guaranteed
delivery time.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
