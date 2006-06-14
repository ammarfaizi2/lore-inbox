Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWFNX3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWFNX3H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWFNX3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:29:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15593 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965033AbWFNX3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:29:05 -0400
Date: Thu, 15 Jun 2006 01:28:14 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       metan@seznam.cz, arminlitzel@web.de
Subject: Re: sharp zaurus sl-5500 (collie): touchscreen now works
Message-ID: <20060614232814.GJ7751@elf.ucw.cz>
References: <20060610202541.GA26697@elf.ucw.cz> <1150139307.5376.56.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150139307.5376.56.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I hacked touchscreen driver a bit (with great help from metan) and it
> > is now actually usable, without much filtering in userland.
> 
> That's good to know! :)

Yep, it makes collie usable.

> > (Very) dirty bigdiff is attached. Proper battery charging (very slow
> > charging is done even without software help) and MMC/SD support are
> > two biggest issues now -- on the kernel front.
> 
> As far as I can see, we should be able to use the existing driver once
> we adapt the code for the SA1100 features. The charging circuitry is
> very similar to the other models as far as I can tell.

Agreed. I just need to find out why ADCs seem to return random values.

> MMC/SD is more of a problem. There is one person with the specs who
> could write the driver but he can't pass them to anyone else :-(.

Did we ever have working MMC with open-source drivers (on collie)? I
thought we had MMC but not SD...

> > On the userland front... any ideas where to get 2.6-compatible GPE
> > environment? It would be nice to see X running :-). Bluetooth support
> > would be nice bonus ;-).
> 
> You can build such an image with OpenEmbedded easily enough ;-). I guess
> you're going to have to run it from the CF card though as the internal
> flash isn't big enough and MMC/SD doesn't work?

Well, provided I can get bitbake to work :-).

But I sense problems... I need CF slot for bluetooth card -- irda is
not really usable. I thought I seen some 16MB gpe images... and then,
there's RAM, too.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
