Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265148AbRFUT0M>; Thu, 21 Jun 2001 15:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265149AbRFUT0A>; Thu, 21 Jun 2001 15:26:00 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:47649 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265148AbRFUTZo>; Thu, 21 Jun 2001 15:25:44 -0400
Date: Thu, 21 Jun 2001 14:25:27 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200106211925.OAA09622@tomcat.admin.navo.hpc.mil>
To: jgolds@resilience.com, "Eric S. Raymond" <esr@snark.thyrsus.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> "Eric S. Raymond" wrote:
> > ------------------------------------------------------------------------
> > The GPL license reproduced below is copyrighted by the Free Software
> > Foundation, but the Linux kernel is copyrighted by me and others who
> > actually wrote it.
> > 
> > The GPL license requires that derivative works of the Linux kernel
> > also fall under GPL terms, including the requirement to disclose
> > source.  The meaning of "derivative work" has been well established
> > for traditional media, and those precedents can be applied to
> > inclusion of source code in a straightforward way.  But as of
> > mid-2001, neither case nor statute law has yet settled under what
> > circumstances *binary* linkage of code to a kernel makes that code a
> > derivative work of the kernel.
> > 
> > To calm down the lawyers, I as the principal kernel maintainer and
> > anthology copyright holder on the code am therefore adding the
> > following interpretations to the kernel license:
> > 
> > 1. Userland programs which request kernel services via normal system
> >    calls *are not* to be considered derivative works of the kernel.
> > 
> > 2. A driver or other kernel component which is statically linked to
> >    the kernel *is* to be considered a derivative work.
> > 
> > 3. A kernel module loaded at runtime, after kernel build, *is not*
> >    to be considered a derivative work.
> > 
> > These terms are to be considered part of the kernel license, applying
> > to all code included in the kernel distribution.  They define your
> > rights to use the code in *this* distribution, however any future court
> > may rule on the underlying legal question and regardless of how the
> > license or interpretations attached to future distributions may change.
> 
> I disagree with 2.  Consider the following:
> 
> - GPL library foo is used by application bar.  bar must be GPL because
> foo is.  I agree with this.
> - Non-GPL library foo is used by GPL application bar.  foo does NOT
> become GPL just because bar is, even if bar statically linked foo in.
> 
> The kernel is the equivalent of an application.  If someone needs to
> statically link in a driver, which is the equivalent of a library, I
> don't see how that should make the driver GPL.

Isn't this all covered by the LGPL ? (Library GPL)

If the kernel is counted as a library (by the module, or the module
counted as a library by the kernel) doesn't that fit with the LGPL
definition? I believe the LGPL covers the runtime library.

This was hashed out some time ago - If I remember correctly Linus didn't
favor the LGPL for kernel because that ment the interface between
the kernel and modules had to become more "static", restricting the
future enhancements of the kernel/module interface.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
