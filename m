Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWHaUlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWHaUlU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 16:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWHaUlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 16:41:20 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:57458 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S932337AbWHaUlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 16:41:19 -0400
Subject: Re: [Kgdb-bugreport] [RFC] [Crash-utility] Patch to use gdb's bt
	in crash - works	great with kgdb! - KGDB in Linus Kernel.
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Tom Rini <trini@kernel.crashing.org>
Cc: Piet Delaney <piet@bluelane.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       George Anzinger <george@wildturkeyranch.net>, vgoyal@in.ibm.com,
       Subhachandra Chandra <schandra@bluelane.com>,
       Discussion
	 "list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>
In-Reply-To: <20060831142036.GF23227@smtp.west.cox.net>
References: <44EC8CA5.789286A@redhat.com>
	 <20060824111259.GB22145@in.ibm.com> <44EDA676.37F12263@redhat.com>
	 <1156966522.29300.67.camel@piet2.bluelane.com>
	 <20060830204032.GD30392@in.ibm.com>
	 <1156974093.29300.103.camel@piet2.bluelane.com>
	 <20060830145300.7d728f6c.rdunlap@xenotime.net>
	 <1156976522.24314.1.camel@piet2.bluelane.com>
	 <p73lkp5578s.fsf@verdi.suse.de>  <20060831142036.GF23227@smtp.west.cox.net>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Thu, 31 Aug 2006 13:41:13 -0700
Message-Id: <1157056874.24314.67.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2006 20:41:18.0330 (UTC) FILETIME=[CF6C05A0:01C6CD3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 07:20 -0700, Tom Rini wrote:
> On Thu, Aug 31, 2006 at 04:07:15PM +0200, Andi Kleen wrote:
> > Piet Delaney <piet@bluelane.com> writes:
> > > > 
> > > > ENOPATCH
> > > 
> > > Opps. 
> > 
> > What an ugly patch!
> > 
> > But it should be totally obsolete with the unwinder work Jan and me have been
> > doing recently which does this all properly. .18 isn't quite there
> > yet in all cases, but .19 will be hopefully.
> 
> Indeed.  But quite functional.  Have you guys been doing i386 as well?
> This kind of thing was needed to convince gdb when it really was time to
> stop trying unwind in a few cases, but looks quite bad on x86_64/i386.
> Thankfully getting it to stop on ARM was pretty easy (but it wasn't
> full/true annotations).

I wonder if we are killing a fly with a sledgehammer. On SunOS 4.1.4 I
just patched the top of stack with a NULL pointer. With SPARC the kernel
uses different registers than the user and don't recall their being a
problem with a NULL pointer being at the top of the kernel stack. Is
there a problem with the i386 architecture with the top of the kernel
stack having a NULL pointer? My guess is that it's needed to return
to the right place in user space.

-piet

> 
-- 
Piet Delaney
BlueLane Teck
W: (408) 200-5256; piet@bluelane.com
H: (408) 243-8872; piet@piet.net


