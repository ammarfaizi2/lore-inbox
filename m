Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283220AbRK2NTB>; Thu, 29 Nov 2001 08:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283219AbRK2NSw>; Thu, 29 Nov 2001 08:18:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:149 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283220AbRK2NSk>;
	Thu, 29 Nov 2001 08:18:40 -0500
Date: Thu, 29 Nov 2001 08:18:39 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] /proc/interrupts fixes
In-Reply-To: <200111291255.fATCtnE25671@ns.caldera.de>
Message-ID: <Pine.GSO.4.21.0111290817270.9516-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Nov 2001, Christoph Hellwig wrote:

> In article <20011129154611.A13470@jurassic.park.msu.ru> you wrote:
> > Is /proc/interrupts now allowed only on s390, x86 and mips? ;-)
> 
> Umm, it is present everywhere _but_ s390, afaik.
> 
> > -#if defined(CONFIG_ARCH_S390) || defined(CONFIG_X86) || defined(CONFIG_ARCH_MIPS)
> >  	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
> > -#endif
> 
> I think that should be
> 
> #if !defined(CONFIG_ARCH_S390)

No, it shouldn't.  It is OK on s390 now and #if is a leftover from the
middle of conversion.  I was sure that I'd removed it...

