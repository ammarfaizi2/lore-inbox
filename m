Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316970AbSFKJY6>; Tue, 11 Jun 2002 05:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSFKJY4>; Tue, 11 Jun 2002 05:24:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10255 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316970AbSFKJY0>; Tue, 11 Jun 2002 05:24:26 -0400
Date: Tue, 11 Jun 2002 10:24:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 no source for several objects
Message-ID: <20020611102421.E1346@flint.arm.linux.org.uk>
In-Reply-To: <8028.1023759039@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 11:30:39AM +1000, Keith Owens wrote:
> drivers/acorn/char/Makefile
> obj-$(CONFIG_L7200_KEYB)        += defkeymap-l7200.o keyb_l7200.o - no source for keyb_l7200.o
> drivers/char/Makefile
> obj-$(CONFIG_SERIAL_SA1100) += serial_sa1100.o
>
> None of these were picked up by the existing build system, they were
> all detected by kbuild 2.5.  This is one of the advantages of having a
> build system that knows about everything.

Sounds like kbuild 2.5 is more a feature bloated Big Brother Build System.

The serial stuff has moved in the -rmk tree, and the above drivers/char
is no longer relevant.  Removing it and the other ARM serial drivers
in drivers/char would make the -rmk patches smaller. 8)

The keyboard driver for the Linkup Systems L7200 stuff was never merged.
People keep talking about fixing that, but seems that no one has the
information to write such a thing, and Steven Hill (iirc) has since
moved onto greater things.  I believe people do use Linux on L720x
without the keyboard driver though!

However, since the ARM community is mostly centred around embedded stuff,
it is impossible to judge the size or use of any part of the ARM Linux
kernel.  It's also gradually sliding towards a completely closed, non-
sharing development community.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

