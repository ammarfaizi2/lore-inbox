Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbRAMHMt>; Sat, 13 Jan 2001 02:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130663AbRAMHMk>; Sat, 13 Jan 2001 02:12:40 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:12811
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129957AbRAMHM1>; Sat, 13 Jan 2001 02:12:27 -0500
Date: Fri, 12 Jan 2001 23:12:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <93njuq$21n$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101122303260.3291-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jan 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.10.10101121009230.1147-100000@master.linux-ide.org>,
> Andre Hedrick  <andre@linux-ide.org> wrote:
> >
> >Well that "experimental patch" is designed to get out of the dreaded
> >"DMA Timeout Hang" or deadlock that is most noted by the PIIX4 on the
> >Intel 440*X Chipset groups.  Since it appears that their bug was copied
> >but other chipset makers......you see the picture clearly, right?
> 
> No.

Oh, then I need to explain....but later.

> That experimental patch is _experimental_, and has not been reported by
> anybody to fix anything at all.  Also, the DMA timeout on PIIX4 seems to
> have nothing at all to do with the very silent corruption on VIA. At
> least nobody has reported any error messages being produced on the VIA
> corruption cases.

Yes corruption verses deadlock that can wack superblock....hummm
Two evils, mame or kill one or leave both active...

> In short, let's leave it out of a stable kernel for now, and add
> blacklisting of auto-DMA. Alan has a list. We can play around with
> trying to _fix_ DMA on the VIA chipsets in 2.5.x (and possibly backport
> the thing once it has been sufficiently battletested that people believe
> it truly will work).

Linus we are talking about blacklisting every PIIX4 that is 440BX/GX/LX/NX 
in this case and that is a major list.  VIA has its own problems and that
need special cases attention by one person work on always, thus the
poor^H^H^H^H bold sucker^H^H^H^H^H^H guy known as Vojtech Pavlik from SuSE
is having to much fun....

Cheers,

Andre Hedrick
Linux ATA Development


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
