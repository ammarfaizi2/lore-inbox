Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWHWM3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWHWM3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWHWM3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:29:10 -0400
Received: from mx1.suse.de ([195.135.220.2]:8577 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932424AbWHWM3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:29:09 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Date: Wed, 23 Aug 2006 14:29:04 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <200608231322.44106.ak@suse.de> <20060823121434.GE697@frankl.hpl.hp.com>
In-Reply-To: <20060823121434.GE697@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608231429.04413.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 August 2006 14:14, Stephane Eranian wrote:

[adding discuss@x86-64.org so that possibly AMD people can comment]

> On Wed, Aug 23, 2006 at 01:22:44PM +0200, Andi Kleen wrote:
> > 
> > > I have a second thought on this. AMD has architected the performance counters.
> > 
> > Quote:
> > >>
> > Implementations are not required to support the performance
> > c o u n t e rs and the event-select registers, or the time-stamp
> > counter. The presence of these features can be determined by
> > <<
> > 
> At the end of this paragraph then mention using CPUID to determine
> the presence of the counters. AFAIK, there is no feature bit
> covering performance monitoring. Does that mean we are left
> with having to check the family and model number just like on
> Intel?

Yes I puzzled over that too. Maybe they meant the MSR CPUID bits, but most likely
it was a mistake by the tech writer.

Yes I think you have to. Only checking vendor/family should be fine though -- i am not
aware of performance counter variations between models.

Perhaps add a force argument again that disables the family check too.

> Ok, I think I understand now:
> 	1/ Bios and Kernel Developer Guide from Ahtlon64 and Opteron 64 is
> 	  what you are talking about with K7/K8

Well K8.

K7 has a different one. But ok. I think you don't try to support K7 at all
currently (it has the same register format as K8, but the list of counters
is different)

> 	2/ AMD64 Architecture Programmer's Manual is the generic AMD64 description

Yep
 
-Andi
