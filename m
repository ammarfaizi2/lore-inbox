Return-Path: <linux-kernel-owner+w=401wt.eu-S932962AbWLTFey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962AbWLTFey (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 00:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932972AbWLTFey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 00:34:54 -0500
Received: from mx1.suse.de ([195.135.220.2]:45410 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932962AbWLTFex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 00:34:53 -0500
Date: Tue, 19 Dec 2006 21:34:17 -0800
From: Greg KH <gregkh@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Changes to PM layer break userspace
Message-ID: <20061220053417.GA29877@suse.de>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612192114.49920.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 09:14:49PM -0800, David Brownell wrote:
> On Tuesday 19 December 2006 8:26 pm, Matthew Garrett wrote:
> > On Tue, Dec 19, 2006 at 07:59:42PM -0800, David Brownell wrote:
> > It's perfectly reasonable to  
> > refer to it as a flawed interface, or perhaps even a buggy one. But in 
> > itself, it's clearly not a bug.
> 
> This class of bug is also called a "design bug" or sometimes "mistake".

Exactly, those "power" files actually pre-date the actual tree of
devices itself.  They were just holders for what the original developer
thought was going to be needed, but was never properly implemented due
to some job changes (note, this was not myself...)

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

I would be very interested to see any newer SuSE programs using that
interface.  Just point them out to me and I'll quickly fix them.

And yes, as a SuSE developer (and one of the people in charge of the
SuSE kernels), I have no problem with these files just going away.
Because, as David keeps repeating, they are broken and wrong.

thanks,

greg k-h
