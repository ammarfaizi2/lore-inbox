Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSEIHg7>; Thu, 9 May 2002 03:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSEIHg6>; Thu, 9 May 2002 03:36:58 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:29189 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315628AbSEIHg5>; Thu, 9 May 2002 03:36:57 -0400
Date: Thu, 9 May 2002 17:36:46 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, engebret@vnet.ibm.com, justincarlson@cmu.edu,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        anton@samba.org, ak@suse.de
Subject: Re: Memory Barrier Definitions
Message-Id: <20020509173646.5c1b5baa.rusty@rustcorp.com.au>
In-Reply-To: <15577.23356.338023.88947@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002 10:07:08 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> The ia64 memory ordering model is quite orthogonal to the one that
> Linux uses (which is based on the Alpha instructions): Linux
> distinguishes between read and write memory barriers.  ia64 uses an
> acquire/release model instead.  An acquire orders all *later* memory
> accesses and a release orders all *earlier* accesses (regardless of
> whether they are reads or writes).  Another difference is that the
> acquire/release semantics is attached to load/store instructions,
> respectively.  This means that in an ideal world, ia64 would rarely
> need to use the memory barrier instruction.

Hmmm... could you explain more?  You're saying that every load is
an "acquire" and every store a "release"?  Or that they can be flagged
that way, but aren't always?

Does this means that an "acquire" means "all accesses after this insn
(in the code stream) must occur after this insn (in time)"?  Does
that only apply to the address that instruction touched, or all?

Confused,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
