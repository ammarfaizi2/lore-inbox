Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRAAUYS>; Mon, 1 Jan 2001 15:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRAAUYI>; Mon, 1 Jan 2001 15:24:08 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:15625
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129752AbRAAUX5>; Mon, 1 Jan 2001 15:23:57 -0500
Date: Mon, 1 Jan 2001 11:53:00 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
In-Reply-To: <E14DAOg-0001Ce-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101011124160.22396-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2001, Alan Cox wrote:

> > > as it apparently makes CONFIG_IDEDMA_IVB a complete no-op?
> > 
> > Exactly what it is designed to do, Ignore Validity Bits, because the whole
> > damn messedup the rules between ATA-4 and ATA-6
> 
> I think the question is more - so why not lose the ifdef
> -

Because there are the exceptions that get it correct based on the level of
ATA support reported in the IDENTIFY page.

When I state that it is all screwed up, I mean in a contigious nature of
the Standard.  The rules for ATA-4 with ATA-4 limited support is correct
as is ATA-5 with ATA-5, and ATA-6 with ATA-6, but ATA-4 rules do not mix
with ATA-5 nor ATA-6.  This is the mess in front of me to sort.

So we default a full test of both bits 13 and 14, but it you have a
hardware combination that fails the rules.

ATA-4 is HOST side and Device side based on Bit 13 only
ATA-5 is HOST side and Device side based on Bit 14 only
ATA-6 is HOST side and Device side based on Bit 14 and Bit 13

ATA-6 is the correct method...

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
