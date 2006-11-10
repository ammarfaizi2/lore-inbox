Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946512AbWKJMAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946512AbWKJMAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 07:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946518AbWKJMAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 07:00:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7907 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946512AbWKJMAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 07:00:51 -0500
Date: Fri, 10 Nov 2006 13:00:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Message-ID: <20061110120038.GB3385@elf.ucw.cz>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061109233035.569684000@cruncher.tec.linutronix.de> <1163121045.836.69.camel@localhost> <200611100610.13957.ak@suse.de> <1163146206.8335.183.camel@localhost.localdomain> <20061110005020.4538e095.akpm@osdl.org> <20061110085728.GA14620@elte.hu> <20061110111231.GB3291@elf.ucw.cz> <20061110114806.GA6780@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110114806.GA6780@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > If so, could that function use the PIT/pmtimer/etc for working out 
> > > > if the TSC is bust, rather than directly using jiffies?
> > > 
> > > there's no realiable way to figure out the TSC is bust: some CPUs 
> > > have a slight 'skew' between cores for example. On some systems the 
> > > TSC might skew between sockets. A CPU might break its TSC only once 
> > > some
> > 
> > But we could still do a whitelist?
> 
> we could, but it would have to be almost empty right now :-) Reason: 

Well, if it would contain at least 50% of the UP machines... that
would be reasonably long list for a start.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
