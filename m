Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVJaGAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVJaGAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVJaGAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:00:50 -0500
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:14798 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S932426AbVJaGAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:00:50 -0500
Date: Sun, 30 Oct 2005 22:06:54 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/5] i386 generic cmpxchg
In-Reply-To: <4365736B.4050506@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0510302206250.1526@montezuma.fsmlabs.com>
References: <436416AD.3050709@yahoo.com.au> <4364171C.7020103@yahoo.com.au>
 <Pine.LNX.4.61.0510301157440.1526@montezuma.fsmlabs.com> <4365736B.4050506@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Nick Piggin wrote:

> Zwane Mwaikambo wrote:
> > Hi Nick,
> > 
> > On Sun, 30 Oct 2005, Nick Piggin wrote:
> > 
> > +#define cmpxchg(ptr,o,n)						\
> > +({									\
> > +	__typeof__(*(ptr)) __ret;					\
> > +	if (likely(boot_cpu_data.x86 > 3))				\
> > +		__ret = __cmpxchg((ptr), (unsigned long)(o),		\
> > +					(unsigned long)(n), sizeof(*(ptr))); \
> > +	else								\
> > +		__ret = cmpxchg_386((ptr), (unsigned long)(o),		\
> > +					(unsigned long)(n), sizeof(*(ptr))); \
> > +	__ret;								\
> > +})
> > +#endif
> > 
> > How about something similar to the following to remove the branch on
> > optimised kernels?
> > 
> 
> This is only in the !CONFIG_X86_CMPXCHG case, though, so the branch would
> only be there on a 386 kernel, I think?

Ah yes you are right, i missed the #else.

Thanks,
	Zwane

