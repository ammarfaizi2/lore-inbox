Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbULEBHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbULEBHe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 20:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbULEBHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 20:07:34 -0500
Received: from peabody.ximian.com ([130.57.169.10]:63116 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261216AbULEBH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 20:07:29 -0500
Subject: Re: Proposal for a userspace "architecture portability" library
From: Robert Love <rml@novell.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
In-Reply-To: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 04 Dec 2004 20:08:44 -0500
Message-Id: <1102208924.6052.94.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 11:53 +1100, Paul Mackerras wrote:

> Some of our kernel headers implement generally useful abstractions
> across all of the architectures we support.  I would like to make an
> "architecture portability" library, based on the kernel headers but as
> a separate project from the kernel, and intended for use in userspace.

I think that this is an _awesome_ idea.  Might want to check out what
overlap there is with existing glibc interfaces.  For example, I presume
that glibc implements at least some of the atomic operations (but I also
think having a full suite of atomic operations available is useful).

Some of the stuff, like semaphores, isn't really going to port very well
to user-space.  At least not directly, I would not think.

But on numerous occasions I have wanted the kernel's barriers, atomic
operations, bitwise operations, or some of the compiler things we
implement (likely, unlikely, fixes) in user-space.

> Now, clearly I can do this under the GPL.  However, I think it would
> be more useful to have the library under the LGPL, which requires
> either getting the permission of the authors of the kernel files, or
> rewriting them from scratch.

FWIW, you have my permission.  I've touched spinlock.h a bunch.

	Robert Love


