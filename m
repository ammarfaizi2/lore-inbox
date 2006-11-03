Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752584AbWKCI56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbWKCI56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbWKCI56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:57:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752365AbWKCI55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:57:57 -0500
Date: Fri, 3 Nov 2006 09:57:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Nate Diller <nate.diller@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Oleg Verych <olecom@flower.upol.cz>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061103085712.GA3725@elf.ucw.cz>
References: <20061101130614.GB7195@atrey.karlin.mff.cuni.cz> <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <20061102062158.GC5552@2ka.mipt.ru> <5c49b0ed0611021140u360342f2v1e83c73d03eea329@mail.gmail.com> <20061103084240.GB1184@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061103084240.GB1184@2ka.mipt.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > returns, which thread are you referring to?  Nicholas Miell, in "The
> > Proposed Linux kevent API" thread, seems to think that there are no
> > advantages over kqueue to justify the incompatibility, an argument you
> > made no effort to refute.  I've also read the Kevent wiki at
> > linux-net.osdl.org, but it too is lacking in any direct comparisons
> > (even theoretical, let alone benchmarks) of the flexibility,
> > performance, etc. between the two.
> > 
> > I'm not arguing that you've done a bad design, I'm asking you to brag
> > about the things you improved on vs. kqueue.  Your emphasis on
> > unifying all the different event types into one interface is really
> > cool, fill me in on why that can't be effectively done with the kqueue
> > compatability and I also will advocate for kevent inclusion.
> 
> kqueue just can not be used as is in Linux (_maybe_ *bsd has different
> types, not those which I found in /usr/include in my FC5 and Debian
> distro). It will not work on x86_64 for example. Some kind of a pointer
> or unsigned long in structures which are transferred between kernelspace
> and userspace is so much questionable, than it is much better even do
> not see there... (if I would not have so political correctness, I would
> describe it in a much different words actually).
> So, kqueue API and structures can not be usd in Linux.

Not sure what you are smoking, but "there's unsigned long in *bsd
version, lets rewrite it from scratch" sounds like very bad idea. What
about fixing that one bit you don't like?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
