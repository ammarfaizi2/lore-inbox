Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVIGREB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVIGREB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVIGREB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:04:01 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34182 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750705AbVIGREA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:04:00 -0400
Subject: Re: [PATCH 01/11] memory hotplug prep: kill local_mapnr
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050907023728.732a5a9f.akpm@osdl.org>
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
	 <20050907023728.732a5a9f.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 10:03:06 -0700
Message-Id: <1126112586.7329.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 02:37 -0700, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> >  --- memhotplug/include/asm-x86_64/mmzone.h~C0-kill-local_mapnr	2005-08-18 14:59:43.000000000 -0700
> >  +++ memhotplug-dave/include/asm-x86_64/mmzone.h	2005-08-18 14:59:43.000000000 -0700
> >  @@ -38,8 +38,6 @@ static inline __attribute__((pure)) int 
> >   
> >   #ifdef CONFIG_DISCONTIGMEM
> >   
> >  -#define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
> >  -#define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))
> >   
> >   /* AK: this currently doesn't deal with invalid addresses. We'll see 
> >      if the 2.5 kernel doesn't pass them
> >  _
> 
> What's this bit doing here?   It breaks the x86_64 build all over the place.
> 
> I'll drop that chunk and see how we go...

That could have easily been some merge borkage on my part.  I don't
think that hunk is valid, so dropping it is the right move.

-- Dave

