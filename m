Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWHWNJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWHWNJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHWNJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:09:04 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:43225 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932456AbWHWNJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:09:03 -0400
Date: Wed, 23 Aug 2006 05:58:43 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Message-ID: <20060823125843.GF697@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <200608231322.44106.ak@suse.de> <20060823121434.GE697@frankl.hpl.hp.com> <200608231429.04413.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608231429.04413.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 02:29:04PM +0200, Andi Kleen wrote:
> On Wednesday 23 August 2006 14:14, Stephane Eranian wrote:
> 
> > On Wed, Aug 23, 2006 at 01:22:44PM +0200, Andi Kleen wrote:
> > > 
> > > > I have a second thought on this. AMD has architected the performance counters.
> > > 
> > > Quote:
> > > >>
> > > Implementations are not required to support the performance
> > > c o u n t e rs and the event-select registers, or the time-stamp
> > > counter. The presence of these features can be determined by
> > > <<
> > > 
> > At the end of this paragraph then mention using CPUID to determine
> > the presence of the counters. AFAIK, there is no feature bit
> > covering performance monitoring. Does that mean we are left
> > with having to check the family and model number just like on
> > Intel?
> 
> Yes I puzzled over that too. Maybe they meant the MSR CPUID bits, but most likely
> it was a mistake by the tech writer.
> 
> Yes I think you have to. Only checking vendor/family should be fine though -- i am not
> aware of performance counter variations between models.

Today, I am just checking for family 15. If they have variations it could be with
the low power (laptop) models where counters may not be present at all.

> Perhaps add a force argument again that disables the family check too.
> 
> > Ok, I think I understand now:
> > 	1/ Bios and Kernel Developer Guide from Ahtlon64 and Opteron 64 is
> > 	  what you are talking about with K7/K8
> 
> Well K8.
> 
> K7 has a different one. But ok. I think you don't try to support K7 at all
> currently (it has the same register format as K8, but the list of counters
> is different)
> 
What is the "commercial name" of K7 processors?

-- 
-Stephane
