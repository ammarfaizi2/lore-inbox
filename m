Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274620AbRITTab>; Thu, 20 Sep 2001 15:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274621AbRITTaV>; Thu, 20 Sep 2001 15:30:21 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:10646 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S274620AbRITTaD>;
	Thu, 20 Sep 2001 15:30:03 -0400
Date: Thu, 20 Sep 2001 21:28:16 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bruce Harada <bruce@ask.ne.jp>, Ben Greear <greearb@candelatech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
In-Reply-To: <E15jmpB-0003Zn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0109202110290.8024-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Alan Cox wrote:

> > Doubtful. Since it's an 815, I presume you're running a PIII (correct me if
> > I'm wrong) - newish PIIIs have reasonable overheating cutout features, and
> > if overheating had damaged the CPU, I'd be very surprised if it worked at
> > all, rather than just locking up on certain sizes of network packets.
> 
> The 815 chipsets have known (and documented) problems with out of spec
> memory signals. Board vendors are supposed to have used workarounds but I
> have so far sent back 2 out of the 3 A/Open i815 boards with problems where
> they locked up occasionally under high load (in any OS) and also failed
> memtest86 (with known good tested ram) when placed in an electrically noisy
> environment.
> 
> I've seen lockups on high network load as part of that - but not packet size
> dependant ones.

Hi everybody.

I have very similar problems as Ben. I have 4 machines with Asus P3C-D
motherboards (the one with rambus) and they use the i820 chipset.
I have severe stabilityproblems here, both in SMP and UP.

I also use a D-Link DFE-570TX card in all of these machines and they act
as routers.

SMP with IO-APIC is worst, then comes SMP without IO-APIC and best is UP
without IO-APIC (havn't tried with IO-APIC).

I can usually make SMP with IO-APIC hang within 30-45 minutes by letting
it route some quite heavy traffic. But sometimes it locks up after a few
hours and sometimes (rare) a few days.

SMP without IO-APIC usually lasts a little bit longer but not that much.

UP can last for over a week but sometimes it only holds up for a few
hours.

I've tried a _lot_ of kernels, ranging from 2.3.99 ones to 2.4.8-ac12.

2.4.8-ac12 seemed to be quite stable on this router as it survived my
tests for >30 h. But it dies within 10minutes after I put it into
prouction :( So now it runs UP and it dies again a few minutes again
(watchdog-cards are a wonderful thing).

It's totally unresponsive when it dies. No numlock or anything, and if I
enable nmi_watchdog there's no diffrence, it doesn't say anything. The
machine is totally unresponsive in all ways.

Does any of you have any ideas to what I might try?

/Martin

