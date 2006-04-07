Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWDGWkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWDGWkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 18:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWDGWkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 18:40:23 -0400
Received: from www.osadl.org ([213.239.205.134]:63693 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964951AbWDGWkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 18:40:23 -0400
Subject: Re: [PATCH 1/5] generic clocksource updates
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604072239110.32445@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
	 <1144317972.5344.681.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0604062048130.17704@scrub.home>
	 <1144351944.5925.23.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0604072239110.32445@scrub.home>
Content-Type: text/plain
Date: Sat, 08 Apr 2006 00:40:55 +0200
Message-Id: <1144449655.5925.260.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman,

On Fri, 2006-04-07 at 22:43 +0200, Roman Zippel wrote:
> > > Currently this field isn't needed and as soon we have a need for it, we 
> > > can add proper capability information.
> > 
> > Is there a reason, why requirements which are known from existing
> > experience must be discarded to be reintroduced later ?
> 
> Then please explain these requirements.

I explained them very clear in my original post:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114431804702870&w=2

> This field shouldn't have been added in first place, I guess I managed to 
> confuse John when I talked about handling of continuous vs. tick based 
> clocks.

I appreciate your responsibility, but the is_continous field was
introduced on my request because I did not want to rely on (rating > X)
to decide whether I can safely switch to high resolution timer mode or
not.

I really do not understand, why you claim to be the ultimate authority
to decide whats right and wrong in this area. Can you please shed some
light on my agnostic mind with some _real_ explanation why you can claim
to have the authority to decide whats needed and whats not needed ?

"Currently this field isn't needed and as soon we have a need ....".
----------------------------------------------^^^^

I guess http://en.wikipedia.org/wiki/Pluralis_Majestatis is the right
place for me until you start to explain.

> Currently no user should even care about this, it's an 
> implementation detail of the clock.

Right. Even if no user cares about this right now, nevertheless
forseeing the requirements of the near future is the finer art of
engineering. Especially if there is existing experience, which shows
that it is necessary.

	tglx



