Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268906AbUHMAWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268906AbUHMAWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268908AbUHMAWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:22:33 -0400
Received: from waste.org ([209.173.204.2]:14298 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268906AbUHMAWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:22:32 -0400
Date: Thu, 12 Aug 2004 19:21:22 -0500
From: Matt Mackall <mpm@selenic.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org,
       Stelian Pop <stelian@popies.net>, jgarzik@pobox.com
Subject: Re: [patch] fix netconsole hang with alt-sysrq-t
Message-ID: <20040813002122.GG16310@waste.org>
References: <16659.56343.686372.724218@segfault.boston.redhat.com> <20040806195237.GC16310@waste.org> <16659.58271.979999.616045@segfault.boston.redhat.com> <20040806202649.GE16310@waste.org> <16667.55966.317888.504243@segfault.boston.redhat.com> <20040812211841.GB17907@granada.merseine.nu> <16667.57829.212177.183803@segfault.boston.redhat.com> <20040812213936.GC17907@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812213936.GC17907@granada.merseine.nu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 12:39:36AM +0300, Muli Ben-Yehuda wrote:
> On Thu, Aug 12, 2004 at 05:32:21PM -0400, Jeff Moyer wrote:
> > ==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Muli Ben-Yehuda <mulix@mulix.org> adds:
> > 
> > mulix> On Thu, Aug 12, 2004 at 05:01:18PM -0400, Jeff Moyer wrote:
> > >> So how do you want to deal with this case?  We could do something like:
> > >> 
> > >> int cpu = smp_processor_id();
> > 
> > mulix> That doesn't look right, unless I'm missing something, you could get
> > mulix> preempted here (between the smp_processor_id() and the
> > mulix> local_irq_save() and end up with 'cpu' pointing to the wrong CPU.
> > 
> > Would a preempt_disable() be too hideous?  Other suggestions?
> 
> Maybe, but we could hide it in get_cpu() / put_cpu() ;-)

Yes, let's. I'll have to think about this general approach a bit more though.

-- 
Mathematics is the supreme nostalgia of our time.
