Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbTIPUEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTIPUEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:04:23 -0400
Received: from gprs151-26.eurotel.cz ([160.218.151.26]:5251 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262481AbTIPUEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:04:22 -0400
Date: Tue, 16 Sep 2003 22:04:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Olivier Galibert <galibert@limsi.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030916200407.GE1006@elf.ucw.cz>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk> <20030916171057.GA8210@openzaurus.ucw.cz> <20030916195345.GB68728@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916195345.GB68728@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Well, I do understand the bounce buffer problem, but honestly the current way
> > > > of handling the situation seems questionable at least. If you ever tried such a
> > > > system you notice it is a lot worse than just dumping the additional ram above
> > > > 4GB. You can really watch your network connections go bogus which is just
> > > > unacceptable. Is there any thinkable way to ommit the bounce buffers and still
> > > > do something useful with the beyond-4GB ram parts?
> > > 
> > > The 2.6 tree is somewhat better about this but at the end of the day if
> > > your I/O subsystem can't do the job your box will not perform ideally.
> > > For some workloads its a huge win to have the extra RAM, for others the
> > > I/O is a real pain. 
> > 
> > If he has trouble logging in, then there's a bug somewhere.
> > Bounce buffers should not slow machine down more than
> > 2x, and from his description it looks like way worse slowdown. 
> 
> The box does not just slowdown, the box crawls on the floor wimpering.
> Nothing works except ping until the i/os are finished (and they seem
> to crawl too), then everything works perfectly again.

That seems like bug ;-). Can you do some kind of memstat to see if it
is not something like atomic pages shortage? Also try to run vanilla
kernel. And try running it UP.

> We're quite eager to fix the problem too, if you want us to test some
> things.

I'm afraid I do not have big-enough box close-enough to fix that.

Does it happen with another disk driver, too? What about interrupts,
are not they disabled for too long? Can you enable PREEMPT to see
'scheduling in atomic' warnings?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
