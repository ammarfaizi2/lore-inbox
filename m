Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVJGCVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVJGCVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 22:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVJGCVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 22:21:04 -0400
Received: from fmr22.intel.com ([143.183.121.14]:35207 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751304AbVJGCVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 22:21:02 -0400
Date: Thu, 6 Oct 2005 19:20:52 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, akpm@osdl.org
Subject: Re: [Patch] x86, x86_64: Intel HT, Multi core detection code cleanup
Message-ID: <20051006192052.B21395@unix-os.sc.intel.com>
References: <20051005161706.B30098@unix-os.sc.intel.com> <200510061242.26563.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200510061242.26563.ak@suse.de>; from ak@suse.de on Thu, Oct 06, 2005 at 12:42:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 12:42:25PM +0200, Andi Kleen wrote:
> On Thursday 06 October 2005 01:17, Siddha, Suresh B wrote:
> 
> > +
> > +#ifdef CONFIG_X86_HT
> > +#ifndef CONFIG_X86_64
> > +#include <mach_apic.h>
> > +#else
> > +#include <asm/mach_apic.h>
> > +#endif
> 
> Having such ifdefs is a clear cue that the code shouldn't be shared
> between architectures.

Andi, Those headers are for phys_pkg_id(). And its meaning is same on both 
x86 and x86_64(though its API is different. We can make it consistent across 
x86 and x86_64. But that will not solve the above pointed out ifdef hunk)

Unfortunately x86 mach specific vector implementation is not as simple as 
x86_64, resulting in the above ifdefs mess...

I can fix the API mess. Is there anything else you want me to do?

thanks,
suresh
