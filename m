Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269064AbRHPXeS>; Thu, 16 Aug 2001 19:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268971AbRHPXd7>; Thu, 16 Aug 2001 19:33:59 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23328 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269002AbRHPXdz>; Thu, 16 Aug 2001 19:33:55 -0400
Date: Fri, 17 Aug 2001 01:33:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mark Hemment <markhe@veritas.com>, Juergen Doelle <JDOELLE@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Align VM locks
Message-ID: <20010817013356.E8726@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0108161839180.3340-100000@alloc.wat.veritas.com>, <Pine.LNX.4.33.0108161839180.3340-100000@alloc.wat.veritas.com>; <20010816202606.B8726@athlon.random> <3B7C1B8F.708CBB9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B7C1B8F.708CBB9@zip.com.au>; from akpm@zip.com.au on Thu, Aug 16, 2001 at 12:14:23PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 12:14:23PM -0700, Andrew Morton wrote:
> Problem with this approach is that it doesn't prevent the linker
> from placing other data in the same cacheline as the aligned
> lock, at higher addresses.

that was partly intentional, but ok we can be more aggressive on that
side ;).

> Juergen, I'd suggest you dust off that patch, add the conditionals
> which make it a no-op on uniprocessor and submit it.  It's such a

agreed, btw it is just a noop on up but it is undefined for __GNUC__ >
2, also it would be nice if he could do it in linux/ instead of asm/, it
should not need special arch trick (spinlock_t and SMP_CACHE_SIZE are
the only thing it needs).

Andrea
