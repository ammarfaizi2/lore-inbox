Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbULECsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbULECsC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbULECsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:48:02 -0500
Received: from gate.crashing.org ([63.228.1.57]:44236 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261232AbULECr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:47:58 -0500
Subject: Re: Proposal for a userspace "architecture portability" library
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
In-Reply-To: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 05 Dec 2004 13:44:07 +1100
Message-Id: <1102214647.5520.133.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 11:53 +1100, Paul Mackerras wrote:

> I'm looking for volunteers to help with porting and testing on various
> architectures.  I can do x86, ppc and ppc64, and I know sparc{,64} and
> m68k assembler, but for the rest I'll need help.
> 
> My hope is that distributions will be able to use this to replace some
> of the headers in /usr/include/asm, and thus reduce the desire for
> applications to include kernel headers.

Interesting ... note also that it goes well with my intend of having
some of these (atomics, locks, ...) be provided by the kernel via the
vDSO library mapped by the kernel in userland on ppc. That library would
abstract that nicely. (That way, the kernel can take care of providing
the best implementation for a given processor, dealing with CPU errata
that often happen around areas of locks & atomics, etc...)

Ben.


