Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264394AbRFNB56>; Wed, 13 Jun 2001 21:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264398AbRFNB5s>; Wed, 13 Jun 2001 21:57:48 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:37031 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S264394AbRFNB5l>; Wed, 13 Jun 2001 21:57:41 -0400
Message-ID: <3B281A50.9B3EAA68@idcomm.com>
Date: Wed, 13 Jun 2001 19:58:40 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel <ddickman@nyc.rr.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
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
> 
> MFM/RLL/XT/ESDI hard drive support
> Does anyone still *have* an RLL drive that works? At the very least get rid
> of the old driver (eg CONFIG_BLK_DEV_HD_ONLY, CONFIG_BLK_DEV_HD_IDE,
> CONFIG_BLK_DEV_XD, CONFIG_BLK_DEV_PS2)
> 
> parallel/serial/game ports
> More controversial to remove this, since they are *still* in pretty wide
> use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.

This is completely wrong. USB is a hog, IEEE 1394 joysticks? Almost
every sound card out there...modern...have game ports that are useful
now. USB is an evolving and often broken standard. Your idea of obsolete
is not completely wrong, but it is far too wrong to go about it this
way. And printers or serial mice?

D. Stimits, stimits@idcomm.com

> 
> a.out
> Who needs it anymore. I love ELF.
> 
> I really think doing a clean up is worthwhile. Maybe while looking for stuff
> to clean up we'll even be able to better comment the existing code. Any
> other features people would like to get rid of? Any comments or suggestions?
> I'd love to start a good discussion about this going so please send me your
> 2 cents.
> 
> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
