Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbQLJHTm>; Sun, 10 Dec 2000 02:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbQLJHTd>; Sun, 10 Dec 2000 02:19:33 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:20286 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S129789AbQLJHTQ>; Sun, 10 Dec 2000 02:19:16 -0500
Date: Sun, 10 Dec 2000 18:14:19 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephen Rothwell <sfr@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre21 oops reading /proc/apm
In-Reply-To: <E144uzE-00060S-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10012101630560.16389-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Alan Cox wrote:

> > OK, I did this (at least I think I got it right: the patch was happy) but
> > I can't see anything resembling DMI strings (even after I removed
> 
> Ok your machine probably doesnt have DMI then. That unfortunately means its
> hard to identify the specific machine

Which I presume rather rules out automagic detection and workaround?

I take it you are refering to the Phoenix BIOS detection code in
arch/i386/kernel/dmi_scan.c (ah yes, I see coments about QA ;-) and
subsequent call to apm_battery_horked()?

Is it "obvious" that I'm dealing with the same or similar kind of
bugginess here?

That being the case, any reason I can't/shouldn't put in a function
similar to apm_battery_horked(), and call/run it based on a config-time
variable?

FWIW, the machine claims "Phoenix NoteBIOS" dated 1994, and the poweroff
bit of APM appears to work just fine.

Thanks,
Neale.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
