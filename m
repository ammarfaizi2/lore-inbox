Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSLIKcw>; Mon, 9 Dec 2002 05:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSLIKcw>; Mon, 9 Dec 2002 05:32:52 -0500
Received: from poup.poupinou.org ([195.101.94.96]:35100 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S265063AbSLIKcv>; Mon, 9 Dec 2002 05:32:51 -0500
Date: Mon, 9 Dec 2002 11:40:29 +0100
To: Constantinos Antoniou <costas@MIT.EDU>
Cc: Pavel Machek <pavel@suse.cz>, Ducrot Bruno <ducrot@poupinou.org>,
       Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Message-ID: <20021209104029.GB14882@poup.poupinou.org>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain> <20021206000618.GB15784@atrey.karlin.mff.cuni.cz> <20021206185702.GE17595@poup.poupinou.org> <20021208194944.GB19604@atrey.karlin.mff.cuni.cz> <1039380380.1614.57.camel@nefeli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039380380.1614.57.camel@nefeli>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 03:46:20PM -0500, Constantinos Antoniou wrote:
> On Sun, 2002-12-08 at 14:49, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > > Doesn't that imply your fix is broken to begin with?
> > > > > > 
> > > > > > ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
> > > > > > swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
> > > > > > overdesign to me, OTOH if you do the work it is okay with me.
> > > > > 
> > > > > You broke the design. S3 support was developed long before swsusp was in 
> > > > > the kernel, and completely indpendent of it. It should have remained that 
> > > > > way. 
> > > > > 
> > > > > S3 support is a subset of what is need for S4 support. 
> > > > 
> > > > That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
> > > > but not for S4. Big part of driver support is only needed for S3.
> > > > 
> > > > > swsusp is an implementation of S4 support. In theory, there could be 
> > > > > multiple implementations that all use the same core (saving/restoring 
> > > > > state). 
> > > > 
> > > > There were patches for S4bios floating around, but it never really
> > > > worked, IIRC.
> > > 
> > > No.  It work.  I do not resubmmited patches because I think that
> > > swsusp is better.
> > 
> > I think that s4bios is nice to have. Its similar to S3 and easier to
> > set up than swsusp... It would be nice to have it.
> 
> (I do not know much, but) another reason may be that some laptops do not
> support S3, while they support S4? for example, in my Compaq Presario
> 1700T:
> 
> $ more /proc/acpi/info
> ACPI-CA Version:         20011018
> Sx States Supported:     S0 S1 S4 S5

Some southbrigdes have well know design flaw that prevent a 'good' S3
functionality.  Those this is disabled.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
