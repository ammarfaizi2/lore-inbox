Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSLIG4D>; Mon, 9 Dec 2002 01:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSLIG4D>; Mon, 9 Dec 2002 01:56:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28411 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264625AbSLIG4C>;
	Mon, 9 Dec 2002 01:56:02 -0500
Message-ID: <3DF44031.58A12F66@mvista.com>
Date: Sun, 08 Dec 2002 23:03:13 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 20
References: <3DF2F8D9.6CA4DC85@mvista.com> <1039341009.1483.3.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> On Sun, 2002-12-08 at 08:46, george anzinger wrote:
> 
> > +/*
> > + * Here is an SMP helping macro...
> > + */
> > +#ifdef CONFIG_SMP
> > +#define IF_SMP(a) a
> > +#else
> > +#define IF_SMP(a)
> > +#endif
> 
> ehmmmmm personally I would consider any need of this ugly and evil
> 
> > +     IF_SMP(if (old_base && (new_base != old_base))
> > +            spin_unlock(&old_base->lock);
> > +             )
> 
> Like here..... SMP dependent ifdef's of spinlock usage... shudder
> 
Well it does seem like a waste to do spinlock ordering code
on a UP system...
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
