Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWBFKNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWBFKNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWBFKNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:13:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:395 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750926AbWBFKNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:13:49 -0500
Date: Mon, 6 Feb 2006 11:13:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: suspend2-devel@lists.suspend2.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060206101331.GC3967@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041238.06395.rjw@sisk.pl> <20060204191042.GA3909@elf.ucw.cz> <200602060945.01141.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602060945.01141.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 06-02-06 09:44:56, Nigel Cunningham wrote:
> Hi.
> 
> On Sunday 05 February 2006 05:10, Pavel Machek wrote:
> > Hi!
> >
> > > > I'm not suggesting treating them as unfreezeable in the fullest
> > > > sense. I still signal them, but don't mind if they don't respond.
> > > > This way, if they do leave that state for some reason (timeout?) at
> > > > some point, they still get frozen.
> > >
> > > Yes, that's exactly what I wanted to do in swsusp. ;-)
> >
> > It seems dangerous to me. Imagine you treated interruptible tasks like
> > that...
> >
> > What prevent task from doing
> >
> > 	set_state(UNINTERRUPTIBLE);
> > 	schedule(one hour);
> > 	write_to_filesystem();
> > 	handle_signal()?
> >
> > I.e. it may do something dangerous just before being catched by
> > refrigerator.
> 
> The write_to_filesystem would be caught be bdev freezing if you had it.

But we don't... if you have bdev freezing, why do any other freezing
at all, then? It should be enough :-).
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
