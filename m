Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVCBObV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVCBObV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVCBO30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:29:26 -0500
Received: from web54603.mail.yahoo.com ([68.142.225.187]:9325 "HELO
	web54603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262323AbVCBO2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:28:40 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Qj8KdN9z7AFhGWNDVEnpV96Gs0Bm0Hk7b21TkySfn/gELj41V6EwMYWAdE5mC+VVuU0R6IZGgo1XuakLct77CUJ8kkys0P/cs3ap8szOddhWmIsRlNkODU8PreGDFZ/8ZNW6/jPkbbXiJyUm8vhYGzvHmROLHF1Ic/YuwlFgE4w=  ;
Message-ID: <20050302142836.8560.qmail@web54603.mail.yahoo.com>
Date: Wed, 2 Mar 2005 06:28:36 -0800 (PST)
From: Prakash Bhurke <prakash_bhurke@yahoo.com>
Subject: Re: memory mapping of vmalloc
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503011713470.31799@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Hugh,

   rvmallaoc is working.
   Very Very Thanks.

Regards,
Prakash

--- Hugh Dickins <hugh@veritas.com> wrote:

> On Tue, 1 Mar 2005, Prakash Bhurke wrote:
> >   I am trying to map a vmalloc kernel buffer to
> user
> > space using remap_page_range(). In my module, this
> > function returns success if we call mmap() from
> user
> > space, but i can not access content of vmalloc
> buffer
> > from user space. Pointer returned by mmap()
> syscall
> > seems pointing to other memory page which contains
> > zeros. I am using linux 2.6.10 kernel on Pentium 4
> > system.
> 
> Look for "rvmalloc" in various drivers in the kernel
> source tree:
> you must SetPageReserved before remap_pfn_range (or
> remap_page_range)
> agrees to map the page, and ClearPageReserved before
> freeing after.
> 
> Hugh
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/
