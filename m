Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTBEOS6>; Wed, 5 Feb 2003 09:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbTBEOS6>; Wed, 5 Feb 2003 09:18:58 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11012 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261370AbTBEOS5>;
	Wed, 5 Feb 2003 09:18:57 -0500
Date: Tue, 4 Feb 2003 23:55:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, ak@suse.de,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Message-ID: <20030204225501.GA128@elf.ucw.cz>
References: <20030202124235.GA133@elf.ucw.cz> <Pine.LNX.4.44.0302030657310.9361-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302030657310.9361-100000@montezuma.mastecende.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);		/* FIXME: this is needed for S3 resume, but why? */
> 
> Intel recommends a strong uncacheable mapping otherwise it may exhibit 
> undeterministic behaviour. Perhaps that could be it?

But... set_fixmp_nocache seems to only flip bits in page
tables... that should be nop after S3 because memory is preserved.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
