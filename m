Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129149AbRBFSxC>; Tue, 6 Feb 2001 13:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbRBFSww>; Tue, 6 Feb 2001 13:52:52 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29191 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129304AbRBFSwn>;
	Tue, 6 Feb 2001 13:52:43 -0500
Message-ID: <3A8047F4.327CE6B2@mandrakesoft.com>
Date: Tue, 06 Feb 2001 13:52:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre1
In-Reply-To: <Pine.LNX.4.10.10102032021380.1010-100000@penguin.transmeta.com> <20010206113615.G8469@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> Er, what exactly is the CONFIG_PREP stuff in this driver supposed to be
> for?  "CONFIG_PREP" doesn't exist anymore to start with, and secondly I'm
> not sure if any PReP boxes ever shipped with a riva card to start with.  The
> only real way to handle this in 2.4 is something like:
> #ifdef CONFIG_ALL_PPC /* CHRP/PMAC/PREP */
> #include <asm/processor.h>
> #define isPReP (_machine == _MACH_prep)
> #else
> #define isPReP 0
> #endif
> 
> That is, if there's really any need to test explicitly for a PReP box.
> I asked Ani Joshi about this a while ago, and he wasn't quite sure why they
> were in there either..

It looks like it might have come from drivers/video/clgenfb.c, perhaps
for use with big endian framebuffers?

If the driver works on PPC without CONFIG_PREP code, let's get rid of
it.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
