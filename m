Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129967AbQLKOsQ>; Mon, 11 Dec 2000 09:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130330AbQLKOsG>; Mon, 11 Dec 2000 09:48:06 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:32471 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S130321AbQLKOrt>; Mon, 11 Dec 2000 09:47:49 -0500
Date: Mon, 11 Dec 2000 14:14:01 +0000 (GMT)
From: davej@suse.de
To: Rainer Mager <rmager@vgkk.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: RE: Signal 11
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGAEMHCIAA.rmager@vgkk.com>
Message-ID: <Pine.LNX.4.21.0012111404380.6601-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Rainer Mager wrote:

> Well, I just had a Signal 11 even with the patch. What can I do to help
> figure this out?

My troublesome box finally seems to be stable. It's been up for the
last two days whilst under quite heavy loads without problems.
Previously, it would be lucky to last an hour.
The change? I disabled DRM & AGPGart.
With them both disabled, I get no problems at all. No Sig11's,
No Sig4's, No lockups.

This box has a Voodoo3 3000 AGP..

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)

And is running on an MVP3 chipset....

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]

This box does display the same problem with IRQ routing that I've
got on my Athlon box...

PCI: Using IRQ router VIA [1106/0586] at 00:07.0
PCI: Assigned IRQ 11 for device 00:08.0
PCI: The same IRQ used for device 01:00.0
IRQ routing conflict in pirq table! Try 'pci=autoirq'

(00:08:0 is an SBLive)

A related problem ?
As I mentioned in an earlier mail `autoirq' is an unknown option.

The Athlon box has similar messages, but it happens with even
more devices..

They both do the same with the various PCI options 'nobios' etc,
and changing PnP OS in the BIOS makes no difference either.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
