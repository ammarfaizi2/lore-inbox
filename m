Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264327AbRFNBA6>; Wed, 13 Jun 2001 21:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRFNBAt>; Wed, 13 Jun 2001 21:00:49 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47499 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264342AbRFNBAh>;
	Wed, 13 Jun 2001 21:00:37 -0400
Message-ID: <3B280CB2.EDAD8A55@mandrakesoft.com>
Date: Wed, 13 Jun 2001 21:00:34 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel <ddickman@nyc.rr.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel wrote:
> 
> Anyone concerned about the current size of the kernel source code? I am, and
> I propose to start cleaning house on the x86 platform. I mean it's all very
> well and good to keep adding features, but stuff needs to go if kernel
> development is to move forward. Before listing the gunk I want to get rid
> of, here's my justification for doing so:
> -- Getting rid of old code can help simplify the kernel. This means less
> chance of bugs.
> -- Simplifying the kernel means that it will be easier for newbies to
> understand and perhaps contribute.
> -- a simpler, cleaner kernel will also be of more use in an academic
> environment.
> -- a smaller kernel is easier to maintain and is easier to re-architect
> should the need arise.
> -- If someone really needs support for this junk, they will always have the
> option of using the 2.0.x, 2.2.x or 2.4.x series.
> 
> So without further ado here're the features I want to get rid of:
> 
> i386, i486
> The Pentium processor has been around since 1995. Support for these older
> processors should go so we can focus on optimizations for the pentium and
> better processors.
> 
> math-emu
> If support for i386 and i486 is going away, then so should math emulation.
> Every intel processor since the 486DX has an FPU unit built in. In fact
> shouldn't FPU support be a userspace responsibility anyway?
> 
> ISA bus, MCA bus, EISA bus
> PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
> CONFIG_ISAPNP, etc
> 
> ISA, MCA, EISA device drivers
> If support for the buses is gone, there's no point in supporting devices for
> these buses.
> 
> all code marked as CONFIG_OBSOLETE
> Since we're cleaning house we may as well get rid of this stuff.

If you don't want it, don't build it into your kernel.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
