Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267597AbUIHN3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUIHN3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267238AbUIHN1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:27:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:32700 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267659AbUIHNAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:00:50 -0400
Date: Wed, 8 Sep 2004 15:00:49 +0200
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: Fw: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
Message-ID: <20040908130049.GA15444@wotan.suse.de>
References: <20040908021637.57525d43.akpm@osdl.org.suse.lists.linux.kernel> <20040908102652.GA2921@atrey.karlin.mff.cuni.cz.suse.lists.linux.kernel> <p73acw1hsvv.fsf@brahms.suse.de> <200409081451.55531.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409081451.55531.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 02:51:55PM +0200, Rafael J. Wysocki wrote:
> On Wednesday 08 of September 2004 14:01, Andi Kleen wrote:
> > Pavel Machek <pavel@ucw.cz> writes:
> > 
> > > Hi!
> > > 
> > > > One for you guys on lkml ;)
> > > 
> > > It simply takes long to count pages (O(n^2) algorithm), so watchdog
> > > triggers. I have better algorithm locally, but would like merge to
> > > linus first. (I posted it to lkml some days ago, I can attach the
> > > bigdiff).
> > > 
> > > Just disable the watchdog. Suspend *is* going to take time with
> > > disabled interrupts.
> > 
> > 
> > As a short term workaround you could also add touch_nmi_watchdog()s
> > in that loop.
> 
> You mean like that:

I doubt this will help, because the number of zones is quite small.

Better check every N pages, e.g. N=100

-Andi
