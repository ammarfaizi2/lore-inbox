Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbVKBOOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbVKBOOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbVKBOOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:14:08 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:60100 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932710AbVKBOOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:14:08 -0500
Date: Wed, 2 Nov 2005 07:14:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: move kstrdup to lib/string.c
Message-ID: <20051102141407.GB3839@smtp.west.cox.net>
References: <2.494767362@selenic.com> <20051102170053.1c120a03.akpm@osdl.org> <20051102070337.GC4367@waste.org> <20051102174020.37da0396.akpm@osdl.org> <17256.33817.263105.197325@cargo.ozlabs.ibm.com> <20051102130435.GA24230@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102130435.GA24230@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 02:04:35PM +0100, Olaf Hering wrote:
>  On Wed, Nov 02, Paul Mackeras wrote:
> 
> > Andrew Morton writes:
> > 
> > > > That doesn't sound kosher, have a pointer?
> > > > 
> > > 
> > > http://lkml.org/lkml/2005/4/8/128
> > 
> > Yes, we currently use bits of lib/ in the zImage boot wrapper.  I
> > suspect we used to have our own string routines for the boot wrapper
> > until somebody said "why do we have all this code duplicated" and
> > cleaned it up. :)
> 
> We cant continue to use files from lib/ in arch/powerpc/boot when they
> start to use kernel internals like kmalloc. I converted a few
> zlib_inflate files with sed already. But things will get really ugly if
> we have to do more on-the-fly modifications. After all,
> arch/$ARCH/boot is no kernel code, it has to be standalone.
> Maybe we should just have no arch/powerpc/boot.

I've always thought one of the nice points about ppc linux was that the
kernel just booted on your board, no matter what crazy firmware there
was.

-- 
Tom Rini
http://gate.crashing.org/~trini/
