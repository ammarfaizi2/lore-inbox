Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131390AbQLXVVR>; Sun, 24 Dec 2000 16:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130255AbQLXVVH>; Sun, 24 Dec 2000 16:21:07 -0500
Received: from monza.monza.org ([209.102.105.34]:49674 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131414AbQLXVU5>;
	Sun, 24 Dec 2000 16:20:57 -0500
Date: Sun, 24 Dec 2000 12:50:23 -0800
From: Tim Wright <timw@splhi.com>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
Message-ID: <20001224125023.A1900@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Kai Henningsen <kaih@khms.westfalen.de>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com> <7sSHLPCmw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7sSHLPCmw-B@khms.westfalen.de>; from kaih@khms.westfalen.de on Sun, Dec 24, 2000 at 11:36:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 11:36:00AM +0200, Kai Henningsen wrote:
> torvalds@transmeta.com (Linus Torvalds)  wrote on 23.12.00 in <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com>:
> 
> > On Thu, 23 Dec 1999, michael chen wrote:
> > >         I found that when I compiled the 2.4 kernel with the option
> > >     of Pentium III or Pentium 4 on a Celeron's PC, it could cause  the
> > >     system hang at very beginning boot stage, and I found the problem
> > >     is cause by the fact that Intel Celeron doesn't have a real memory
> > >     barrier,but when you choose the Pentium III option, the kernel
> > >     assume the processor has a real memory barrier.
> > >     Here is a patch to fix it:
> >
> > No.
> >
> > The fix is to not lie to the configurator.
> >
> > A Celeron isn't a PIII, and you shouldn't tell the configure that it is.
> >
> > The whole point of being able to choose the CPU to optimize for is that we
> > can optimize things at compile-time.
> 
> Which is all fine, but maybe the kernel really ought to detect that  
> problem and complain at boot time?
> 
> Or does that happen already?
> 

There was a similar thread to this recently. The issue is that if you
choose the wrong processor type, you may not even be able to complain.
This is a user issue. All the distributions of which I am aware boot happily
on any x86 machine, because they build the kernel for the lowest common
denominator. Some detect the CPU type and install an appropriate kernel
subsequently. So... the only way you can get into this mess is if you build
a kernel yourself and choose the wrong options. There are many ways of
producing a non-bootable kernel. The expectation is that if you want to go
off and build your own kernel, you need to know what you're doing :-)

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
