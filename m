Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWJ3WuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWJ3WuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWJ3WuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:50:19 -0500
Received: from colin.muc.de ([193.149.48.1]:20228 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1422730AbWJ3WuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:50:18 -0500
Date: 30 Oct 2006 23:50:16 +0100
Date: Mon, 30 Oct 2006 23:50:16 +0100
From: Andi Kleen <ak@muc.de>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Message-ID: <20061030225016.GA95732@muc.de>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com> <200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4546669F.8020706@vmware.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 12:54:55PM -0800, Zachary Amsden wrote:
> Andi Kleen wrote:
> >no_timer_check. But it's only there on x86-64 in mainline - although there
> >were some patches to add it to i386 too.
> >  
> 
> I can rename to match the x86-64 name.

I will do that in my tree.

> >>That is what this patch is building towards, but the boot option is
> >>"free", so why not?  In the meantime, it helps non-paravirt kernels
> >>booted in a VM.
> >>    
> >
> >Hmm, you meant they paniced before?  If they just fail a few tests
> >that is not particularly worrying (real hardware does that often too)
> >  
> 
> Yes, they sometimes fail to boot, and the failure message used to ask us 
> to pester mingo.

I still think we should figure that out automatically. Letting
the Hypervisor pass magic boot options seems somehow unclean.

But i suppose it will only work for the paravirtualized case,
not for the case of kernel running "native" under a hypervisor
I suppose? Or does that one not panic?


-Andi
