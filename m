Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269421AbUIYWBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269421AbUIYWBn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 18:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUIYWBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 18:01:43 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17644 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269421AbUIYWBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 18:01:40 -0400
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Kevin Fenzi <kevin@scrye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040925154527.GA8212@elf.ucw.cz>
References: <20040924021956.98FB5A315A@voldemort.scrye.com>
	 <20040924143714.GA826@openzaurus.ucw.cz>
	 <20040924210958.A3C5AA2073@voldemort.scrye.com>
	 <1096069216.3591.16.camel@desktop.cunninghams>
	 <20040925014546.200828E71E@voldemort.scrye.com>
	 <1096113235.5937.3.camel@desktop.cunninghams>
	 <415562FE.3080709@yahoo.com.au>  <20040925154527.GA8212@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1096149821.8359.1.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sun, 26 Sep 2004 08:03:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2004-09-26 at 01:45, Pavel Machek wrote:
> Hi!
> 
> > >>What causes memory to be so fragmented? 
> > >
> > >
> > >Normal usage; the pattern of pages being freed and allocated inevitably
> > >leads to fragmentation. The buddy allocator does a good job of
> > >minimising it, but what is really needed is a run-time defragmenter. I
> > >saw mention of this recently, but it's probably not that practical to
> > >implement IMHO.
> > 
> > Well, by this stage it looks like memory is already pretty well shrunk
> > as much as it is going to be, which means that even a pretty capable
> > defragmenter won't be able to do anything.
> 
> True, defragmenter would not help.
> 
> Anyway, conversion from order-8 allocation should be pretty easy, but
> I never seen that failure case and this is first report... So I'm not
> doing that work just yet. [There's big chunk of changes waiting in
> -mm, that needs to be merged because any other work should be done.]

Are we still planning on having suspend2 replace swsusp eventually? It
was a lot of work to switch from those high order allocations, and if we
are still going to replace swsusp, perhaps it's would be a better use of
your time to do other things?

Regards,

Nigel

