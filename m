Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTA2Wmf>; Wed, 29 Jan 2003 17:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbTA2Wmf>; Wed, 29 Jan 2003 17:42:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14345 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265382AbTA2Wme>; Wed, 29 Jan 2003 17:42:34 -0500
Date: Wed, 29 Jan 2003 23:51:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Levon <levon@movementarian.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Message-ID: <20030129225156.GA20146@atrey.karlin.mff.cuni.cz>
References: <200301281219.NAA03575@harpo.it.uu.se> <20030129201843.GA1256@elf.ucw.cz> <20030129224220.GA10439@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129224220.GA10439@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > How can this be? I see nmi.c being unconditionaly compiled-in. Where
> > are the other clients you are talking about?
> 
> Is grep broken ?
> 
> > -#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PM)
> > -EXPORT_SYMBOL_GPL(set_nmi_pm_callback);
> > -EXPORT_SYMBOL_GPL(unset_nmi_pm_callback);
> > -#endif
> 
> You removed these but didn't check where they were used ?

Well, set_nmi... strongly suggests nmi, so I just killed them.. And
ouch its used by oprofile :-(.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
