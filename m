Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293754AbSCAC50>; Thu, 28 Feb 2002 21:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310327AbSCACzR>; Thu, 28 Feb 2002 21:55:17 -0500
Received: from mother.ludd.luth.se ([130.240.16.3]:32902 "EHLO
	mother.ludd.luth.se") by vger.kernel.org with ESMTP
	id <S310353AbSCACyF>; Thu, 28 Feb 2002 21:54:05 -0500
Date: Fri, 1 Mar 2002 03:54:03 +0100 (MET)
From: texas <texas@ludd.luth.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
In-Reply-To: <E16gbnM-0001x7-00@the-village.bc.nu>
Message-ID: <Pine.GSU.4.33.0203010351220.28715-100000@father.ludd.luth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, my "change NIC driver" idea was a bad one (surprise) as the server
locked up yet again.

> Cold boot in the sense that reset buttons don't work or cold in the
> sense ctrl-alt-del doesn't work.

ctrl-alt-del doesn't work but holding in the "off" button for 4 seconds
does work (turns off the machine) and I therefore assume that the reset
button would work as well (no reset button installed on this machine
unfortunately).

> The bad pte one needs looking into.

Is this something that could be the cause of the lockup problems?

> I guess that box is always assuming PnP or ACPI setup in which case 2.2
> will never work on it.

Lo and behold, after following Mark Hahn's advice of adding "noapic" to
lilo append, 2.2 is booting without any complaints! He actually suggested
it for 2.4 and after having successfully testing it on 2.2, I'm now
running 2.4 with noapic, hoping it will magically make my lockup
problems go away just as it fixed 2.2.

When 2.4 dies on me next time (after thinking "this will surely fix it!"
after every potential fix and getting disappointed, I've stopped using
"if"), I will try 2.2. The sad thing about that is that there's no
Hyperthreading but if it's stable, it's most definitely worth the
performance penalty.

> After boot disable screen blanking with "setterm -blank 0"

I'm using echo -e "\33[9;0]" > /dev/console to disable screen-blanking on
all my servers. There's something about a monitor suddenly going blank
that gets my heart pumping...

Thanks,
Johan


