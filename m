Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132034AbQLJSuT>; Sun, 10 Dec 2000 13:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132084AbQLJSuK>; Sun, 10 Dec 2000 13:50:10 -0500
Received: from 02-101.095.popsite.net ([204.192.4.101]:20215 "EHLO monolith")
	by vger.kernel.org with ESMTP id <S132034AbQLJSuB>;
	Sun, 10 Dec 2000 13:50:01 -0500
To: linux-kernel@vger.kernel.org
Subject: Thinkpad T21, hard lockups with -test12-pre7
From: David Huggins-Daines <dhd@eradicator.org>
Organization: None worth mentioning
Date: 10 Dec 2000 13:13:44 -0500
Message-ID: <87bsukrvon.fsf@cepstral.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing intermittent hard lockups on my Thinkpad T21
(running powered-on, full speed, etc).  Since this thing doesn't seem
to have an IO-APIC, I'm unable to use NMI watchdog to get any kind of
oops trace from it.

I'm guessing (but I don't know) that the problem is be sound-related -
I first noticed the lockups when playing OGGs and ripping CDs
simultaneously, however since then I've seen them at other, more or
less random, times when the cs46xx driver is loaded.  The machine is
stable when running without the sound driver loaded.

One thing I noticed is that the BIOS on this thinkpad puts all PCI
interrupts on IRQ 11 by default - I had USB, sound, CardBus, and eth0
all on the same IRQ.  However reconfiguring the BIOS to spread them
out does not make the lockups go away.

I see there were lots of changes in cs46xx between test11 and
test12-pre, so I've reverted to the test11 driver (v0.09).  It's too
early to tell whether this cures the lockups however.

I'm running -test12-pre7 (with and without KDB applied) and pcmcia-cs
3.1.22.  I'm also using a cardbus 3c575 and a Belkin USB serial
converter/hub.

-- 
David Huggins-Daines		-		dhd@eradicator.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
