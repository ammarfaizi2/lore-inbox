Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131126AbRANIqZ>; Sun, 14 Jan 2001 03:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131428AbRANIqP>; Sun, 14 Jan 2001 03:46:15 -0500
Received: from styx.suse.cz ([195.70.145.226]:43770 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131126AbRANIqF>;
	Sun, 14 Jan 2001 03:46:05 -0500
Date: Sun, 14 Jan 2001 09:46:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010114094602.B365@suse.cz>
In-Reply-To: <200101132340.AAA00985@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101132340.AAA00985@green.mif.pg.gda.pl>; from ankry@green.mif.pg.gda.pl on Sun, Jan 14, 2001 at 12:40:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 12:40:58AM +0100, Andrzej Krzysztofowicz wrote:

> > > 2.4 has code in the pci quirks to disable the register which makes
> > > the chip masquerade as a VP3, and forces it to identify itself as
> > > an MVP3 part.  I'm curious whether this has an interaction here.
> > 
> > This doesn't do anything but change the ID so that Linux drivers are not
> > confused anymore. This caused a lot of trouble in 2.2, especially with
> > the old VIA IDE driver.
> [...]
> > Fortunately all these chips use PIIX-compatible extensions to the PCI
> > bus, so they are all interchangeable to some degree.
> > 
> > > I'm curious if all of the other boards in Alans bug reports also
> > > fall into the stranger category.
> > 
> > It's possible. I have a board (VA-503A), which has a masqueraded 598,
> > which identifies itself as 597, and a 686a southbridge. This got the
> > 2.2 ide driver completely confused, for example. 
> 
> Maybe the VIA IDE chipset support option should depend on PCI quirks now ?

No, in 2.4 the VIA IDE driver doesn't use this (northbridge) information
anymore.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
