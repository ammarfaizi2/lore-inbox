Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266552AbUAOLok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 06:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUAOLoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 06:44:39 -0500
Received: from [160.218.214.150] ([160.218.214.150]:4224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266552AbUAOLoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 06:44:34 -0500
Date: Thu, 15 Jan 2004 12:43:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Joe Korty <joe.korty@ccur.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Ethan Weinstein <lists@stinkfoot.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.1 and irq balancing
Message-ID: <20040115114346.GB9265@elf.ucw.cz>
References: <40008745.4070109@stinkfoot.org> <1073814681.4431.5.camel@laptop.fenrus.com> <20040111165012.GA24746@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040111165012.GA24746@tsunami.ccur.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Greetings all,
> > > 
> > > I upgraded my server to 2.6.1, and I'm finding I'm saddled with only 
> > > interrupting on CPU0 again. 2.6.0 does this as well. This is the 
> > > Supermicro X5DPL-iGM-O (E7501 chipset), 2 Xeons@2.4ghz HT enabled. 
> > > /proc/cpuinfo is normal as per HT, displaying 4 cpus.
> > 
> > you should run the userspace irq balance daemon:
> > http://people.redhat.com/arjanv/irqbalance/
> 
> I have long wondered what is so evil about most interrupts going to
> CPU 0 that we felt we had to have a pair of irqdaemons in 2.6.  From my
> (admittedly imperfect) experience, the APIC will route an interrupt to
> CPU 1 if CPU 0 is busy with another interrupt, to CPU 2 if 0 and 1 are
> so occupied, and so on.  I see no harm in this other than the strangely
> lopsided /proc/interrupt displays, which I can live with.

Well, imagine 8 CPU machine with high interrupt load. Poor process
that gets scheduled on CPU#0 does little progress, but is shown as
eating one whole CPU.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
