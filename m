Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWHGGUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWHGGUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWHGGUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:20:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59033 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751107AbWHGGUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:20:19 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native ops
Date: Mon, 7 Aug 2006 08:16:03 +0200
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <44D6D315.2030907@goop.org> <1154930617.7642.10.camel@localhost.localdomain>
In-Reply-To: <1154930617.7642.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070816.03261.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 08:03, Rusty Russell wrote:
> On Sun, 2006-08-06 at 22:43 -0700, Jeremy Fitzhardinge wrote:
> > Andi Kleen wrote:
> > >> +/* Stop speculative execution */
> > >> +static inline void sync_core(void)
> > >> +{
> > >> +	unsigned int eax = 1, ebx, ecx, edx;
> > >> +	__cpuid(&eax, &ebx, &ecx, &edx);
> > >> +}
> > >>     
> > >
> > > Actually I don't think this one should be para virtualized at all.
> > > I don't see any reason at all why a hypervisor should trap it and it
> > > is very time critical. I would recommend you move it back into the 
> > > normal files without hooks.
> 
> I don't see where it's time-critical...

See explanation in my other email. Also in general we want this one fast.

-Andi
