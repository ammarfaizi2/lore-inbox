Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129475AbRBFSiR>; Tue, 6 Feb 2001 13:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129488AbRBFSiH>; Tue, 6 Feb 2001 13:38:07 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58863
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129475AbRBFSh6>; Tue, 6 Feb 2001 13:37:58 -0500
Date: Tue, 6 Feb 2001 11:36:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre1
Message-ID: <20010206113615.G8469@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.10.10102032021380.1010-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10102032021380.1010-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Feb 03, 2001 at 08:24:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 08:24:27PM -0800, Linus Torvalds wrote:

...
> -pre1:
...
>  - riva FB driver update

Er, what exactly is the CONFIG_PREP stuff in this driver supposed to be
for?  "CONFIG_PREP" doesn't exist anymore to start with, and secondly I'm
not sure if any PReP boxes ever shipped with a riva card to start with.  The
only real way to handle this in 2.4 is something like:
#ifdef CONFIG_ALL_PPC /* CHRP/PMAC/PREP */
#include <asm/processor.h>
#define isPReP (_machine == _MACH_prep)
#else
#define isPReP 0
#endif

That is, if there's really any need to test explicitly for a PReP box.
I asked Ani Joshi about this a while ago, and he wasn't quite sure why they
were in there either..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
