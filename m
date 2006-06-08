Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWFHHB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWFHHB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWFHHB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:01:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42642 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932539AbWFHHB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:01:56 -0400
Date: Thu, 8 Jun 2006 09:01:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] USB devices fail unnecessarily on unpowered hubs
Message-ID: <20060608070108.GD3688@elf.ucw.cz>
References: <447EB0DC.4040203@cogweb.net> <200606031129.54580.oliver@neukum.org> <200606050732.53496.david-b@pacbell.net> <200606060943.59072.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606060943.59072.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > If that does the job we need to somehow inherit the power supply maximum from
> > > PCI when we allocate the root hub's device structure.
> > 
> > I don't think there is such a convention that's generic for PCI.  There might
> > be ACPI-specific tables holding that value, but on embedded hardware the model
> > is often that the arch/.../board-ZZZ.c file just "knows" things like how much
> > power the regulator powering that port can provide, and arranges bus_mA to match.
> > Just like it knows all sorts of other details about how that board works.
> 
> Yes, I am afraid it cannot be done on the fly. But we might use a symbolic
> define which a subarch can override instead of a literal "500".
> If it turns out that this problem is one of power and not some other
> deficiency of this system's root hub.

That's bad... because we don't know exact model until runtime (ARM
tries to support many machines with single binary kernel, AFAICS), and
this is very likely going to be model-dependend.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
