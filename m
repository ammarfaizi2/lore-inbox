Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275046AbTHLFxC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 01:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275050AbTHLFxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 01:53:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:56519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275046AbTHLFxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 01:53:00 -0400
Date: Mon, 11 Aug 2003 22:53:08 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: long <tlnguyen@snoqualmie.dp.intel.com>, jun.nakajima@intel.com,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       tom.l.nguyen@intel.com
Subject: Re: Updated MSI Patches
Message-ID: <20030812055308.GA1912@kroah.com>
References: <200308112051.h7BKp9ZU003007@snoqualmie.dp.intel.com> <20030811211654.GA18578@kroah.com> <Pine.LNX.4.53.0308112134400.26153@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308112134400.26153@montezuma.mastecende.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 09:41:30PM -0400, Zwane Mwaikambo wrote:
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

Ah, so for processors other than i386, NR_VECTORS can be bigger?

I think a nice description is still needed for this value for just this
reason :)

thanks,

greg k-h
