Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265202AbRFUUev>; Thu, 21 Jun 2001 16:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265204AbRFUUem>; Thu, 21 Jun 2001 16:34:42 -0400
Received: from boreas.isi.edu ([128.9.160.161]:5105 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S265202AbRFUUe1>;
	Thu, 21 Jun 2001 16:34:27 -0400
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic 
In-Reply-To: Your message of "Thu, 21 Jun 2001 14:14:42 EDT."
             <200106211814.f5LIEgK04880@snark.thyrsus.com> 
Date: Thu, 21 Jun 2001 13:34:20 -0700
Message-ID: <1110.993155660@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	IANAL.  I also dislike fencepost errors.  Hence, these
comments.

	The GNU GPL Version 2, June 1991, (hereafter the GPL), applies
"to the modified work as a whole".  Consequently:

>2. A driver or other kernel component which is statically linked to
>   the kernel *is* to be considered a derivative work.

	The kernel image, including the statically-linked device
driver, is the primary derived work licensed by the GPL.  That portion
of the kernel image that represents some actual device driver binary
code (continuing the example above, and assuming that the device
driver's unlinked object code isn't already subject to the provisions
of the GPL), may or may not be a derived work under copyright law,
depending upon what modifications the linker made to the binary code
during linking. If the device driver didn't become a derived work
during compilation, and it didn't (for example) resolve any kernel
symbols during linking, it would not be a derived work under copyright
law, right?  Of course, right.

>3. A kernel module loaded at runtime, after kernel build, *is not*
>   to be considered a derivative work.

	The in-core kernel image, including a dynamically-loaded
driver, is clearly a derived work per copyright law.  As above, the
portion consisting only of the dynamically-loaded driver's binary code
may or may not be a derived work per the GPL.  It doesn't much matter
under the GPL, anyway, so long as the in-code kernel image isn't
"copied or distributed".

	Looking to the future, what if Linux is enhanced with the
ability to take a snapshot of a running system (including any
dynamically-loaded driver modules), and the snapshots are copied and
distributed by, say, a PDA vendor to make an instant-on Linux system?
I think it's reasonable to argue that the GPL requirements must apply
to all parts of the distributed kernel image, even the parts that were
derived from pre-snapshot dynamically-loaded modules.


	The act of "copying and distributing" a linked kernel image
containing GPL'ed code and, say, a non-GPL'ed device driver, requires
that the distributor follow the requirements of the GPL as applied to
the work as a whole, which means that source code must be available
for *all* portions of the linked kernel, which means that source code
for the driver must be made available... under the terms of sections 1
and 2 of the GPL.  The GPL's source code availability requirement
applies even to those identifiable sections of the linked kernel image
which themselves are not derived (per copyright law) from GPL'ed
sources.

	Remember, however, that the GPL, as written, imposes
requirements upon the the *distributor* of a combined work, not upon
the owner of the non-GPL'ed portions that were included in the
combined work.  It is the distributor's responsibility to make source
code available as require by the GPL.  This is *not* the same as
saying that any non-GPL'ed source code in question has, automatically,
itself become licensed under the GPL (sections 1 and 2).

					Craig Milo Rogers
