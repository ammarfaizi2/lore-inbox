Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129992AbRALS4M>; Fri, 12 Jan 2001 13:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbRALSzs>; Fri, 12 Jan 2001 13:55:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51474 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129967AbRALSzk>; Fri, 12 Jan 2001 13:55:40 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: ide.2.4.1-p3.01112001.patch
Date: 12 Jan 2001 10:55:22 -0800
Organization: Transmeta Corporation
Message-ID: <93njuq$21n$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10101120949040.1858-100000@penguin.transmeta.com> <Pine.LNX.4.10.10101121009230.1147-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10101121009230.1147-100000@master.linux-ide.org>,
Andre Hedrick  <andre@linux-ide.org> wrote:
>
>Well that "experimental patch" is designed to get out of the dreaded
>"DMA Timeout Hang" or deadlock that is most noted by the PIIX4 on the
>Intel 440*X Chipset groups.  Since it appears that their bug was copied
>but other chipset makers......you see the picture clearly, right?

No.

That experimental patch is _experimental_, and has not been reported by
anybody to fix anything at all.  Also, the DMA timeout on PIIX4 seems to
have nothing at all to do with the very silent corruption on VIA. At
least nobody has reported any error messages being produced on the VIA
corruption cases.

In short, let's leave it out of a stable kernel for now, and add
blacklisting of auto-DMA. Alan has a list. We can play around with
trying to _fix_ DMA on the VIA chipsets in 2.5.x (and possibly backport
the thing once it has been sufficiently battletested that people believe
it truly will work).

			Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
