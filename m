Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291826AbSBHVO6>; Fri, 8 Feb 2002 16:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291842AbSBHVOS>; Fri, 8 Feb 2002 16:14:18 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:31494 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S291839AbSBHVNR>;
	Fri, 8 Feb 2002 16:13:17 -0500
Date: Fri, 8 Feb 2002 00:03:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Patrick Mochel <mochel@osdl.org>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Russell King <rmk@arm.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
Message-ID: <20020207230315.GA762@elf.ucw.cz>
In-Reply-To: <20020206122253.GB446@elf.ucw.cz> <E16YcaF-0006z9-00@the-village.bc.nu> <20020207123125.GF5247@atrey.karlin.mff.cuni.cz> <20020207142333.A22451@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020207142333.A22451@suse.de>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > I suspect PnPBIOS knows for the 486. There is PnPbios code in 2.4-ac 
>  > > perfectly ready for a 2.5 merger
>  > PnPBIOS is nasty, and I suspect it is not present/working on all
>  > models, right?
> 
>  For the most part it's fine, it just needs the floppy driver / ps2
>  driver (and maybe some others) fixed up to not allocate regions
>  that pnpbios already reserved. Other than these issues, it seems
>  to be working well. It's certainly handled itself ok on all my
>  test boxes (Even the weird compaq with the fscked up pnpbios --
>  it claims to have pnpbios, yet when you call it, you get feature
>  not supported return codes. cute.)

It is *BIOS*, and that makes me nervous.

Anyway, I guess that for old boxen, it is okay to just put ide onto
/driver/legacy/XXX (and for new boxen probably too, we do not want
special code calling PnPbios/PCI just to put drivers to the right
place in the tree, right?)
									Pavel
PS: I suspect that those southbridge-integrated IDE controllers are
not *really* on PCI... They certainly do not use PCI IRQ A..D.
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
