Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265104AbRFUSwa>; Thu, 21 Jun 2001 14:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbRFUSwK>; Thu, 21 Jun 2001 14:52:10 -0400
Received: from mcp.csh.rit.edu ([129.21.60.9]:27403 "EHLO mcp.csh.rit.edu")
	by vger.kernel.org with ESMTP id <S265104AbRFUSwD>;
	Thu, 21 Jun 2001 14:52:03 -0400
Date: Thu, 21 Jun 2001 14:51:57 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Jeff Golds <jgolds@resilience.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Controversy over dynamic linking -- how to end the panic
Message-ID: <20010621145156.B5801@fury.csh.rit.edu>
In-Reply-To: <200106211814.f5LIEgK04880@snark.thyrsus.com> <3B323F51.BEDC7712@resilience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3B323F51.BEDC7712@resilience.com>; from jgolds@resilience.com on Thu, Jun 21, 2001 at 11:39:13AM -0700
X-Operating-System: SunOS 5.8 (sun4u)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 11:39:13AM -0700, Jeff Golds wrote:
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
> 
> 
> -Jeff
> 
> P.S.  I don't claim to be a lawyer, this is just my opinion.

    http://www.gnu.org/copyleft/gpl-faq.html#WritingFSWithNFLibs offers some
    insight on linking free software with non-free libraries.

    However, I'm not sure I agree with your interpretation of the relationship
    between kernel and driver.

    The kernel is fully functional (excluding use of the hardware for which
    the driver provides an interface) without the driver code - however, the
    driver requires the kernel to be usable. Still using your analogy, it would
    seem the driver is the application, and the kernel is the library.
    The facilities that the driver provides to the kernel don't seem to be
    much more than callbacks used in traditional library schemes to implement
    application specific behavior as part of a larger library framework.

    My 2c.

    -Jeff

-- 
Jeff Mahoney
jeffm@suse.com
jeffm@csh.rit.edu
