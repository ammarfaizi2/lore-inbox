Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267896AbUHEVi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267896AbUHEVi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267984AbUHEViG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:38:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:33943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267964AbUHEVfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:35:24 -0400
Date: Thu, 5 Aug 2004 14:38:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1
Message-Id: <20040805143848.1985deb2.akpm@osdl.org>
In-Reply-To: <20040805130308.GC14358@holomorphy.com>
References: <20040805031918.08790a82.akpm@osdl.org>
	<20040805130308.GC14358@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6.8-rc3-mm1/
> > - Added David Woodhouse's MTD tree to the "external trees" list
> > - Dropped the staircase scheduler, mainly because the schedstats patch broke
> >   it.
> >   We learned quite a lot from having staircase in there.  Now it's time for
> >   a new scheduler anyway.
> 
> One of these changes means we need to be able to dereference struct
> device in include/asm-ia64/dma-mapping.h.
> 
> --- mm1-2.6.8-rc3/include/asm-ia64/dma-mapping.h.orig	2004-08-05 22:56:27.204548702 -0700
> +++ mm1-2.6.8-rc3/include/asm-ia64/dma-mapping.h	2004-08-05 22:57:40.435993118 -0700
> @@ -5,7 +5,8 @@
>   * Copyright (C) 2003-2004 Hewlett-Packard Co
>   *	David Mosberger-Tang <davidm@hpl.hp.com>
>   */
> -
> +#include <linux/config.h>
> +#include <linux/device.h>
>  #include <asm/machvec.h>
>  

Yes, I hit the same problem on x86_64.  But I have no patches touching
that file.  Can you send the compiler output, help me work out which patch
needs the patch?

