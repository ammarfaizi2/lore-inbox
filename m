Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHRid>; Thu, 8 Feb 2001 12:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBHRiO>; Thu, 8 Feb 2001 12:38:14 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:44422 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129033AbRBHRiC>;
	Thu, 8 Feb 2001 12:38:02 -0500
Message-Id: <m14Qv0z-000OaDC@amadeus.home.nl>
Date: Thu, 8 Feb 2001 18:37:53 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: manfred@colorfullife.com (Manfred Spraul)
Subject: Re: sse for fast_clear_page()?
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <3A82D325.9068BC07@colorfullife.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A82D325.9068BC07@colorfullife.com> you wrote:
> fast_clear_page() uses mmx instructions for clearing a page, what about
> using sse instructions?
> sse instructions can store 128 bit in one instruction, mmx only 64 bit.

the sse FP registers might be lossy. On my athlon, the in-kernel mmx
functions are memory-bound (eg > 1 Gbyte/sec throughput)

Userspace program for the athlon code:

http://www.fenrus.demon.nl/athlon.c

Greetings,
   Arjan van de Ven


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
