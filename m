Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWELKaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWELKaz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWELKaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:30:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4506 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751088AbWELKay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:30:54 -0400
Date: Fri, 12 May 2006 12:30:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Message-ID: <20060512103013.GG28232@elf.ucw.cz>
References: <200605021200.37424.rjw@sisk.pl> <200605110058.19458.rjw@sisk.pl> <20060511113519.GB27638@elf.ucw.cz> <200605120949.47046.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605120949.47046.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Too much uncertainity for 10% speedup, I'm afraid. Yes, it was really
> > clever to get this fundamental change down to few hundred lines, but
> > design complexity remains. Could we drop that patch?
> 
> Could you provide justification for your claim that the speedup is
> only 10%?

10% was number Rafael provided, IIRC.

> Please also remember that you are introducing complexity in other ways, with 
> that swap prefetching code and so on. Any comparison in speed should include 
> the time to fault back in pages that have been discarded.

Well, swap prefetching is useful for other workloads, too; so it gets
developed/tested outside swsusp.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
