Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVI3Cga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVI3Cga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVI3Cg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:36:29 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:5130 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932391AbVI3Cg3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:36:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mIsPDDJpa4ogpfp9V6B+xc0ysWwS3hfpBnu/juj0kKZNr8WXsafkj6Ynxdxxg1ckmZmjDQ0L9k5cDs+wIPaexyvDoi3VlDsMtm8AAFAZOENhJ4iyO023Ktby5sdl+qg4sb1I8BPrQo6S9ZkhNT+xtr95Gv2gQ5+ujrZGNrGX5hs=
Message-ID: <5bdc1c8b0509291936u2d2036e6ic91f68f33db5342d@mail.gmail.com>
Date: Thu, 29 Sep 2005 19:36:28 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: dwalker@mvista.com
Subject: Re: l2.6.14-rc2-rt7 - build problems - mce?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128046979.987.36.camel@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0509291907x77604133oc1d8a64e9e70dd59@mail.gmail.com>
	 <1128046979.987.36.camel@dhcp153.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/05, Daniel Walker <dwalker@mvista.com> wrote:
> On Thu, 2005-09-29 at 19:07 -0700, Mark Knecht wrote:
> > Hi,
> >    Any ideas how I could configure the kernel to get past this
> > problem? Currently the config file says this about MCE:
> >
> > CONFIG_GART_IOMMU=y
> > CONFIG_SWIOTLB=y
> > CONFIG_X86_MCE=y
> > # CONFIG_X86_MCE_INTEL is not set
> >
> > Can I safely set CONFIG_X86_MCE to no or not set? Or is this something
> > else completely?
>
> I think it's something else completely .. You would be better off
> turning on complete preemption .
>
> Daniel

Thanks.

make allnoconfig   builds
make defconfig fails as per my earlier message

make defconfig and then turning on complete preemption is doing this:

  CC      mm/fadvise.o
  CC      mm/page_alloc.o
  CC      mm/page-writeback.o
  CC      mm/pdflush.o
  CC      mm/readahead.o
  CC      mm/slab.o
mm/slab.c:2404: error: conflicting types for 'kmem_cache_alloc_node'
include/linux/slab.h:122: error: previous declaration of
'kmem_cache_alloc_node' was here
mm/slab.c:2404: error: conflicting types for 'kmem_cache_alloc_node'
include/linux/slab.h:122: error: previous declaration of
'kmem_cache_alloc_node' was here
make[1]: *** [mm/slab.o] Error 1
make: *** [mm] Error 2
lightning linux-2.6.14-rc2-rt7 #

I will continue on. Thanks very much for your help.

Thanks,
Mark
