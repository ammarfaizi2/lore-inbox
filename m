Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264330AbRFNA5T>; Wed, 13 Jun 2001 20:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264327AbRFNA5I>; Wed, 13 Jun 2001 20:57:08 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:26186 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S264330AbRFNA44>; Wed, 13 Jun 2001 20:56:56 -0400
Message-ID: <008f01c0f46c$df37df40$4fa6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Daniel" <ddickman@nyc.rr.com>,
        "Linux kernel" <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Subject: Re: obsolete code must die
Date: Wed, 13 Jun 2001 17:56:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup is a nice idea , but Linux should support old hardware and should
not affect them in any way.

Jaswinder.

----- Original Message -----
From: "Daniel" <ddickman@nyc.rr.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Sent: Wednesday, June 13, 2001 5:44 PM
Subject: obsolete code must die


> Anyone concerned about the current size of the kernel source code? I am,
and
> I propose to start cleaning house on the x86 platform. I mean it's all
very
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
> -- If someone really needs support for this junk, they will always have
the
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
> If support for the buses is gone, there's no point in supporting devices
for
> these buses.
>
> all code marked as CONFIG_OBSOLETE
> Since we're cleaning house we may as well get rid of this stuff.
>
> MFM/RLL/XT/ESDI hard drive support
> Does anyone still *have* an RLL drive that works? At the very least get
rid
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
> I really think doing a clean up is worthwhile. Maybe while looking for
stuff
> to clean up we'll even be able to better comment the existing code. Any
> other features people would like to get rid of? Any comments or
suggestions?
> I'd love to start a good discussion about this going so please send me
your
> 2 cents.
>
> Daniel
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

