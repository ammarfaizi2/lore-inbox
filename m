Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbULEAxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbULEAxu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 19:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbULEAxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 19:53:49 -0500
Received: from ozlabs.org ([203.10.76.45]:42674 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261213AbULEAxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 19:53:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
Date: Sun, 5 Dec 2004 11:53:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Proposal for a userspace "architecture portability" library
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of our kernel headers implement generally useful abstractions
across all of the architectures we support.  I would like to make an
"architecture portability" library, based on the kernel headers but as
a separate project from the kernel, and intended for use in userspace.

The headers that I want to base this on are:

atomic.h
bitops.h
byteorder.h
rwsem.h
semaphore.h
spinlock.h
system.h (for mb et al., xchg, cmpxchg)
unaligned.h

There are some others that may also be useful: cache.h, checksum.h,
io.h, xor.h.

Now, clearly I can do this under the GPL.  However, I think it would
be more useful to have the library under the LGPL, which requires
either getting the permission of the authors of the kernel files, or
rewriting them from scratch.

Linus (and other kernel copyright holders) - would you be willing to
relicense such of the above files that have your copyright under the
LGPL for this purpose?

I'm looking for volunteers to help with porting and testing on various
architectures.  I can do x86, ppc and ppc64, and I know sparc{,64} and
m68k assembler, but for the rest I'll need help.

My hope is that distributions will be able to use this to replace some
of the headers in /usr/include/asm, and thus reduce the desire for
applications to include kernel headers.

Paul.

