Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSIZRpe>; Thu, 26 Sep 2002 13:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261428AbSIZRpb>; Thu, 26 Sep 2002 13:45:31 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:22545 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261426AbSIZRp2>; Thu, 26 Sep 2002 13:45:28 -0400
Date: Thu, 26 Sep 2002 13:50:14 -0400
From: Ben Collins <bcollins@debian.org>
To: Shanti Katta <katta@csee.wvu.edu>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: Reg Sparc memory addresses
Message-ID: <20020926175014.GK28289@phunnypharm.org>
References: <1033005676.2723.5.camel@indus> <20020926015645.GE28289@phunnypharm.org> <1033062898.2037.43.camel@indus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033062898.2037.43.camel@indus>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 01:54:57PM -0400, Shanti Katta wrote:
> On Wed, 2002-09-25 at 21:56, Ben Collins wrote:
> > On Wed, Sep 25, 2002 at 10:01:15PM -0400, Shanti Katta wrote:
> > > Hi,
> > > I compiled user-mode-linux kernel on Ultrasparc with load address set to
> > > 00000000e0000000. But, when I try to debug the kernel, it just says
> > > cannot access memory at address 0xa00020b0.
> > > This error message remains the same no matter what I change the load
> > > address to. Can anyone guide me on valid memory addresses for userspace
> > > on Sparc? and how much different is that from x86 architecture?
> > 
> > You compiled it on ultrasparc, but I hope you compiled it as a "sparc"
> > target and not "sparc64".
> 
> I compiled UML as "sparc64".
> 
>  
> > I'm not familiar with how UML runs in user space, but I suspect it needs
> > to think it is sparc and not sparc64 for it to run in 32bit sparc
> > userspace (which is what ultrasparc runs at for most cases).
> > 
> So, I guess I need to compile UML as "sparc" target and debug it. I am
> not sure how much of UML code runs in kernelspace and how much in
> userspace. So, do I need to compile only the userspace code for UML as
> "sparc" target or the whole of UML?

I believe it all runs in userspace (hence the name user-mode-linux :)

Compiling for sparc64 is the problem I suspect. IIRC, UML uses the
asm-<arch> that you choose, which will break when sparc64 headers are
used for a sparc32 application.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
