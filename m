Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751856AbWAERWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWAERWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWAERWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:22:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18450 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751856AbWAERWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:22:03 -0500
Date: Thu, 5 Jan 2006 18:22:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Make apm buildable without legacy pm.
Message-ID: <20060105172201.GC3831@stusta.de>
References: <20060103143352.GA24937@redhat.com> <20060105014126.GH5895@kurtwerks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105014126.GH5895@kurtwerks.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 08:41:26PM -0500, Kurt Wall wrote:
> On Tue, Jan 03, 2006 at 09:33:52AM -0500, Dave Jones took 0 lines to write:
> > APM doesn't _need_ the PM_LEGACY junk, so remove it's dependancy
> > from Kconfig, and ifdef the junk in the code.
> > Whilst the ifdefs are ugly, when the legacy stuff gets ripped out
> > so will the ifdefs.
> > 
> > Signed-off-by: Dave Jones <davej@redhat.com>
> > 
> > --- linux-2.6.14/arch/i386/Kconfig~	2005-12-22 22:06:10.000000000 -0500
> > +++ linux-2.6.14/arch/i386/Kconfig	2005-12-22 22:06:16.000000000 -0500
> > @@ -710,7 +710,7 @@ depends on PM && !X86_VISWS
> >  
> >  config APM
> >  	tristate "APM (Advanced Power Management) BIOS support"
> > -	depends on PM && PM_LEGACY
> > +	depends on PM
> >  	---help---
> >  	  APM is a BIOS specification for saving power using several different
> >  	  techniques. This is mostly useful for battery powered laptops with
> 
> Here's this hunk re-diffed against 2.6.15 (which applies without
> needing patch to apply an offset of -11 lines):
>...

Offsets when applying patches are usually completely harmless (problems 
are only possible if there isn't enough context, but that's obviously 
not the case here).

> Kurt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

