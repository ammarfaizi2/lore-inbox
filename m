Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316863AbSFKJGn>; Tue, 11 Jun 2002 05:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316958AbSFKJGm>; Tue, 11 Jun 2002 05:06:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1295 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316863AbSFKJGl>; Tue, 11 Jun 2002 05:06:41 -0400
Date: Tue, 11 Jun 2002 10:06:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020611100634.D1346@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com> <20020611004000.GH5202@kroah.com> <3D0599AE.7080809@evision-ventures.com> <20020611092637.C1346@flint.arm.linux.org.uk> <3D05B61F.4010609@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 10:34:39AM +0200, Martin Dalecki wrote:
> U¿ytkownik Russell King napisa³:
> > On Tue, Jun 11, 2002 at 08:33:18AM +0200, Martin Dalecki wrote:
> > 
> >>6. In esp. ARM seems to be much better off with GCC 3.1 then anything else.
> > 
> > 
> > Not yet proven.  Only a minority of people are using gcc 3.1 compared
> 
> Few +1. However this was the first "official" release which
> was "working out of the box". Well at least for me.

GCC 2.95.3, +4 both work with a patch from Phil Blundell, as detailed
in the build instructions for these versions.

GCC 3.x introduces the dodgy practice of removing the frame pointer
from every function despite telling the compiler not to with
-fno-omit-frame-pointer.  It's also contary to the GCC documentation
when it interferes with debugging.

Overall, using gcc 3.1 causes the following problems in _any_ kernel:

1. crashes when things like knfsd and other kernel daemons exit.
2. you can't get a call trace from the kernel.

For anyone, I'd recommend using gcc 2.95.[34] for building a kernel that
should be stable and can be trusted.  gcc 3.x is still very experimental
afaiac.  We're still finding its quirks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

