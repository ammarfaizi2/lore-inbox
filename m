Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVCCI7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVCCI7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVCCI7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:59:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:53696 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261666AbVCCI70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:59:26 -0500
Date: Thu, 3 Mar 2005 00:58:07 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303085806.GB29955@kroah.com>
References: <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4226CA7E.4090905@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 03:27:42AM -0500, Jeff Garzik wrote:
> Greg KH wrote:
> >Sure they've been asking for it, but I think they really don't know what
> >it entails.  Look at all of the "non-stable" type patches in the -ac and
> >as tree.  There's a lot of stuff in there.  It's a slippery slope down
> >when trying to say, "I'm only going to accept bug fixes." 
> 
> We have all these problems precisely because _nobody_ is saying "I'm 
> only going to accept bug fixes".  We _need_ some amount of release 
> engineering.  Right now we basically have none.

Linus says that in -rc releases, are you not paying attention to that?
(yes, I know you are...)

> >Bug fixes for what?  Kernel api changes that fix bugs?  That's pretty
> >big.  Some driver fixes, but not others?  Driver fixes that are in the
> >middle of bigger, subsystem reworks as a series of patches?  All of this
> >currently happens today in the main tree in a semi-cohesive manner.  To
> >try to split it out is a very difficult task.
> 
> Easiest to answer with a concrete example:
> 
> Linux 2.6.11 is released.  Linus then does a
> 	bk clone linux-2.6 linux-2.6.11
> 
> Bug fixes that
> (a) 2.6.11 users really should have, or
> (b) Linus/Andrew feels are important, or
> (c) a subsystem maintainer feels are important [and does the work to 
> split out the fixes]
> 
> go into linux-2.6.11 repo, and then is pulled into linux-2.6 repo.
> 
> All other changes go into linux-2.6.
> 
> There's no need to over-think or over-work this.  The goal is to provide 
> a stable 2.6.11 for users, until 2.6.12 is available.

Will Linus start accepting 2.6.12 patches right after 2.6.10 is out?

> My prediction is that several patches will flow into the linux-2.6.11 
> repo a week or so after a release, and then the flow will die off to a 
> trickle.  Subsystem maintainers that care can submit patches/BK-pulls 
> for the stable release if they so desire.
> 
> Only important "oh shit, that should have been in 2.6.11" bug fixes need 
> apply.  Bug fixes for reworks, API changes, etc. are -not- applicable to 
> linux-2.6.11 repo.
> 
> Since BitKeeper can handle nicely a
> 	cd linux-2.6
> 	bk pull ../linux-2.6.11
> there is no duplication of bug fixes.

That sounds very sane to me, I can live with it.

The main point is, will people really test the 2.6.odd releases to help
us out in making this new scheme work.  If so, I'm all for it.

thanks,

greg k-h
