Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWEUEiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWEUEiW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 00:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWEUEiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 00:38:22 -0400
Received: from ozlabs.org ([203.10.76.45]:27827 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751440AbWEUEiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 00:38:21 -0400
Subject: Re: [patch] i386, vdso=[0|1] boot option and
	/proc/sys/vm/vdso_enabled
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       kraxel@suse.de
In-Reply-To: <446EE992.4020604@vmware.com>
References: <1147759423.5492.102.camel@localhost.localdomain>
	 <20060516064723.GA14121@elte.hu>
	 <1147852189.1749.28.camel@localhost.localdomain>
	 <20060519174303.5fd17d12.akpm@osdl.org>	<20060520010303.GA17858@elte.hu>
	 <20060519181125.5c8e109e.akpm@osdl.org>
	 <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
	 <20060520085351.GA28716@elte.hu>	<20060520022650.46b048f8.akpm@osdl.org>
	 <446EE1C2.7060400@vmware.com> <20060520024842.69c77aaf.akpm@osdl.org>
	 <446EE992.4020604@vmware.com>
Content-Type: text/plain
Date: Sun, 21 May 2006 14:38:17 +1000
Message-Id: <1148186298.29161.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-20 at 03:04 -0700, Zachary Amsden wrote:
> >>  Index: linux-2.6.17-rc/include/asm-i386/fixmap.h
> >>  ===================================================================
> >>  --- linux-2.6.17-rc.orig/include/asm-i386/fixmap.h	2006-03-19 21:53:29.000000000 -0800
> >>  +++ linux-2.6.17-rc/include/asm-i386/fixmap.h	2006-05-19 18:16:00.000000000 -0700
> >>  @@ -20,7 +20,7 @@
> >>    * Leave one empty page between vmalloc'ed areas and
> >>    * the start of the fixmap.
> >>    */
> >>  -#define __FIXADDR_TOP	0xfffff000
> >>  +#define __FIXADDR_TOP	0xffbff000
> >>     
> >
> > The machine runs OK with that applied and with
> > move-vsyscall-page-out-of-fixmap-into-normal-vma-as-per-mmap.patch not
> > applied.
> >   
> 
> Err.  That implies that there is likely a problem in the kernel patch, 
> not in userspace,  Let's look more closely at 
> move-vsyscall-page-out-of-fixmap-into-normal-vma-as-per-mmap and see if 
> there is something missing.

Indeed.  And I really hate the idea of a global switch for this, too: it
should just work, or autodetect (esp if it's init that failing, this
might be possible).

Off to find FC1...
Rusty.
-- 
 ccontrol: http://ccontrol.ozlabs.org

