Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135791AbRAMAKH>; Fri, 12 Jan 2001 19:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135816AbRAMAJ5>; Fri, 12 Jan 2001 19:09:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13071 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135791AbRAMAJj>; Fri, 12 Jan 2001 19:09:39 -0500
Date: Fri, 12 Jan 2001 16:09:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <20010112212427.A2829@suse.cz>
Message-ID: <Pine.LNX.4.10.10101121604080.8097-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Vojtech Pavlik wrote:
> 
> However - Alan's IDE patch for 2.2 kills autodma on ALL VIA chipsets.
> That's because all VIA chipsets starting from vt82c586 to vt82c686b
> (UDMA100), share the same PCI ID.
> 
> Would you prefer to filter just vt82c586 and vt82c586a as the comment in
> Alan's code says or simply unconditionally kill autodma on all of VIA
> chipsets, as Alan's code does?

Right now, for 2.4.1, I'd rather have the patch to just do the same as
2.2.x. We can figure it out better when we get a better idea of exactly
what the bug is, and whether there is some other work-around, and whether
it is 100% certain that it is just those two controllers (maybe the other
ones are buggy too, but the 2.2.x tests basically cured their symptoms too
and peopl ehaven't reported them because they are "fixed").

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
