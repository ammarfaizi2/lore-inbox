Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131836AbQLYQk3>; Mon, 25 Dec 2000 11:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131637AbQLYQkL>; Mon, 25 Dec 2000 11:40:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28420 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131775AbQLYQjt>; Mon, 25 Dec 2000 11:39:49 -0500
Date: Mon, 25 Dec 2000 17:09:14 +0100
From: Martin Mares <mj@suse.cz>
To: Marvin Stodolsky <stodolsk@rcn.com>
Cc: linux-kernel@vger.kernel.org, Jacques.Goldberg@cern.ch,
        Mark Spieth <mark@digivation.com.au>, Sean Walbran <sean@walbran.org>
Subject: Re: BIOS problem, pro Microsoft, anti other OS
Message-ID: <20001225170914.A15598@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3A4769AC.F38B372C@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3A4769AC.F38B372C@rcn.com>; from stodolsk@rcn.com on Mon, Dec 25, 2000 at 10:37:16AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This alert should probably be forwarded to Others, but appropriate
> subTask persons in the kernel-source Maintainers list were not obvious.
> 
> Briefly, documented below is the fact/complications that some PC BIOS
> chips are now coming with a default Microsoft setting, which makes them
> hostile to some functionalities of other OS.  If particular under Linux,
> a PCI Winmodem did NOT function with the Win98 BIOS setting, but did
> fine  with BIOS choice "Other OS".  Possible, other PCI devices under
> Linux OS might be simmilarly afflicated.
> 
> This indicates a need for Linux install software to be equipped with a
> utility to probe the BIOS and report back "Linux hostile" BIOS
> settings.  Today most Newbies are getting new PC boxes equipped with
> WinModems.  Hostile BIOS settings will block their capability to get
> on-line.  Unfortunately, I do not have the technical capablity to
> directly contribute.  Thus please forward this alert to however may be
> capable and concerned with dealing with the problem.

Can you check what does Linux 2.4.0-test<latest> behave, please?

I know of these problems and I hope the new PCI code in 2.4.0 is able
to assign the missing memory/IO resources without help of the BIOS, but
unfortunately 2.2 isn't and it's very difficult to back-port the fixes
as they depend on changes in many other parts of the kernel.

You probably should make the ltmodem driver check the region base
registers and interrupts and if they are not set, recommend the user to
change the OS or PNP settings in their BIOS setup.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
First law of socio-genetics: Celibacy is not hereditary.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
