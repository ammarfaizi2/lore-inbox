Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966434AbWKNW5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966434AbWKNW5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966443AbWKNW5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:57:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2234 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S966441AbWKNW5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:57:52 -0500
Date: Tue, 14 Nov 2006 23:57:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Stefan Seyfried <seife@suse.de>, Zan Lynx <zlynx@acm.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk than in 2.6.18
Message-ID: <20061114225736.GB2676@elf.ucw.cz>
References: <200611121436.46436.arvidjaar@mail.ru> <200611140707.17935.arvidjaar@mail.ru> <20061114142353.GB2340@elf.ucw.cz> <200611142347.28571.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611142347.28571.arvidjaar@mail.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-11-14 23:47:27, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Tuesday 14 November 2006 17:23, Pavel Machek wrote:
> > Hi!
> >
> > > > > Maybe its a journal size thing, you could try "sync" before suspend
> > > > > and see if it helps.
> > > >
> > > > We already sync inside the kernel, it does not help here, though.
> > > > Blockdev freezing might help.
> > >
> > > is there patch applicable to vanilla kernel? After repairing reiser
> > > several times (due to hard lockups during suspend-to-RAM) that sounds
> > > even more interesting.
> >
> > Could you do the test Stefan asked? I do not think you'll kill
> > reiserfs by single forced powerdown.
> > 
> 
> well, I did it accidentally :) (forgot to plug in power and after 2 hours on 
> battery notebook simply switched off) and yes, there was some noticeable 
> delay loading grub. I also tried fs freezer without any visible effect. The 
> patches from mm I applied to vanilla kernel:
> 
> add-include-linux-freezerh-and-move-definitions-from.patch
> swsusp-cleanup-whitespace-in-freezer-output.patch
> swsusp-freeze-filesystems-during-suspend-rev-2.patch
> swsusp-thaw-userspace-and-kernel-space-separately.patch
> 
> Do I need some more patches for this to work?

I guess reiserfs would need to respond to filesystem freezing.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
