Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264254AbTCXQEr>; Mon, 24 Mar 2003 11:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264256AbTCXQEr>; Mon, 24 Mar 2003 11:04:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49926 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264254AbTCXQEq>; Mon, 24 Mar 2003 11:04:46 -0500
Date: Mon, 24 Mar 2003 16:15:51 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org, Spang Oliver <oliver.spang@siemens.com>
Subject: Re: drivers/serial/Makefile
Message-ID: <20030324161551.B10370@flint.arm.linux.org.uk>
Mail-Followup-To: Duncan Sands <duncan.sands@math.u-psud.fr>,
	linux-kernel@vger.kernel.org,
	Spang Oliver <oliver.spang@siemens.com>
References: <200303241652.50213.duncan.sands@math.u-psud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303241652.50213.duncan.sands@math.u-psud.fr>; from duncan.sands@math.u-psud.fr on Mon, Mar 24, 2003 at 04:52:50PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 04:52:50PM +0100, Duncan Sands wrote:
> The serial driver is now compiled as "8250", rather than
> the traditional "serial" (Kconfig says "serial" as well).
> Assuming this was a mistake in the Makefile, I went and
> had a look, but my brain exploded.

It isn't a mistake.  "serial" is meaningless with you've got multiple
serial ports of different types.  It's a general name of a class of
devices, not a specific device.

> What exactly is this intended to do?

Well, core.c is the core driver which knows how to talk to user space,
and on to that bolts the hardware specific bits, 8250.c, sa1100.c,
suncore.c etc.

> PS: 8250_gsc, 8250_pci can be compiled as modules in their
> own right.

In theory they can, and maybe one day we'll teach the Kconfig system
to allow it.  Feel free to send a patch for this. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

