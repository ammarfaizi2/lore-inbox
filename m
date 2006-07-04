Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWGDI2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWGDI2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWGDI2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:28:38 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:55749 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S932100AbWGDI2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:28:37 -0400
Date: Tue, 4 Jul 2006 01:20:18 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in ctxsw
Message-ID: <20060704082018.GF5902@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060704072832.GB5902@frankl.hpl.hp.com> <200607041014.30162.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607041014.30162.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Tue, Jul 04, 2006 at 10:14:30AM +0200, Andi Kleen wrote:
> 
> > diff -urNp linux-2.6.17.2.orig/arch/x86_64/ia32/ptrace32.c linux-2.6.17.2-tif/arch/x86_64/ia32/ptrace32.c
> > --- linux-2.6.17.2.orig/arch/x86_64/ia32/ptrace32.c	2006-06-17 18:49:35.000000000 -0700
> > +++ linux-2.6.17.2-tif/arch/x86_64/ia32/ptrace32.c	2006-06-30 09:02:16.000000000 -0700
> 
> Added thanks. But I had to fix it up by hand because of conflicts. 
> Please submit patches against mainline, not stable.
> 
Sorry about that.

> >        if (t->flags & _TIF_ABI_PENDING)
> >-               t->flags ^= (_TIF_ABI_PENDING | _TIF_IA32);
> >+               t->flags ^= (_TIF_ABI_PENDING | _TIF_IA32 | _TIF_DEBUG);
> 
> This xor must be obviously outside the if(). I fixed that up too
> by changing it to an unconditional clear.

Yes, my mistake.

-- 
-Stephane
