Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030969AbWKOUYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030969AbWKOUYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030968AbWKOUYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:24:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59862 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030969AbWKOUYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:24:03 -0500
Date: Wed, 15 Nov 2006 21:23:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Chinner <dgc@sgi.com>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061115202348.GB3875@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061115185029.GA3722@elf.ucw.cz> <200611152056.48218.rjw@sisk.pl> <200611152100.35054.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611152100.35054.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There's one more thing, actually.  If the on-disk data and metadata are
> > changed _after_ the sync we do and _before_ we create the snapshot image,
> > and the subsequent  resume fails,
> 
> Well, but this is equivalent to a power failure immediately after the sync, so
> there _must_ be a way to recover the filesystem from that, no?

Exactly.

> I think I'll prepare a patch for freezing the work queues and we'll see what
> to do next.

Thanks!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
