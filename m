Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269952AbVBEQph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269952AbVBEQph (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 11:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265417AbVBEQpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 11:45:34 -0500
Received: from imap.gmx.net ([213.165.64.20]:5270 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269734AbVBEQpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 11:45:25 -0500
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
To: acpi-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
Date: Sat, 5 Feb 2005 17:48:43 +0100
User-Agent: KMail/1.7.2
Cc: Ondrej Zary <linux@rainbow-software.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <4204B3C1.80706@rainbow-software.org> <9e473391050205074769e4f10@mail.gmail.com>
In-Reply-To: <9e473391050205074769e4f10@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051748.43547.stefandoesinger@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 5. Februar 2005 16:47 schrieb Jon Smirl:
> On Sat, 05 Feb 2005 12:53:37 +0100, Ondrej Zary
>
> <linux@rainbow-software.org> wrote:
> > I wonder how this can work:
> > a motherboard with i815 chipset (integrated VGA), Video BIOS is
> > integrated into system BIOS
> > a PCI card inserted into one of the PCI slots, configured as primary in
> > system BIOS
>
> The info needed to initialize Intel chips is public. The info needed
> to initialize most Nvidia and ATI chips is not.
DID someone ask ATI or Nvidia for this? I have the impression that everyone 
says ati doesn't help, but no one tried to get help so far.

The reset code of radeon card seems to be easy to reverse engineer. I have 
started an attempt and I have 50-60% of my radeon M9 reset code implemented 
in a 32 bit C program. I had to stop due to school reasons.

My radeonreset kernel module turns the backlight off and seems to reset the 
card's memory. I consider it dangerous because I don't know what it really 
does because I don't have the card's specs. A owner of an radeon M6 card 
tried my code too and it worked in the same way as on my M9 card, so I think 
the reset procedure is the same on all radeon cards. I think with some 
comparison of the reset code and the specs that the DRI/X.org/XFree 
developers have we can write a working reset code for radeon cards.
This won't help users of non-radeon cards of course :-(

ATI is aware of suspend/resume problems with their fglrx driver(see 
http://www.ati.com/support/infobase/4746.html). I've written a few notes to 
them, but I haven't got a reply so far(But they also told me not to expect 
one). The power management code in radeon_pm.c seems to be written by ATI. 
Alltogether I'd not call the situation hopeless.

Cheers,
Stefan
