Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbTBDWHv>; Tue, 4 Feb 2003 17:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTBDWHv>; Tue, 4 Feb 2003 17:07:51 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:26325 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267484AbTBDWHt>;
	Tue, 4 Feb 2003 17:07:49 -0500
Date: Tue, 4 Feb 2003 23:16:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Cuenta de la lista de linux <user_linux@citma.cu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Help with promise sx6000 card
Message-ID: <20030204231659.A22045@ucw.cz>
References: <20030203221923.M79151@webmail.citma.cu> <20030204213903.A21554@ucw.cz> <1044399167.29825.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1044399167.29825.12.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 04, 2003 at 10:52:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 10:52:48PM +0000, Alan Cox wrote:
> On Tue, 2003-02-04 at 20:39, Vojtech Pavlik wrote:
> > 1) Make sure the card BIOS is enabled.
> > 2) In the BIOS of the card, set it to "Other OS', not Linux
> 
> Both should work. "Other OS" changes how the promise cards I have map
> the IDE controllers and whether the I2O asks the OS for space or not.
> Does your BIOS also change the PCI class or pci idents ?

Well, if I set it to "Linux", the IDE controllers disappear completely
and the I2O fails to initialize. I might have a different firmware,
version, though. It works then with Promise's own sx6000 specific drivers
only.

> > 3) Disable support for Promise cards in Linux
> 
> Shouldnt be needed now days

Hopefully not. 

> > 4) Enable I2O and I2O block devices
> 
> Use 2.4.19 or later. The promise stuff freaks if you do clever cache
> hints and older kernels don't know about that

Indeed.

> > 6) With luck, it'll work. Anyway, SX6000's are DAMN SLOW.
> 
> 7) Sell the promise card to someone who doesnt know better and buy
> a 3ware. Certainly under Linux the 3ware is way faster
> 
> > Now to get a SX4000 working, that's a much more interesting task ...
> 
> SX4000 is i2o or something stranger ?

Something very strange. It does XORs in HW, and has two IDE channels but
that's all. And it's completely undocumented. It could be reasonably
fast, though. The chip name is PDC20621.

-- 
Vojtech Pavlik
SuSE Labs
