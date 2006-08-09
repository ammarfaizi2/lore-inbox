Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWHINfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWHINfY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWHINfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:35:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12744 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750768AbWHINfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:35:23 -0400
Date: Wed, 9 Aug 2006 15:35:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Message-ID: <20060809133507.GA3932@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091158.38458.rjw@sisk.pl> <20060809114628.GR3308@elf.ucw.cz> <200608091402.44749.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091402.44749.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Introduce the memory bitmap data structure and make swsusp use in the suspend
> > > phase.
> ]--snip--[
> > 
> > Maybe that bitmap code should go to kernel/power/bitmaps.c or
> > something?
> 
> Then we'll also need another header or put the definitions in power.h, but
> they will only be used by the code in snapshot.c anyway.  Apart from this,
> the "bitmap" functions refer to alloc_image_page() etc. that are internal
> to snapshot.c.
> 
> I thought it would be better to add this code to snapshot.c, because it's not
> needed anywhere else and the separation of it would increase the overall
> complexity for a little real gain.

Okay, then. (I'd like to keep files at reasonable sizes, but...)

> > but maybe it should go _after_ 4/5 and 5/5? Those are simple cleanups, this
> > has break-something-potential and should rest in -mm for a while.
> 
> OK, I'll redo the series this way.

Thanks.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
