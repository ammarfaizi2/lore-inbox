Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbTEHTWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 15:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTEHTWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 15:22:33 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:12602 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262031AbTEHTWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 15:22:32 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030508122205.7b4b8a02.akpm@digeo.com>
References: <1052323940.2360.7.camel@diemos>
	 <1052336482.2020.8.camel@diemos> <20030507152856.2a71601d.akpm@digeo.com>
	 <1052402187.1995.13.camel@diemos>  <20030508122205.7b4b8a02.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052422517.2024.6.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 May 2003 14:35:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-08 at 14:22, Andrew Morton wrote:
> Paul Fulghum <paulkf@microgate.com> wrote:
> >
> > On Wed, 2003-05-07 at 17:28, Andrew Morton wrote:
> > > Paul Fulghum <paulkf@microgate.com> wrote:
> > > >
> > > > 2.5.69
> > > > Latency 100-110usec (5x increase)
> > > > Spikes from 5-10 milliseconds
> > > > 

> > I'm going to try your suggestion of doing a stack dump
> > when the driver encounters the large spikes in IRQ latency,
> > to determine if something is leaving interrupts disabled.
> 
> I wasn't very informative, alas.

Yeah, I've been reading through the 2.5.69 patch again and
could not really see anything that related to the
stack dump.

> > That will not address the fact that the minimum
> > latency has jumped from 20usec (2.4.20 - 2.5.68) to 100usec
> > (2.5.69). This may actually be two separate problems
> > introduced with 2.5.69
> 
> Can you pinpoint a kernel version at which it started to happen?

Exactly with 2.5.69

2.5.68 works fine as do earlier versions back to 2.4.20-8
(earliest tested for this problem). All these versions have
very consistant latencies as described above.

The problem definately started with the 2.5.69

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


