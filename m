Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314477AbSECQLK>; Fri, 3 May 2002 12:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314480AbSECQLJ>; Fri, 3 May 2002 12:11:09 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:56811 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314477AbSECQLI>; Fri, 3 May 2002 12:11:08 -0400
Date: Fri, 03 May 2002 09:10:46 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
Message-ID: <4058482389.1020417045@[10.10.2.3]>
In-Reply-To: <20020503175819.A14505@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another interesting problem is that 'struct page *' will be as best a
> cookie, not a valid pointer anymore, not sure what's the best way to
> handle that. Working with pfn would be cleaner rather than working with
> a cookie (somebody could dereference the cookie by mistake thinking it's
> a page structure old style), but if __alloc_pages returns a pfn a whole
> lot of kernel code will break.

Yup, a physical address pfn would probably be best.

(such as tlb size, which is something stupid like 4 pages, IIRC)

> it has 8 pages for data and 2 for instructions, that's 16M data and 4M
> of instructions with PAE

What is "it", a P4? I think the sizes are dependant on which chip you're
using. The x440 has the P4 chips, but the NUMA-Q is is P2 or P3 (even
PPro for the oldest ones, but those don't work at the moment with Linux
on multiquad).

M.

