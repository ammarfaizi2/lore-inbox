Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbTEOSrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264167AbTEOSrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:47:18 -0400
Received: from ns.suse.de ([213.95.15.193]:25612 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264162AbTEOSrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:47:16 -0400
Date: Thu, 15 May 2003 21:00:06 +0200
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       keith maanthey <kmannth@us.ibm.com>
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
Message-ID: <20030515190006.GA30173@Wotan.suse.de>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com> <20030515065120.GA3469@Wotan.suse.de> <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com> <20030515172855.GA10831@Wotan.suse.de> <1053020763.9629.104.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053020763.9629.104.camel@w-jstultz2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 10:46:03AM -0700, john stultz wrote:
> On Thu, 2003-05-15 at 10:28, Andi Kleen wrote:
> > > You did get around it in the generic subarch (which I love, by the way,
> > > thanks so much for doing that work), but in a roundabout way. (via
> > > #ifdef APIC_DEFINITION trickery). 
> > 
> > The best fix is probably to just remove the summit selection and replace
> > it with the generic architecture.
> 
> I'd agree (long term even more strongly), although along with that I'd
> like to be able to pick and choose my subarch. So I can have a kernel
> that supports say, PC and BigSMP, but not NUMAQ or whatever. I believe
> this is doable with your infrastructure, but I'm not sure how much work
> it will take. 

NUMAQ is not supported by the generic subarchitecture anyways.

The only supported architecturs by generic are pc, bigsmp, summit.
In theory you could subselect them, but it's only a few bytes for each
so it's probably not worth the effort. Technically it isn't a big issue,
you would just need to add it to Kconfig (not sure how to do that cleanly), 
the Makefile and the probe table.


-Andi

