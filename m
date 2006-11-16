Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424563AbWKPXjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424563AbWKPXjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162322AbWKPXjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:39:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49043 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1162321AbWKPXjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:39:11 -0500
Date: Fri, 17 Nov 2006 00:38:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Chinner <dgc@sgi.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061116233853.GB6757@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611152100.35054.rjw@sisk.pl> <20061115202348.GB3875@elf.ucw.cz> <200611152258.52160.rjw@sisk.pl> <20061116232057.GH11034@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116232057.GH11034@melbourne.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I think I'll prepare a patch for freezing the work queues and we'll see what
> > > > to do next.
> > > 
> > > Thanks!
> > 
> > Okay, the patch follows.
> > 
> > I've been running it for some time on my boxes and it doesn't seem to break
> > anything.  However, I don't use XFS, so well ...
> 
> So you haven't actually tested whether it fixes anything or whether
> it introduces any regressions?

Noone has a testcase for a problem; swsusp just does not eat
filesystems in practice. Fill free to test the patch, but I'm pretty
sure it will not break anything.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
