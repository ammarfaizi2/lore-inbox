Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423646AbWKFJjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423646AbWKFJjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 04:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423648AbWKFJjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 04:39:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25822 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1423647AbWKFJjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 04:39:15 -0500
Date: Mon, 6 Nov 2006 10:39:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jeff@garzik.org>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, stable@vger.kernel.org,
       rjw@sisk.pl, bunk@stusta.de, akpm@osdl.org, laurent.riffard@free.fr,
       rajesh.shah@intel.com, toralf.foerster@gmx.de,
       jesse.brandeburg@intel.com, "Ronciak, John" <john.ronciak@intel.com>,
       "John W. Linville" <linville@tuxdriver.com>, nhorman@redhat.com,
       cluebot@fedorafaq.org, notting@redhat.com, bruce.w.allan@intel.com,
       davej@redhat.com, linville@redhat.com, wtogami@redhat.com,
       dag@wieers.com, error27@gmail.com,
       e1000-list <e1000-devel@lists.sourceforge.net>
Subject: Re: [PATCH] e1000: Fix regression: garbled stats and irq allocation during swsusp
Message-ID: <20061106093900.GA2978@elf.ucw.cz>
References: <454B9BED.306@intel.com> <454EEA84.4060805@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454EEA84.4060805@garzik.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >e1000: Fix regression: garbled stats and irq allocation during swsusp
> >
> >After 7.0.33/2.6.16, e1000 suspend/resume left the user with an enabled
> >device showing garbled statistics and undetermined irq allocation state,
> >where `ifconfig eth0 down` would display `trying to free already freed 
> >irq`.
> >
> >Explicitly free and allocate irq as well as powerup the PHY during resume
> >fixes.
> >
> >Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
> 
> ACK, but:
> 
> Applying 'e1000: Fix regression: garbled stats and irq allocation during 
> swsusp'
> 
> fatal: corrupt patch at line 8

Toralf posted rediffed (manually applied) version... should I forward
it to you?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
