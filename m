Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSLHTmI>; Sun, 8 Dec 2002 14:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSLHTmI>; Sun, 8 Dec 2002 14:42:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49162 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261568AbSLHTmH>; Sun, 8 Dec 2002 14:42:07 -0500
Date: Sun, 8 Dec 2002 20:49:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Message-ID: <20021208194944.GB19604@atrey.karlin.mff.cuni.cz>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain> <20021206000618.GB15784@atrey.karlin.mff.cuni.cz> <20021206185702.GE17595@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206185702.GE17595@poup.poupinou.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > Doesn't that imply your fix is broken to begin with?
> > > > 
> > > > ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
> > > > swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
> > > > overdesign to me, OTOH if you do the work it is okay with me.
> > > 
> > > You broke the design. S3 support was developed long before swsusp was in 
> > > the kernel, and completely indpendent of it. It should have remained that 
> > > way. 
> > > 
> > > S3 support is a subset of what is need for S4 support. 
> > 
> > That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
> > but not for S4. Big part of driver support is only needed for S3.
> > 
> > > swsusp is an implementation of S4 support. In theory, there could be 
> > > multiple implementations that all use the same core (saving/restoring 
> > > state). 
> > 
> > There were patches for S4bios floating around, but it never really
> > worked, IIRC.
> 
> No.  It work.  I do not resubmmited patches because I think that
> swsusp is better.

I think that s4bios is nice to have. Its similar to S3 and easier to
set up than swsusp... It would be nice to have it.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
