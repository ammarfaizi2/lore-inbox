Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVG0Pww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVG0Pww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVG0Pwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:52:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38842 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262398AbVG0Puw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:50:52 -0400
Date: Wed, 27 Jul 2005 08:50:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: tglx@linutronix.de, Git Mailing List <git@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux BKCVS kernel history git import..
In-Reply-To: <1122478870.28128.52.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58.0507270846360.3227@g5.osdl.org>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org> 
 <1122457238.3027.37.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0507270819550.3227@g5.osdl.org> <1122478870.28128.52.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jul 2005, David Woodhouse wrote:
> 
> Hm, OK. That works and can also be used for the "fake _absence_ of
> parent" thing -- if I'm space-constrained and want only the history back
> to some relatively recent point like 2.6.0, I can do that by turning the
> 2.6.0 commit into an orphan instead of also using all the rest of the
> history back to 2.4.0. 

Yes. The grafting really should work pretty well for various things like
this, and at the same time I don't think it's ever going to be a huge 
problem: people may have a couple of graft-points (if you want to drop 
history, you may well have more than one point you need to "cauterize": 
you may not be able to just cut it off at 2.6.0, since there may be merges 
furhter back in history), but I don't think it's going to explode and 
become unwieldly.

I just don't see people having more than a few trees that they might want
to graft together, and while the "drop history" thing might cause more
issues, even that is bounded by the amount of development parallellism, so 
while it probably causes more graft-points than the "join trees" usage, it 
should still be just a small handful of points.

			Linus
