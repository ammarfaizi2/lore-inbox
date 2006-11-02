Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752805AbWKBKVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbWKBKVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbWKBKVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:21:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47250 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752805AbWKBKVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:21:14 -0500
Date: Thu, 2 Nov 2006 11:20:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt kernels
Message-ID: <20061102102059.GB1990@elf.ucw.cz>
References: <20061029024504.760769000@sous-sol.org> <20061029024606.496399000@sous-sol.org> <20061101121753.GA2205@elf.ucw.cz> <45492CBC.8020501@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45492CBC.8020501@vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Allow selected bug checks to be skipped by paravirt kernels.  The two most
> >>important are the F00F workaround (which is either done by the hypervisor,
> >>or not required), and the 'hlt' instruction check, which can break under
> >>some hypervisors.
> >>    
> >
> >How can hlt check break? It is hlt;hlt;hlt, IIRC, that looks fairly
> >innocent to me.
> >  
> 
> Not if you use tickless timers that don't generate interrupts to unhalt 
> you, or if you delay ticks until the next scheduled timeout and you 
> haven't yet scheduled any timeout.  Both are likely in a hypervisor.

Well.. but you are working around problem, instead of fixing it.

Tickless kernels are possible on normal machines, too.

Please fix it properly... probably by requesting timer 10msec in
advance or something.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
