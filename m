Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131418AbRALTqm>; Fri, 12 Jan 2001 14:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131645AbRALTqc>; Fri, 12 Jan 2001 14:46:32 -0500
Received: from styx.suse.cz ([195.70.145.226]:23538 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131418AbRALTq2>;
	Fri, 12 Jan 2001 14:46:28 -0500
Date: Fri, 12 Jan 2001 20:46:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010112204626.A2740@suse.cz>
In-Reply-To: <Pine.LNX.4.10.10101120949040.1858-100000@penguin.transmeta.com> <Pine.LNX.4.10.10101121009230.1147-100000@master.linux-ide.org> <93njuq$21n$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <93njuq$21n$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 10:55:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 10:55:22AM -0800, Linus Torvalds wrote:
> In article <Pine.LNX.4.10.10101121009230.1147-100000@master.linux-ide.org>,
> Andre Hedrick  <andre@linux-ide.org> wrote:
> >
> >Well that "experimental patch" is designed to get out of the dreaded
> >"DMA Timeout Hang" or deadlock that is most noted by the PIIX4 on the
> >Intel 440*X Chipset groups.  Since it appears that their bug was copied
> >but other chipset makers......you see the picture clearly, right?
> 
> No.
> 
> That experimental patch is _experimental_, and has not been reported by
> anybody to fix anything at all.  Also, the DMA timeout on PIIX4 seems to
> have nothing at all to do with the very silent corruption on VIA. At
> least nobody has reported any error messages being produced on the VIA
> corruption cases.
> 
> In short, let's leave it out of a stable kernel for now, and add
> blacklisting of auto-DMA. Alan has a list. We can play around with
> trying to _fix_ DMA on the VIA chipsets in 2.5.x (and possibly backport
> the thing once it has been sufficiently battletested that people believe
> it truly will work).

I've got a vt82c586 here (bought it just for testing of this problem),
and I wasn't able to create any corruption using that board and the 2.4
drivers.

Does anyone still have any vt82c586 or vt82c586a the 2.4 VIA driver is
corrupting data on?

I'd like to hear about such reports so that I can start debugging (and
perhaps get me one of those failing boards, they must be quite cheap
these days).

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
