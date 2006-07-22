Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWGVPWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWGVPWy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWGVPWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:22:54 -0400
Received: from ozlabs.org ([203.10.76.45]:38026 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750766AbWGVPWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:22:53 -0400
Subject: RE: [PATCH 6/6] cpuid neatening.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: David Schwartz <davids@webmaster.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060722000328.cd9e7e0e.akpm@osdl.org>
References: <20060722000328.cd9e7e0e.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 23 Jul 2006 01:22:45 +1000
Message-Id: <1153581765.15632.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
> > +			   unsigned int *ecx, unsigned int *edx)
> > +{
> > +	/* ecx is often an input as well as an output. */
> > +	__asm__("cpuid"
> > +		: "=a" (*eax),
> > +		  "=b" (*ebx),
> > +		  "=c" (*ecx),
> > +		  "=d" (*edx)
> > +		: "0" (*eax), "2" (*ecx));
> > +}
> > +
> 
> 	Shouldn't that be:
> 
> __asm__("cpuid"
> : "+a" (*eax),
>   "=b" (*ebx),
>   "+c" (*ecx),
>   "=d" (*edx)
> );

Perhaps?  I copied the existing code...

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

