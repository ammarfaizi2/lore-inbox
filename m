Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbULEBrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbULEBrL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 20:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbULEBrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 20:47:11 -0500
Received: from ozlabs.org ([203.10.76.45]:22451 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261222AbULEBrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 20:47:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16818.26777.209451.685576@cargo.ozlabs.ibm.com>
Date: Sun, 5 Dec 2004 12:47:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Robert Love <rml@novell.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: Proposal for a userspace "architecture portability" library
In-Reply-To: <1102208924.6052.94.camel@localhost>
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
	<1102208924.6052.94.camel@localhost>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:

> I think that this is an _awesome_ idea.  Might want to check out what
> overlap there is with existing glibc interfaces.  For example, I presume
> that glibc implements at least some of the atomic operations (but I also
> think having a full suite of atomic operations available is useful).

I don't think glibc exports any atomic operations.  As for the
semaphores and spinlocks, clearly you can use the pthread_* functions,
but hopefully the kernel versions are a bit lighter-weight.

> Some of the stuff, like semaphores, isn't really going to port very well
> to user-space.  At least not directly, I would not think.

No, for semaphores and rwsems I was going to use futexes.  Or maybe we
don't need the kernel's semaphores, rwsems and spinlocks in userspace
at all.  I'm open to suggestions.

> FWIW, you have my permission.  I've touched spinlock.h a bunch.

Thanks.

Paul.
