Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbRBFOml>; Tue, 6 Feb 2001 09:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBFOmb>; Tue, 6 Feb 2001 09:42:31 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129067AbRBFOmW>;
	Tue, 6 Feb 2001 09:42:22 -0500
Message-ID: <20010203135518.A1203@bug.ucw.cz>
Date: Sat, 3 Feb 2001 13:55:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Robert Kaiser <rob@sysgo.de>, Patrizio Bruno <patrizio@dada.it>,
        linux-kernel@vger.kernel.org
Subject: Re: Disk is cheap?
In-Reply-To: <01013114393200.01502@rob> <Pine.LNX.4.10.10101311550150.3588-100000@blacksheep.at.dada.it> <200101311612.RAA02360@rob.devdep.sysgo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200101311612.RAA02360@rob.devdep.sysgo.de>; from Robert Kaiser on Wed, Jan 31, 2001 at 05:12:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I built a embedded dvd/cdda/mp3 player based on linux, using a p200mmx
> > with 24mb with a bus of 75mhx, but it still takes about 20 seconds to boot,
> > I think that an embedded device (for home use) should boot in less than
> > 5 seconds, how could be possible with a slow p133? (I've also tried a p133
> > on 66mhz of bus and it takes almost 35 seconds to boot)
> 
> Usually most of the startup time is spent by the BIOS doing
> extensive self-test stuff and for firing up services (http,
> inetd, sendmail, ...) that many embedded systems have little use
> for.

Actually, most of that time is spent running bash/sleep 1. Startup
scripts tend to be poorly designed.

> I have a 25MHz 386EX (~2.2 Bogomips) here that boots Linux out of ROM
> in roughly 30 seconds. Most of _that_ time however is spent decompressing
> the kernel.

You might want to set up XIP and run kernel directly off the ROM...

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
