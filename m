Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264405AbRFNGcm>; Thu, 14 Jun 2001 02:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264407AbRFNGcc>; Thu, 14 Jun 2001 02:32:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56080 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264405AbRFNGcS>;
	Thu, 14 Jun 2001 02:32:18 -0400
Date: Thu, 14 Jun 2001 07:31:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel <ddickman@nyc.rr.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
Message-ID: <20010614073144.A28504@flint.arm.linux.org.uk>
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>; from ddickman@nyc.rr.com on Wed, Jun 13, 2001 at 08:44:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2001 at 08:44:11PM -0400, Daniel wrote:
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
> 
> MFM/RLL/XT/ESDI hard drive support
> Does anyone still *have* an RLL drive that works? At the very least get rid
> of the old driver (eg CONFIG_BLK_DEV_HD_ONLY, CONFIG_BLK_DEV_HD_IDE,
> CONFIG_BLK_DEV_XD, CONFIG_BLK_DEV_PS2)
> 
> parallel/serial/game ports
> More controversial to remove this, since they are *still* in pretty wide
> use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.
> 
> a.out
> Who needs it anymore. I love ELF.

Is this one big joke?  It looks like it to me.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

