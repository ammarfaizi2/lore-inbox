Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286374AbRLTVIZ>; Thu, 20 Dec 2001 16:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286375AbRLTVIP>; Thu, 20 Dec 2001 16:08:15 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:60169 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S286374AbRLTVH6>; Thu, 20 Dec 2001 16:07:58 -0500
Date: Thu, 20 Dec 2001 16:07:53 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Making TI bridges work with kernel PCMCIA
In-Reply-To: <20011220204911.25097@smtp.noos.fr>
Message-ID: <Pine.LNX.4.43.0112201557090.17379-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Benjamin!

> I have to use a similar workaround on pmac laptops. However, I do that
> in the platform specific quirks.

Yes, I found it in arch/ppc/kernel/pci.c, function pcibios_fixup_cardbus.

I believe it should be safe to remove that "fixup" once my patch is
applied.  There is no reason to believe that BIOS or OpenFirmware know
better than the Linux kernel how to route interrupts on PCMCIA bridges.

I believe that relying on proprietary firmware (i.e BIOS) or on power-on
defaults is only justified when we have insufficient information how to
initialize the chip.  That's not the case for TI bridges.

By the way, I'll appreciate if somebody applies my patch, removes the PPC
fixup and tests it on PPC.  I'm 99% sure that it will work, but still it
will be good to know for sure.

-- 
Regards,
Pavel Roskin

