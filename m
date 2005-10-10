Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVJJQtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVJJQtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 12:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVJJQtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 12:49:40 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:65159 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750924AbVJJQtj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 12:49:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SYQg2BGQS61s0Ai22GeAa/n1gzDXoDhbZKGLDw/P0D/Qzgc447npmIeCc14XI9cu8Hpmz8SD2VbIczmXxq/AUQecsJTDT2IRvPTxbARX2/80gILgUEdEKsmaYerRPlZNyLe5fDRcTq5GAXYeY5Jgzcxa8i0dLX7tCOGjqhdnJRQ=
Message-ID: <1e62d1370510100949j774bf639k7bb65b347145ecfe@mail.gmail.com>
Date: Mon, 10 Oct 2005 21:49:38 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Vivek Kutal <vivek.kutal@gmail.com>
Subject: Re: Need for SHIFT and MASK
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
In-Reply-To: <b9a245c10510100613m442d93f4gbbec00799dc3b1b9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b9a245c10510090502r4e87696fqe111c0071e7f2a03@mail.gmail.com>
	 <200510091423.24660.ioe-lkml@rameria.de>
	 <b9a245c10510091140q78c2480dqb095a7cdab12932e@mail.gmail.com>
	 <1e62d1370510091721m530327a9v546da9115a861bdf@mail.gmail.com>
	 <b9a245c10510100613m442d93f4gbbec00799dc3b1b9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Vivek Kutal <vivek.kutal@gmail.com> wrote:
> > And as far as SHIFT, MASK, SIZE macros are concerned they are used in
> > creating Page Translation Tables and also used to get the translation
> > from linear to physical
>
> how are these macros used to create page translation tables (functions
> like pgd_alloc(), pmd_alloc() & pte_alloc() are used for this
> purpose)and the  translation (virtual/linear to physical)is done by
> the processor and not by the OS.
>
>

Actually I don't mean by mentioning "SHIFT, MASK, SZIE macros are used
in creating Page Translation Table" that you will see them in
pgd_alloc() etc but they are used in many memory initialization
fucntions at the boot time ...... and for example look
http://lxr.linux.no/source/arch/i386/mm/init.c#L207  !!!!!! These
Macros are might be there for the compatibility reasons tooo as you
can see the PAGE_SIZE can be changed but if you use PAGE_SIZE in every
module/place you won't be concerned about the actual size of the page
at that moment or in Architecture ...........


--
Fawad Lateef
