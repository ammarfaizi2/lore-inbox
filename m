Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTEHTJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTEHTJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:09:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40334 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261923AbTEHTJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:09:15 -0400
Date: Thu, 8 May 2003 12:22:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 Interrupt Latency
Message-Id: <20030508122205.7b4b8a02.akpm@digeo.com>
In-Reply-To: <1052402187.1995.13.camel@diemos>
References: <1052323940.2360.7.camel@diemos>
	<1052336482.2020.8.camel@diemos>
	<20030507152856.2a71601d.akpm@digeo.com>
	<1052402187.1995.13.camel@diemos>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 May 2003 19:21:47.0455 (UTC) FILETIME=[118304F0:01C31597]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> On Wed, 2003-05-07 at 17:28, Andrew Morton wrote:
> > Paul Fulghum <paulkf@microgate.com> wrote:
> > >
> > > 2.5.69
> > > Latency 100-110usec (5x increase)
> > > Spikes from 5-10 milliseconds
> > > 
> 
> > If you can describe what drivers are in use, and what workload triggers the
> > problem then it may be locatable by inspection.
> 
> After inspecting both machines, there is no common
> hardware other than the net device. Both machines
> use the e100 driver.
> 
> After removing the e100 driver altogether,
> the increased latency and latency spikes persist.
> 
> So it looks like this problem is not specific to a
> particular hardware driver, but is a result of a
> more fundemental, system wide change.
> 
> I'm going to try your suggestion of doing a stack dump
> when the driver encounters the large spikes in IRQ latency,
> to determine if something is leaving interrupts disabled.

I wasn't very informative, alas.

> That will not address the fact that the minimum
> latency has jumped from 20usec (2.4.20 - 2.5.68) to 100usec
> (2.5.69). This may actually be two separate problems
> introduced with 2.5.69

Can you pinpoint a kernel version at which it started to happen?
