Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbTIOWpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTIOWpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:45:06 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:3205 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261679AbTIOWpA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:45:00 -0400
Date: Tue, 16 Sep 2003 00:44:54 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>, <geert@linux-m68k.org>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <1063663632.585.61.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309160011540.24675-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Benjamin Herrenschmidt wrote:

> I reported that I got user reports of breakage... so far, I don't know
> more as I only have one mach64 machine that I couldn't test on yet.

Can you ask them to contact me?

> At least, iBook1 is broken (M1 chipset) from what Olaf says (in CC
> list).

Indeed... It's a catch-22. The current driver is correct; default clock
rate is 125 MHz. Luckily, for the case that specific implementations
use different rates I did build in the default_xclk=-1 and default_mclk=-1
options, which make the driver not to touch the clocks.

But that still breaks the default. Do you know someone elso who has an
ibook, or any other PowerPC M1? If the 50 MHz is consequent on all PowerPC
implementations, we could perhaps make it 50MHz on PowerPC only as
emergency fix.

> There are a few PPC machines for which atyfb is "critical":
>
>  - PowerBook Wallstreet I (Rage LT-G, that one I can test)
>  - PowerBook Wallstreet II (Rage LT-Pro I think)
>  - PowerBook 101 (aka Lombard) (Rage LT-Pro)
>  - iBook1 (Rage M1)
>  - iMac rev A,B and C (not sure which chip, LT-Pro or just 3D Pro)
>  - Beige G3 (older XL iirc)

> Along with some older "performa" I forgot about (5400 I think).
>
> The current driver works at least well enough to get a console on all
> of these. I'm not sure a stable serie should get a new driver if it
> has not been properly validated on these.

> Unfortunately, I don't have access to all of this HW to test with, so...

Same problem for me :)

I did post the driver on the Linux-fbdev and LinuxPPC mailinglists.
Replies: 0. I also asked you, you didn't have time, no problem, but again
no test. It gets merged, people start testing...

I agree the stable series should have a stable driver, I proposed that
Marcelo would merge the driver, I would aggressively investigate problems,
and in case of serious trouble a revert.

> Why don't you push it to 2.6 first then backport to 2.4 ? That would
> be better imho...

It's a possibility, Alexander Kern is porting the code to 2.6. But
please wait a few days, it's quite likely things will be fixed and stable then.

Daniël

