Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbSKUNIF>; Thu, 21 Nov 2002 08:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266649AbSKUNIF>; Thu, 21 Nov 2002 08:08:05 -0500
Received: from poup.poupinou.org ([195.101.94.96]:21262 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S266637AbSKUNIE>; Thu, 21 Nov 2002 08:08:04 -0500
Date: Thu, 21 Nov 2002 14:15:02 +0100
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
Subject: Re: Fix S3 resume when kernel is big
Message-ID: <20021121131502.GE707@poup.poupinou.org>
References: <20021120151136.GA862@elf.ucw.cz> <20021120153833.GA4344@suse.de> <20021121124506.GC1133@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121124506.GC1133@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 01:45:06PM +0100, Pavel Machek wrote:
> Hi!
> 
> >  > -	acpi_create_identity_pmd();
> >  > +	if (!cpu_has_pse) {
> >  > +		printk(KERN_ERR "You have S3 capable machine without pse? Wow!");
> >  > +		return 1;
> >  > +	}
> > 
> > Mobile K6 family never had PSE iirc, and also VIA Cyrix 3's are being
> > dropped into various laptops.
> 
> So S3 will refuse to suspend on those machines. Right now it will
> suspend and not wakeup if moon is bad phase.
> 							Pavel

FYI, current swsusp for 2.4 require that cpu has pse _or_ pse36.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
