Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283190AbRK2M4S>; Thu, 29 Nov 2001 07:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283198AbRK2M4I>; Thu, 29 Nov 2001 07:56:08 -0500
Received: from ns.caldera.de ([212.34.180.1]:9858 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283190AbRK2M4D>;
	Thu, 29 Nov 2001 07:56:03 -0500
Date: Thu, 29 Nov 2001 13:55:49 +0100
Message-Id: <200111291255.fATCtnE25671@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: ink@jurassic.park.msu.ru (Ivan Kokshaysky)
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] /proc/interrupts fixes
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011129154611.A13470@jurassic.park.msu.ru>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011129154611.A13470@jurassic.park.msu.ru> you wrote:
> Is /proc/interrupts now allowed only on s390, x86 and mips? ;-)

Umm, it is present everywhere _but_ s390, afaik.

> -#if defined(CONFIG_ARCH_S390) || defined(CONFIG_X86) || defined(CONFIG_ARCH_MIPS)
>  	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
> -#endif

I think that should be

#if !defined(CONFIG_ARCH_S390)

