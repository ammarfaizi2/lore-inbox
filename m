Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSKUMhI>; Thu, 21 Nov 2002 07:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265974AbSKUMhI>; Thu, 21 Nov 2002 07:37:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20998 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265570AbSKUMhH>; Thu, 21 Nov 2002 07:37:07 -0500
Date: Thu, 21 Nov 2002 13:44:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
Subject: Re: Fix S3 resume when kernel is big
Message-ID: <20021121124412.GB1133@atrey.karlin.mff.cuni.cz>
References: <20021120151136.GA862@elf.ucw.cz> <20021120153833.GA4344@suse.de> <1037809055.3702.43.camel@irongate.swansea.linux.org.uk> <20021120155223.GA5678@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120155223.GA5678@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > >  > -	acpi_create_identity_pmd();
>  > >  > +	if (!cpu_has_pse) {
>  > >  > +		printk(KERN_ERR "You have S3 capable machine without pse? Wow!");
>  > >  > +		return 1;
>  > >  > +	}
>  > > 
>  > > Mobile K6 family never had PSE iirc, and also VIA Cyrix 3's are being
>  > > dropped into various laptops.
>  > 
>  > Plenty of desktop machines have S3 
> 
> Indeed, that too. So the above assertion seems bogus.

Well, previous version reboots during S3 resume once kernel is > (some
size). I guess that PSE needs fixing but this needed fixing first.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
