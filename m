Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263675AbRFIFJB>; Sat, 9 Jun 2001 01:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263835AbRFIFIv>; Sat, 9 Jun 2001 01:08:51 -0400
Received: from www.wen-online.de ([212.223.88.39]:49160 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263675AbRFIFId>;
	Sat, 9 Jun 2001 01:08:33 -0400
Date: Sat, 9 Jun 2001 07:07:00 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: John Stoffel <stoffel@casc.com>, Tobias Ringstrom <tori@unhappy.mine.nu>,
        Jonathan Morton <chromi@cyberspace.org>, Shane Nay <shane@minirl.com>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.21.0106081426010.2422-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106090654570.480-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Marcelo Tosatti wrote:

> On Fri, 8 Jun 2001, John Stoffel wrote:
>
> > More importantly, a *repeatable* set of tests is what is needed to
> > test the VM and get consistent results from run to run, so you can see
> > how your changes are impacting performance.  The kernel compile
> > doesn't really have any one process grow to a large fraction of
> > memory, so dropping in a compile which *does* is a good thing.
>
> I agree with you.
>
> Mike, I'm sure you have noticed that stock kernel gives much better
> results than mine or Jonathan's patch.

I noticed that Jonathan brought back waiting.. that (among others)
made me veeeeery interested.

> Now the stock kernel gives us crappy interactivity compared to my patch.
> (Note: my patch still does not gives me the interactivity I want under
> high VM loads, but I hope to get there soon).

(And that's why)  Among other things (yes, I do love throughput) I've
poked at the interactivity problem. I can't improve it anymore without
doing some strategic waiting :(  I used to be able to help it a little
by doing a careful roll-up in scrub size as load builds.. trying to
smooth the transition from latency oriented to hammer down throughput.

> BTW, we are talking with the OSDL (http://www.osdlab.org) guys about a
> possibility to setup a test system which would run a different variety of
> benchmarks to give us results of different kinds of workloads. If that
> ever happens, we'll probably get rid of most of this testing problems.

Excellent!

	-Mike

