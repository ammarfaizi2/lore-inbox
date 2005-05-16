Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVEPMzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVEPMzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVEPMzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:55:42 -0400
Received: from web60512.mail.yahoo.com ([209.73.178.175]:4237 "HELO
	web60512.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261597AbVEPMza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:55:30 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=BARbxwPIofPRu8mYwuGZ5qcwPmloM89IMNr+avhIq6rj9boUjnIbdgP2MZziwVD0DSn/qkJ1wOO7NcBW7NNIOz5jHQtyN4cbUmMSGbDL4tTTf7Xzc+LbxcSm2S3a23u133ugDuufn+hXA5U4MlservtmFo/FlN7+9/P/lOb9Bsk=  ;
Message-ID: <20050516125526.82482.qmail@web60512.mail.yahoo.com>
Date: Mon, 16 May 2005 05:55:26 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: Re: How to use memory over 4GB
To: Roberto Fichera <kernel@tekno-soft.it>, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess u r on 32-bit platform.
Then, u need to enable PAE ( if not enabled alredy)
and rebuild the kernel.
This will be transparent to the user space.
Ur word size will still be 32-bit, only thing is PAE
will change the way u translate the address by adding
one more level of indexing to the page table.

-lnxluv.

--- Roberto Fichera <kernel@tekno-soft.it> wrote:
> Hi All,
> 
> I've a dual Xeon 3.2GHz HT with 8GB of memory
> running kernel 2.6.11.
> I whould like to know the way how to use all the
> memory in a single
> process, the application is a big simulation which
> needs big memory chuncks.
> I have readed about hugetlbfs, shmfs and tmpfs, but
> don't understand how I 
> can access
> the whole memory. Ok! I can create a big file on
> tmpfs using shm_open() and
> than map it by using mmap() or mmap2() but how can I
> access over 4GB using
> standard pointers (if I had to use it)?
> 
> So, please send me some url, documents etc and/or
> piece
> of source code that shows how to do it in user
> space.
> 
> Thanks _very much_ in advance,
> 
> Roberto Fichera. 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
