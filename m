Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030691AbWHIL1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030691AbWHIL1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030695AbWHIL1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:27:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1715 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030693AbWHIL1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:27:19 -0400
Date: Wed, 9 Aug 2006 13:27:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Message-ID: <20060809112701.GO3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091158.38458.rjw@sisk.pl> <20060809103120.GI3308@elf.ucw.cz> <200608091257.16663.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091257.16663.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Introduce the memory bitmap data structure and make swsusp use in the suspend
> > > phase.
> > > 
> > > The current swsusp's internal data structure is not very efficient from the
> > > memory usage point of view, so it seems reasonable to replace it with a data
> > > structure that will require less memory, such as a pair of bitmaps.
> > 
> > Well, 500 lines of code  for what... 0.25% bigger image? I see it
> > enables you to do some cleanups... but could we get those cleanups
> > without those 500 lines? :-).
> 
> Out of the 500 lines, something like 100 are comments and other 50 are
> definitions of structures. ;-)

Yes, and of the 100 lines of comments, 10 are fixmes :-).

> Seriously speaking, I could do that without the bitmaps, but the code wouldn't
> be that much shorter.  Apart from this, I would need to introduce yet another
> type of PBEs (for storing pfns) and try not to get lost in the resulting mess.
> 
> Instead of doing this I prefer to add some extra code to set up a decent data
> structure and just use it.

Okay, I guess that if we need to change the structure anyway, we may
well use the effective structure...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
