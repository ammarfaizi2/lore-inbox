Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265979AbUFDU3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265979AbUFDU3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUFDU3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:29:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:34778 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265979AbUFDU3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:29:18 -0400
Date: Fri, 4 Jun 2004 13:28:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: wli@holomorphy.com, pj@sgi.com, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net, miltonm@bga.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604132819.44c4e7b5.akpm@osdl.org>
In-Reply-To: <20040604190803.GA6651@krispykreme>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604090314.56d64f4d.pj@sgi.com>
	<20040604165601.GC21007@holomorphy.com>
	<20040604190803.GA6651@krispykreme>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
>  
> > This is patently ridiculous. Make a compat_sched_getaffinity(), and
> > likewise for whatever else is copying unsigned long arrays to userspace.
> 
> Did someone say compat_sched_getaffinity?
> 

aargh!  It's back!

> 
> --
> 
> Patch from Milton Miller that adds the sched_affinity syscalls into the
> compat layer. 

There's something about this patch which make me break out in hives.  Does
it *really* need to be that complicated?

iirc, the last time I looked through this I was unable to convince myself
that it was endianness-correct.  Is it?

