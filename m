Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWHFDtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWHFDtg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 23:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWHFDtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 23:49:36 -0400
Received: from ozlabs.org ([203.10.76.45]:64436 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751511AbWHFDtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 23:49:35 -0400
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
From: Rusty Russell <rusty@rustcorp.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44D55DF9.6020706@zytor.com>
References: <1154771262.28257.38.camel@localhost.localdomain>
	 <20060806023824.GA41762@muc.de>
	 <1154832963.29151.21.camel@localhost.localdomain>
	 <44D55AEC.1090205@zytor.com>
	 <1154833800.29151.24.camel@localhost.localdomain>
	 <44D55DF9.6020706@zytor.com>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 13:49:32 +1000
Message-Id: <1154836173.29151.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 20:11 -0700, H. Peter Anvin wrote:
> Rusty Russell wrote:
> >>>
> >>> So if you would prefer u64 rdtsc64(), u32 rdtsc_low(), u64 rdmsr64(int
> >>> msr), u32 rdmsr_low(int msr), I can convert everyone to that, although
> >>> it's a more invasive change...
> >> rdmsrl is really misnamed.  It should have been rdmsrq to be consistent, 
> >> and have rdmsrl return the low 32 bits.
> > 
> > I prefer the more explicit linux-style naming of rdmsr_low32/rdmsr64,
> > myself, even though this is x86-specific code.  Noone has an excuse for
> > misunderstanding then...
> 
> Well, we *do* have readb/readw/readl/readq etc.

Exactly.  And I modelled the name rdtsc64 on the "new-style" ioread8,
ioread16 and ioread32 from asm-generic/iomap.h 8)

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

