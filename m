Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270510AbTHLPXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270501AbTHLPXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:23:15 -0400
Received: from fmr06.intel.com ([134.134.136.7]:23245 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S270510AbTHLPXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:23:01 -0400
Date: Tue, 12 Aug 2003 08:22:55 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200308121522.h7CFMtc4003862@snoqualmie.dp.intel.com>
To: greg@kroah.com, zwane@linuxpower.ca
Subject: Re: Updated MSI Patches
Cc: jun.nakajima@intel.com, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, tlnguyen@snoqualmie.dp.intel.com,
       tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I hope there may be a way to determine the number of vectors supported 
> > > by CPU during the run-time. I look at the file ../include/asm-i386/mach-
> > > default/irq_vectors.h, the maximum of vectors (256) is already well 
> > > commented.
> > 
> > Yeah, but that's in reference to APIC interrupt sources, right?  Does
> > that correspond to these "vectors" too?  If so, why not just use the
> > existing NR_IRQS value instead of creating your own?
> 
> There isn't a 1:1 relationship between NR_IRQS and NR_VECTORS we really 
> shouldn't mix them together. NR_IRQS can be much higher than 256 whilst 
> on i386 we're fixed to 256 vectors due to that being the Interrupt 
> Descriptor Table capacity. It is still possible to service more interrupt 
> lines than 256 on SMP however by making IDTs per 'interrupt servicing 
> node'

> Ah, so for processors other than i386, NR_VECTORS can be bigger?

> I think a nice description is still needed for this value for just this
> reason :)

Agree. Will put some comments describing this value. 

Thanks,
Long
