Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130747AbQLaUOr>; Sun, 31 Dec 2000 15:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130866AbQLaUOi>; Sun, 31 Dec 2000 15:14:38 -0500
Received: from waste.org ([209.173.204.2]:31764 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S130747AbQLaUO3>;
	Sun, 31 Dec 2000 15:14:29 -0500
Date: Sun, 31 Dec 2000 13:44:03 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Mobile PII vs PIII was Re: test13-pre[37] hangs my VAIO on boot
In-Reply-To: <Pine.LNX.4.30.0012311151210.20511-100000@waste.org>
Message-ID: <Pine.LNX.4.30.0012311314540.31886-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Oliver Xymoron wrote:

> My VAIO PCG-Z505SX locks up at "Uncompressing kernel", power cycling
> required to reboot. Unpatched test12 works fine with same config. System
> is debian-testing with gcc 2.95.2, kernel built with make-kpkg.

Ok, I lied. Looks like the working test12 I had was compiled differently.

> CONFIG_M686FXSR=y
...
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_FXSR=y
> CONFIG_X86_XMM=y

My VAIO has a Mobile Pentium II. Which means it is indeed a 686 with FXSR,
but no XMM. There are of course locking primitives that change with the
presence of CONFIG_X86_XMM.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
