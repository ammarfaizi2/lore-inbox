Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTIIWGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264606AbTIIWGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:06:38 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:25512 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S264515AbTIIWGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:06:36 -0400
Date: Tue, 9 Sep 2003 15:06:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with remap_page_range
Message-ID: <20030909150635.C20267@home.com>
References: <3F5E7ACD.8040106@tait.co.nz> <20030909100235.A20267@home.com> <3F5E4C0C.1080303@tait.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F5E4C0C.1080303@tait.co.nz>; from dmytro.bablinyuk@tait.co.nz on Wed, Sep 10, 2003 at 09:54:20AM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 09:54:20AM +1200, Dmytro Bablinyuk wrote:
> >
> >
> >>  if (remap_page_range(vma->vm_start,
> >>                       DSP_ADDR,
> >>                       size,
> >>                       vma->vm_page_prot
> >>                       ))
> >>    
> >>
> >
> >Your remap call isn't adding _PAGE_NO_CACHE and _PAGE_GUARDED flags
> >like ioremap_nocache()/ioremap() do on PPC.  You'll get bad results
> >because of the ordering and cache issues resulting from not using
> >these PTE flags.  In 2.6, these can be added using pgprot_noncached()
> >that is defined per-arch.
> >
> >  
> >
> Thank you Matt,
> 
> Coud you please give me en example on how to add these flags to remap in 
> kernel 2.4.21 (powerpc).
> It seems I could not find these flags available in my kernel.

They're defined in include/asm-ppc/pgtable.h

-Matt
