Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWHWMYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWHWMYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWHWMYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:24:41 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:46579 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932440AbWHWMYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:24:40 -0400
Date: Wed, 23 Aug 2006 05:14:34 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Message-ID: <20060823121434.GE697@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <p73fyfn7nzz.fsf@verdi.suse.de> <20060823103956.GB697@frankl.hpl.hp.com> <200608231322.44106.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608231322.44106.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 01:22:44PM +0200, Andi Kleen wrote:
> 
> > I have a second thought on this. AMD has architected the performance counters.
> 
> Quote:
> >>
> Implementations are not required to support the performance
> c o u n t e rs and the event-select registers, or the time-stamp
> counter. The presence of these features can be determined by
> <<
> 
At the end of this paragraph then mention using CPUID to determine
the presence of the counters. AFAIK, there is no feature bit
covering performance monitoring. Does that mean we are left
with having to check the family and model number just like on
Intel?


> Also all code I've seen checked the family at least.
> 
> 
> > Their specification is not part of a model specific documentation but
> > part of the AMD64 architecure. 
> 
> The high level specification is, but not the actual counters for once.
> 
> > What I don't not quite understand with the K7, K8 terminology is the
> > relation/dependencies with the AMD64 architecture specification.
> AMD64 gives a high level register format, K7/K8 is the actual list 
> of performance counters.

Ok, I think I understand now:
	1/ Bios and Kernel Developer Guide from Ahtlon64 and Opteron 64 is
	  what you are talking about with K7/K8
	2/ AMD64 Architecture Programmer's Manual is the generic AMD64 description

So in theory, we should have:
	- a generic PMU description for the architected PMU  as described in 2/
	- a K7/K8 PMU description table for Athlon64 and Opteron64 as described in 1/

AFAIK, K7/K8 do not add anything to the architected PMU. I'll rename what we have to perfmon_k8.c
to make it more explicit.

-- 
-Stephane
