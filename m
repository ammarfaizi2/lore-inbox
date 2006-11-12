Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754225AbWKLMNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbWKLMNr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 07:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754222AbWKLMNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 07:13:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14564 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1754160AbWKLMNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 07:13:47 -0500
Date: Sun, 12 Nov 2006 13:13:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-fbdev-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl,
       Hoffmann@albercik.sisk.pl
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Message-ID: <20061112121334.GC9989@elf.ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5438@labex2.corp.trema.com> <1163285379.4982.233.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163285379.4982.233.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Then the radeonfb doesn't kick in at all (guess some pci ids are added
> > in that patch).
> > 
> > BTW: resume/suspend works ok if I have the vesa fb enabled.
> 
> In that case (vesafb), when does the screen come back precisely ? Do you
> get console mode back and then X ? Or it only comes back when going back
> to X ? Do you have some userland-type vbetool thingy that bring it
> back ?

He's using s3_bios+s3_mode, so kernel does some BIOS calls to reinit
the video. It should come out in text mode, too.

Christian, can you unload radeonfb before suspend/reload it after
resume?

Next possibility is setting up serial console and adding some printks
to radeon...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
