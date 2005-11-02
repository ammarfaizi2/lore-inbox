Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbVKBNEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbVKBNEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVKBNEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:04:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:29398 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932678AbVKBNEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:04:37 -0500
Date: Wed, 2 Nov 2005 14:04:35 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org, trini@kernel.crashing.org
Subject: Re: [PATCH 1/2] slob: move kstrdup to lib/string.c
Message-ID: <20051102130435.GA24230@suse.de>
References: <2.494767362@selenic.com> <20051102170053.1c120a03.akpm@osdl.org> <20051102070337.GC4367@waste.org> <20051102174020.37da0396.akpm@osdl.org> <17256.33817.263105.197325@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17256.33817.263105.197325@cargo.ozlabs.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Nov 02, Paul Mackeras wrote:

> Andrew Morton writes:
> 
> > > That doesn't sound kosher, have a pointer?
> > > 
> > 
> > http://lkml.org/lkml/2005/4/8/128
> 
> Yes, we currently use bits of lib/ in the zImage boot wrapper.  I
> suspect we used to have our own string routines for the boot wrapper
> until somebody said "why do we have all this code duplicated" and
> cleaned it up. :)

We cant continue to use files from lib/ in arch/powerpc/boot when they
start to use kernel internals like kmalloc. I converted a few
zlib_inflate files with sed already. But things will get really ugly if
we have to do more on-the-fly modifications. After all,
arch/$ARCH/boot is no kernel code, it has to be standalone.
Maybe we should just have no arch/powerpc/boot.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
