Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSHBV1d>; Fri, 2 Aug 2002 17:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317078AbSHBV1d>; Fri, 2 Aug 2002 17:27:33 -0400
Received: from mnh-1-15.mv.com ([207.22.10.47]:34309 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317034AbSHBV1c>;
	Fri, 2 Aug 2002 17:27:32 -0400
Message-Id: <200208022233.RAA04165@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accelerating user mode linux 
In-Reply-To: Your message of "Fri, 02 Aug 2002 13:48:49 -0400."
             <200208021748.g72HmnV08218@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 17:33:51 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@redhat.com said:
> That really makes all the existing code not work with it.

Can you be more specific?  If you're thinking I'm talking about breaking
mmap, munmap, and mprotect by adding another argument, I'm not.  I'm talking
about adding new syscalls, mmap2, munmap2, mprotect2 (or something more
imaginative), which have the extra argument, having them take -1 as meaning
"fiddle the current address space" and pursuading libc to use them instead
of the current syscalls.  Then we would start the current ones on their way
to the happy syscall hunting grounds in the sky.

> Doing an altmm is easy in the sense that it doesn't require 20 new
> syscall

I don't think I mentioned 20 new syscalls anywhere :-)  If you count the
ones above as replacements and not new, I'm talking about one new syscall -
switch_mm(), which I didn't mention before, that would switch to a given
address space.  This would be the basis of UML's switch_mm.

> and doesnt slow down the main kernel paths for a single odd
> case.

Which main kernel paths are you referring to here?

				Jeff

