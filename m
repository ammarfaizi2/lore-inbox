Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSLHUi4>; Sun, 8 Dec 2002 15:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSLHUi4>; Sun, 8 Dec 2002 15:38:56 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:63719 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S261353AbSLHUiy>; Sun, 8 Dec 2002 15:38:54 -0500
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
From: Constantinos Antoniou <costas@MIT.EDU>
To: Pavel Machek <pavel@suse.cz>
Cc: Ducrot Bruno <ducrot@poupinou.org>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20021208194944.GB19604@atrey.karlin.mff.cuni.cz>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz>
	 <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain>
	 <20021206000618.GB15784@atrey.karlin.mff.cuni.cz>
	 <20021206185702.GE17595@poup.poupinou.org>
	 <20021208194944.GB19604@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: Massachusetts Institute of Technology
Message-Id: <1039380380.1614.57.camel@nefeli>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 08 Dec 2002 15:46:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 14:49, Pavel Machek wrote:
> Hi!
> 
> > > > > > Doesn't that imply your fix is broken to begin with?
> > > > > 
> > > > > ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
> > > > > swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
> > > > > overdesign to me, OTOH if you do the work it is okay with me.
> > > > 
> > > > You broke the design. S3 support was developed long before swsusp was in 
> > > > the kernel, and completely indpendent of it. It should have remained that 
> > > > way. 
> > > > 
> > > > S3 support is a subset of what is need for S4 support. 
> > > 
> > > That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
> > > but not for S4. Big part of driver support is only needed for S3.
> > > 
> > > > swsusp is an implementation of S4 support. In theory, there could be 
> > > > multiple implementations that all use the same core (saving/restoring 
> > > > state). 
> > > 
> > > There were patches for S4bios floating around, but it never really
> > > worked, IIRC.
> > 
> > No.  It work.  I do not resubmmited patches because I think that
> > swsusp is better.
> 
> I think that s4bios is nice to have. Its similar to S3 and easier to
> set up than swsusp... It would be nice to have it.

(I do not know much, but) another reason may be that some laptops do not
support S3, while they support S4? for example, in my Compaq Presario
1700T:

$ more /proc/acpi/info
ACPI-CA Version:         20011018
Sx States Supported:     S0 S1 S4 S5

(unpatched 2.4.19, if this has anything to do)

Costas

> 								Pavel
-- 
Constantinos Antoniou
Ph.D. Candidate
Massachusetts Institute of Technology
Intelligent Transportation Systems Program
77 Massachusetts Ave., NE20-208, Cambridge, MA 02139
(T) 617-252-1113 * (F) 617-252-1130 * (email) costas@mit.edu

