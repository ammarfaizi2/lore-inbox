Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130370AbQJaTdF>; Tue, 31 Oct 2000 14:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130384AbQJaTcz>; Tue, 31 Oct 2000 14:32:55 -0500
Received: from mail.missioncriticallinux.com ([208.51.139.18]:44805 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S130370AbQJaTcu>; Tue, 31 Oct 2000 14:32:50 -0500
Message-Id: <200010311932.OAA30422@odonnell.lowell.mclinux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: eepro100: card reports no resources [was VM-global...]
In-Reply-To: Your message of "Tue, 31 Oct 2000 13:23:06 EST."
             <20001031132306.A24147@stormix.com>
Date: Tue, 31 Oct 2000 14:32:44 -0500
From: "Michael O'Donnell" <mod@mclinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've not been paying attention to this eepro100 issue but
a coworker mentions that she saw a driver (or patch) posted
here back around 6 Sep 2000 by saw@saw.sw.com.sg with
 Subject: "Re: eepro100 trouble" that might be of interest.

Also, here's a possibly useless personal note WRT the
eepro100 resource msgs, FWIW: I was recently using remote
KGDB to work on an unrelated problem on an MP Pentium
box with integrated eepro100.  Whenever I'd leave one CPU
stopped in the kernel debugger for a very long time I'd
get those "no resource" messages from (I believe it was)
the Enet driver when I finally allowed that CPU to continue
running.  I never noticed any other ill effects though
I wasn't looking too hard for them at the time.  I don't
know what caused those resource messages but the version of
KGDB I was using was not clueful about MP issues - while
that one CPU was breakpointed the other CPU was likely
only held in check as a side-effect, probably by being
prevented from acquiring one of the IRQ-related spinlocks.

Of course, it would probably only be notable if some kind
of resource exhaustion did NOT result from such locking
misbehavior, but it seemed worth at least a mention...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
