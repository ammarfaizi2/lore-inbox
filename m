Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUFVJet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUFVJet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 05:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUFVJet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 05:34:49 -0400
Received: from catv-5062fad2.catv.broadband.hu ([80.98.250.210]:48397 "EHLO
	balabit.hu") by vger.kernel.org with ESMTP id S261981AbUFVJeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 05:34:36 -0400
Subject: Re: kernel oops on ia64 (2.6.6 + 0521 ia64 patch)
From: KOVACS Krisztian <hidden@balabit.hu>
To: David Mosberger <davidm@napali.hpl.hp.com>
Cc: Balazs Scheidler <bazsi@balabit.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <16593.62204.126371.863028@napali.hpl.hp.com>
References: <1087420973.4345.19.camel@bzorp.balabit>
	 <16592.60876.886257.165633@napali.hpl.hp.com>
	 <1087489727.30553.0.camel@bzorp.balabit>
	 <16593.62204.126371.863028@napali.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-2
Message-Id: <1087896874.2358.12.camel@nienna.balabit>
Mime-Version: 1.0
Date: Tue, 22 Jun 2004 11:34:34 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

2004-06-17, cs keltezéssel 21:37-kor David Mosberger ezt írta:
> >>>>> On Thu, 17 Jun 2004 18:28:48 +0200, Balazs Scheidler <bazsi@balabit.hu> said:
> 
>   >>  Does the oops go away with an SMP kernel?
> 
>   Balazs> yes, it does.
> 
> Does the attached patch fix the UP problem for you?

  No, it still dies while running the ./configure script...

> ===== include/asm-ia64/gcc_intrin.h 1.5 vs edited =====
> --- 1.5/include/asm-ia64/gcc_intrin.h	Mon May 10 23:44:41 2004
> +++ edited/include/asm-ia64/gcc_intrin.h	Thu Jun 17 12:10:52 2004
> @@ -581,7 +587,7 @@
>  
>  #define ia64_intrin_local_irq_restore(x)			\
>  do {								\
> -	asm volatile ("     cmp.ne p6,p7=%0,r0;;"		\
> +	asm volatile (";;   cmp.ne p6,p7=%0,r0;;"		\
>  		      "(p6) ssm psr.i;"				\
>  		      "(p7) rsm psr.i;;"			\
>  		      "(p6) srlz.d"				\

-- 
 Regards,
   Krisztian KOVACS

