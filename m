Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWEVAOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWEVAOq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWEVAOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:14:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55513 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964958AbWEVAOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:14:46 -0400
Date: Mon, 22 May 2006 02:14:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sector_t overflow in block layer
Message-ID: <20060522001402.GB25184@elf.ucw.cz>
References: <m3odxxukcp.fsf@bzzz.home.net> <1147884610.16827.44.camel@localhost.localdomain> <m34pzo36d4.fsf@bzzz.home.net> <1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com> <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int> <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk> <20060518185955.GK5964@schatzie.adilger.int> <Pine.LNX.4.64.0605181403550.10823@g5.osdl.org> <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605182307540.16178@hermes-1.csi.cam.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Why isn't that just a 
> > 
> > 	if (unlikely(sector != (sector_t)sector))
> > 
> > and that's it? What does this have to do with CONFIG_LBD or BITS_PER_LONG, 
> > or anything at all?
> > 
> > If the sector number fits in a sector_t, we're all good.
> 
> I think you missed that Andrewas said he is worried about 64-bit overflows 
> as well.  And you would not catch those with the sector != 

Can 64-bit really overflow? That's 16 000 Peta bytes, AFAICS. Does
anyone really have disk array over 100 Peta bytes? How much space does
Google have, for example?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
