Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132261AbQLVVDC>; Fri, 22 Dec 2000 16:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132251AbQLVVCx>; Fri, 22 Dec 2000 16:02:53 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:22510 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130458AbQLVVCl>; Fri, 22 Dec 2000 16:02:41 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012222032.eBMKW0U13909@webber.adilger.net>
Subject: Re: Fw: max number of ide controllers?
In-Reply-To: <007c01c06c4d$aef446e0$2b6e60cf@pcscs.com> "from Charles Wilkins
 at Dec 22, 2000 02:30:46 pm"
To: Charles Wilkins <chas@pcscs.com>
Date: Fri, 22 Dec 2000 13:32:00 -0700 (MST)
CC: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Wilkins writes:
> Andrzej M. Krzysztofowicz says,
> 
> >"Linux supports up to 10 IDE channels, however channel numbers of PCI
> controllers seem to be assigned first."
> 
> Warren Young says,
> >"Kernel 2.2 is limited to 4 IDE controllers."
> 
> ok, so which is it kernel guys, 4 or 10 IDE controllers for the 2.2.x
> kernel?

It depends if you have Andre's IDE patches applied to your kernel sources
or not.

> well, i know this SB32 card can operating on at least 3 different io ports .
> . .

It may be that there is some difficulty in the order the IDE cards are
initialized.  From your previous dmesg output, it appears that ide3 and ide4
(PCI cards) are initialized before ide2 (ISA card), so they may be stealing
an ioport that the ISA card needs.  Try booting with just the SB32 card
and checking /proc/ioports, and then with only the other card, and see
if anything in /proc/ioports (or /proc/interrupts) is conflicting.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
