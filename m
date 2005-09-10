Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbVIJD3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVIJD3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 23:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbVIJD3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 23:29:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17295 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932605AbVIJD3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 23:29:24 -0400
Date: Fri, 9 Sep 2005 20:28:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org
Subject: Re: [PATCH 2.6.13-stable] cpuset semaphore double trip fix
Message-ID: <20050910032844.GH7762@shell0.pdx.osdl.net>
References: <20050910004403.29717.51121.sendpatchset@jackhammer.engr.sgi.com> <20050910030127.GE7762@shell0.pdx.osdl.net> <20050909202030.541049a7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909202030.541049a7.pj@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Jackson (pj@sgi.com) wrote:
> Chris wrote:
> > Another 'by inspection' patch, perhaps we'll need to update the stable
> > rules, since these can be quite valid fixes, yet typically trigger
> > review replies asking if it's necessary for -stable.
> 
> I'm scratching my head here, trying to figure out what is the
> bottom line of this comment.
> 
> I'm guessing you're saying:
> 
> 	"By inspection" patches, unless they have something further
> 	to recommend their inclusion, are not candidates for -stable.

Yes.

> But intent of your phrase "yet typically trigger review replies ..."
> went right past me ...

Sorry, I was thinking outloud, it wasn't a direct comment on this patch.
During the -stable review period, patches like these usually get some
squawks.  And there are cases where 'found by inspection' are valid.

> > How unlikely?  So unlikely that it's more a theoreitical race, or did
> > you find ways to trigger? 
> 
> I don't have a way to trigger it.  My guess is that someday, some
> customer will find the right combination of calls, and be able to
> trigger this once every few hours or days.  The odds are quite good
> that 2.6.13.* will live out its life before that happens.  When it
> happens, it will be a customer doing some serious cpuset manipulations
> on serious big iron.

OK, we can hold until you find a good case for triggering ;-)

thanks,
-chris
