Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264345AbRFNBLs>; Wed, 13 Jun 2001 21:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264359AbRFNBLi>; Wed, 13 Jun 2001 21:11:38 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:60412 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S264345AbRFNBLX>;
	Wed, 13 Jun 2001 21:11:23 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: "Daniel" <ddickman@nyc.rr.com>,
        "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: RE: obsolete code must die
Date: Wed, 13 Jun 2001 21:11:12 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGEEJHCJAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	As an end user who uses cheap laptops for firewalls, I'm pretty much
against this.  I've got 2.2.18, 2.4.4-ac8, and 2.4.4-ac12 installed as
firewall machines on 486 laptops.  Why should we (the collective Linux
world, not me personnally, since I'm not a kernel developer) limit the class
of machines people can run?

	In fact, this seems to be one of the appealing features of Linux, that it
runs on any x86 hardware class with a MMU.  It allows people to get involved
in Linux without making a committment to buying a new PC until they know
they like it, or buying a new HD to do a dual boot install to experiment.
Laptops are a particular issue here, because many of the laptops people can
obtain inexpensively ARE 386/486 class machines.

	I'm all for cleaning up the kernel code, but I think it would be better
served by documentation, not by limiting the hardware that can be run.

	I can't speak authoritively on how much of the kernel code is processor
specific, since GCC takes care of most of that.  I do know there are
sections that are affected by the processor selection, but I can't believe
that it's a significantly large enough portion to justify ripping it out in
the name of cleaning it up.

	I do agree with deleting obsolete code, but not obsoleting hardware so we
CAN delete code.

	--John

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Daniel
> Sent: Wednesday, June 13, 2001 20:44 PM
> To: Linux kernel
> Subject: obsolete code must die
>
>
> Anyone concerned about the current size of the kernel source
> code? I am, and
> I propose to start cleaning house on the x86 platform. I mean
> it's all very
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
> -- If someone really needs support for this junk, they will
> always have the
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
> If support for the buses is gone, there's no point in supporting
> devices for
> these buses.
>
> all code marked as CONFIG_OBSOLETE
> Since we're cleaning house we may as well get rid of this stuff.
>
> MFM/RLL/XT/ESDI hard drive support
> Does anyone still *have* an RLL drive that works? At the very
> least get rid
> of the old driver (eg CONFIG_BLK_DEV_HD_ONLY, CONFIG_BLK_DEV_HD_IDE,
> CONFIG_BLK_DEV_XD, CONFIG_BLK_DEV_PS2)
>
> parallel/serial/game ports
> More controversial to remove this, since they are *still* in pretty wide
> use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.
>
> a.out
> Who needs it anymore. I love ELF.
>
> I really think doing a clean up is worthwhile. Maybe while
> looking for stuff
> to clean up we'll even be able to better comment the existing code. Any
> other features people would like to get rid of? Any comments or
> suggestions?
> I'd love to start a good discussion about this going so please
> send me your
> 2 cents.
>
> Daniel
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

