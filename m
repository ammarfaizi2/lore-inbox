Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVJJAVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVJJAVR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 20:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVJJAVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 20:21:17 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:30983 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932313AbVJJAVQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 20:21:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kxWTgaASdZTxY1svqPIfpSyMBCgPHNfJEn2tcwBYwcauEus9t6ZlF1LLcW3WC3oebKDVMIJP8SFmuRfLc8+h7W0LHDYntLrpkLXTUVMEVPwwPq6pxXZ3WrKT1DFH3Pw969Y/dK3pVgnUVa9BaZ8gba3pmw86mIgIKXCKIEYTHvo=
Message-ID: <1e62d1370510091721m530327a9v546da9115a861bdf@mail.gmail.com>
Date: Mon, 10 Oct 2005 05:21:13 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Vivek Kutal <vivek.kutal@gmail.com>
Subject: Re: Need for SHIFT and MASK
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
In-Reply-To: <b9a245c10510091140q78c2480dqb095a7cdab12932e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b9a245c10510090502r4e87696fqe111c0071e7f2a03@mail.gmail.com>
	 <200510091423.24660.ioe-lkml@rameria.de>
	 <b9a245c10510091140q78c2480dqb095a7cdab12932e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/05, Vivek Kutal <vivek.kutal@gmail.com> wrote:
>
> > This is usally table driven and someone has to set up
> > this "Page Translation Tables". That's a job of the Linux kernel.
>
> Yes setting up the page table entries is the job of the kernel , but
> for that we need to put the physical add. of the page and some bits
> (present,access writes etc) in the entry, once it is done the main job
> of translation which requires the masking and shifting is done by the
> processor whenever that page is referenced .
> so why these macros are present in the kernel?
>
>

The setting of the Page Translation Tables are done by the Kernel, and
processor actually do the traversing over those page table entries
(PGD, PMD, PTE) to get the physical address of the page and then add
the last 12-bits of virtual/linear address to get to the physical
address .....

And as far as SHIFT, MASK, SIZE macros are concerned they are used in
creating Page Translation Tables and also used to get the translation
from linear to physical, SIZE macro used to get the current PAGE_SIZE,
SHIFT can be used to get PFN etc in Kernel Code ....

(I might not able to explain, just b/c I think your question is not so
clear to me !!!). You better study the stuffs and search in the kernel
code for those SHIFT, MASK, SIZE macros and you will see where they
are needed and used !!!!!


--
Fawad Lateef
