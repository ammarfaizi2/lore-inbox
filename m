Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269321AbUIYM4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbUIYM4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 08:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269322AbUIYM4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 08:56:30 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:27549 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269321AbUIYM40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:56:26 -0400
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Kevin Fenzi <kevin@scrye.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <415562FE.3080709@yahoo.com.au>
References: <20040924021956.98FB5A315A@voldemort.scrye.com>
	 <20040924143714.GA826@openzaurus.ucw.cz>
	 <20040924210958.A3C5AA2073@voldemort.scrye.com>
	 <1096069216.3591.16.camel@desktop.cunninghams>
	 <20040925014546.200828E71E@voldemort.scrye.com>
	 <1096113235.5937.3.camel@desktop.cunninghams>
	 <415562FE.3080709@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1096117005.5937.21.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Sep 2004 22:56:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-09-25 at 22:22, Nick Piggin wrote:
> Nigel Cunningham wrote:
> > Hi.
> > 
> > On Sat, 2004-09-25 at 11:45, Kevin Fenzi wrote:
> 
> >>What causes memory to be so fragmented? 
> > 
> > 
> > Normal usage; the pattern of pages being freed and allocated inevitably
> > leads to fragmentation. The buddy allocator does a good job of
> > minimising it, but what is really needed is a run-time defragmenter. I
> > saw mention of this recently, but it's probably not that practical to
> > implement IMHO.
> > 
> 
> Well, by this stage it looks like memory is already pretty well shrunk
> as much as it is going to be, which means that even a pretty capable
> defragmenter won't be able to do anything.

Surely it would be able to rearrange pages to get a contiguous megabyte?
Regardless, not using order 8 allocations seems to me to be a better
solution (but then I have a patch to push once I finish my current round
of cleanups :>).

Nigel

