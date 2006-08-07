Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWHGGDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWHGGDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWHGGDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:03:40 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:13279 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751100AbWHGGDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:03:39 -0400
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
	ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       virtualization@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <44D6D315.2030907@goop.org>
References: <1154925835.21647.29.camel@localhost.localdomain>
	 <200608070730.17813.ak@muc.de>  <44D6D315.2030907@goop.org>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 16:03:37 +1000
Message-Id: <1154930617.7642.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-06 at 22:43 -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >> +/* Stop speculative execution */
> >> +static inline void sync_core(void)
> >> +{
> >> +	unsigned int eax = 1, ebx, ecx, edx;
> >> +	__cpuid(&eax, &ebx, &ecx, &edx);
> >> +}
> >>     
> >
> > Actually I don't think this one should be para virtualized at all.
> > I don't see any reason at all why a hypervisor should trap it and it
> > is very time critical. I would recommend you move it back into the 
> > normal files without hooks.

I don't see where it's time-critical...

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

