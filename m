Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUDGV1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUDGV1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:27:17 -0400
Received: from ns.suse.de ([195.135.220.2]:4793 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264174AbUDGV1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:27:14 -0400
Date: Wed, 7 Apr 2004 23:27:12 +0200
From: Andi Kleen <ak@suse.de>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mbligh@aracnet.com
Subject: Re: NUMA API for Linux
Message-Id: <20040407232712.2595ac16.ak@suse.de>
In-Reply-To: <1081373058.9061.16.camel@arrakis>
References: <1081373058.9061.16.camel@arrakis>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2004 14:24:19 -0700
Matthew Dobson <colpatch@us.ibm.com> wrote:

> 	I must be missing something here, but did you not include mempolicy.h
> and policy.c in these patches?  I can't seem to find them anywhere?!? 
> It's really hard to evaluate your patches if the core of them is
> missing!

It was in the core patch and also in the last patch I sent Andrew.
See ftp://ftp.suse.com/pub/people/ak/numa/* for the full patches

> 
> Andrew already mentioned your mistake on the i386 syscalls which needs
> to be fixed.

That's already fixed
 
> Also, this snippet of code is in 2 of your patches (#1 and #6) causing
> rejects:
> 
> @@ -435,6 +445,8 @@
>  
>  struct page *shmem_nopage(struct vm_area_struct * vma,
>                          unsigned long address, int *type);
> +int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy
> *new);
> +struct mempolicy *shmem_get_policy(struct vm_area_struct *vma, unsigned
> long addr);
>  struct file *shmem_file_setup(char * name, loff_t size, unsigned long
> flags);
>  void shmem_lock(struct file * file, int lock);
>  int shmem_zero_setup(struct vm_area_struct *);


It didn't reject for me. 

> Just from the patches you posted, I would really disagree that these are
> ready for merging into -mm.

Why so? 

-Andi
