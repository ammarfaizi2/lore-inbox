Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSFFTYo>; Thu, 6 Jun 2002 15:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSFFTYn>; Thu, 6 Jun 2002 15:24:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21000 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317110AbSFFTYl>; Thu, 6 Jun 2002 15:24:41 -0400
Date: Thu, 6 Jun 2002 21:24:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@osdl.org>, Pavel Machek <pavel@suse.cz>,
        Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: device model documentation 2/3
Message-ID: <20020606192443.GB10129@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200206051253.g55Crs331876@fachschaft.cup.uni-muenchen.de> <Pine.LNX.4.33.0206051205150.654-100000@geena.pdx.osdl.net> <20020602044907.A121@toy.ucw.cz> <3CFFB4CA.3020508@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What did seem to be missing was anything saying whether
> those device methods would be called in_interrupt() or
> whether instead they could sleep.  I'd hope all of them
> would be specified to allow blocking as needed, like their
> current analogues in PCI and USB.

Look better, it was there.

> Also, there was some mention not that long ago about
> desirability of some kind of device abort() call.  That
> would differ from the current remove() call because an
> abort() would pass the explicit knowledge that hardware
> was gone ... unplugged before driver shutdown, for one
> example.  That could also be achieved using some kind
> of mode parameter to remove() -- perhaps three values,
> saying whether the hardware was present, removed, or
> in some indeterminate state.

I'd prefer parameter to remove...

Your hardware may die physically, and driver should try to be able to
remove() even if hardware dies.
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
