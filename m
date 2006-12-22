Return-Path: <linux-kernel-owner+w=401wt.eu-S1752978AbWLWJh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbWLWJh4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 04:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbWLWJhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 04:37:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1165 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753027AbWLWJhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 04:37:20 -0500
Date: Fri, 22 Dec 2006 21:09:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: Changes to PM layer break userspace
Message-ID: <20061222210937.GD3960@ucw.cz>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612192114.49920.david-b@pacbell.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The existence of the power/state interface wasn't a bug - it was a 
> > deliberate decision to add it. It's the only reason the 
> > dpm_runtime_suspend() interface exists. 

Actually, if we noticed power/state during PM framework review, it
would have been killed. It is just way too ugly.

> > > In contrast, the /sys/devices/.../power/state API has never had many
> > > users beyond developers trying to test their drivers (without taking
> > > the whole system into a low power state, which probably didn't work
> > > in any case), and has *always* been problematic.  And the change you
> > > object to doesn't "break" anything fundamental, either.  Everything
> > > still works.
> > 
> > It's used on every Ubuntu and Suse system,
> 
> Odd how the relevant Suse developers didn't mention any issues with
> those files going away, any of the times problems with them were
> discussed on the PM list.  Also, I have a Suse system that doesn't
> use those files for anything ... maybe only newer release use it.

Not on *every* suse system. power/state is known to oops kernels, so
it is only enabled when user explicitely asks for 'dangerous aggresive
experimental power saving' or something like that.
-- 
Thanks for all the (sleeping) penguins.
