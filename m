Return-Path: <linux-kernel-owner+w=401wt.eu-S1760738AbWLHONN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760738AbWLHONN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760739AbWLHONM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:13:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56745 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760738AbWLHONM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:13:12 -0500
Date: Fri, 8 Dec 2006 09:13:03 -0500
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@osdl.org, Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] slab: remove SLAB_KERNEL
Message-ID: <20061208141303.GA13479@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jens Axboe <jens.axboe@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org, akpm@osdl.org,
	Christoph Lameter <clameter@sgi.com>
References: <200612071659.kB7Gxa89031154@hera.kernel.org> <20061208120207.GA13841@redhat.com> <20061208125942.GQ23887@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208125942.GQ23887@kernel.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 01:59:43PM +0100, Jens Axboe wrote:

 > > --- linux-2.6.19.noarch/mm/mmap.c~	2006-12-08 06:51:55.000000000 -0500
 > > +++ linux-2.6.19.noarch/mm/mmap.c	2006-12-08 06:52:05.000000000 -0500
 > > @@ -2226,7 +2226,7 @@ int install_special_mapping(struct mm_st
 > >  	struct vm_area_struct *vma;
 > >  	int err;
 > >  
 > > -	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 > > +	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 > >  	if (unlikely(vma == NULL))
 > >  		return -ENOMEM;
 > >  	memset(vma, 0, sizeof(*vma));
 > 
 > What kernel is that?

Oops. My bad.   That chunk came from execshield.

		Dave
