Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131884AbRALUZR>; Fri, 12 Jan 2001 15:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRALUZB>; Fri, 12 Jan 2001 15:25:01 -0500
Received: from styx.suse.cz ([195.70.145.226]:22003 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131884AbRALUYb>;
	Fri, 12 Jan 2001 15:24:31 -0500
Date: Fri, 12 Jan 2001 21:24:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010112212427.A2829@suse.cz>
In-Reply-To: <20010112204626.A2740@suse.cz> <Pine.LNX.4.10.10101121151560.3010-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101121151560.3010-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 11:57:37AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 11:57:37AM -0800, Linus Torvalds wrote:

> > I've got a vt82c586 here (bought it just for testing of this problem),
> > and I wasn't able to create any corruption using that board and the 2.4
> > drivers.
> 
> The fact that it works on one board doesn't mean that it works on _every_
> board.

Of course. That's why I'm calling for bug reports.

> This is, in fact, why I will _NOT_ accept anything but a simple auto-dma
> disable for this problem for early 2.4.x. I hope that people will continue
> to work on and debug this problem, but it's just been around for too long,
> and it's obvious enough that it doesn't happen with all hardware that I
> doubt there is any other reasonable solution that doesn't require some
> _very_ extensive testing to verify.
> 
> I'd love to see people who see these problems and are willing to test out
> patches to fix it. But in parallel with that, I definitely want the 2.2.x
> "disable auto-DMA" thing for the big public. We can enable it later if
> some patch does seem to fix it for good.

Sure.

However - Alan's IDE patch for 2.2 kills autodma on ALL VIA chipsets.
That's because all VIA chipsets starting from vt82c586 to vt82c686b
(UDMA100), share the same PCI ID.

Would you prefer to filter just vt82c586 and vt82c586a as the comment in
Alan's code says or simply unconditionally kill autodma on all of VIA
chipsets, as Alan's code does?

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
