Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFTeF>; Wed, 6 Dec 2000 14:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbQLFTdp>; Wed, 6 Dec 2000 14:33:45 -0500
Received: from ns1.metabyte.com ([216.218.208.34]:23298 "EHLO ns1.metabyte.com")
	by vger.kernel.org with ESMTP id <S129231AbQLFTdi>;
	Wed, 6 Dec 2000 14:33:38 -0500
From: Pete Zaitcev <zaitcev@metabyte.com>
Message-Id: <200012061902.LAA21377@ns1.metabyte.com>
Subject: Re: YMF PCI - thanks, glitches, patches (fwd)
To: proski@gnu.org (Pavel Roskin)
Date: Wed, 6 Dec 2000 11:02:52 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, perex@suse.cz (Jaroslav Kysela),
        zaitcev@metabyte.com (Pete Zaitcev), peter@cadcamlab.org,
        kai@thphy.uni-duesseldorf.de
In-Reply-To: <Pine.LNX.4.30.0012061254420.1411-100010@fonzie.nine.com> from "Pavel Roskin" at Dec 06, 2000 01:12:13 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 6 Dec 2000 13:12:13 -0500 (EST)
> From: Pavel Roskin <proski@gnu.org>
> cc: Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@metabyte.com>,
>         <peter@cadcamlab.org>, <kai@thphy.uni-duesseldorf.de>

> The native YMF PCI driver from Linux-2.4.0-test12-pre5 works on my card:

I did not have a chance to look at whatever is in 2.4, but from
reading Linus's e-mails I understand that Jaroslav made a new
port, which is probably unrelated to the stuff that I hastily
cooked up for 2.2 (I really wanted to play Doom on my new Sony).
I am sorry for the lack of communication.

I'll see what 2.2 does about 1) playing at 5512 Hz, 2) compiling
as modules together (non-modules are made to be exclusive),
3) compiling if CONFIG_PCI is not enabled, 4) has Configure.help
update.

I am not sure what to do about CONFIG_EXPERIMENTAL.
My current plan is to discard "(EXPERIMENTAL)" and forget
about it until the next case.

Ioctl 0x5401 is a mystery. I do not know what it is
(looks like SNDCTL_TMR_TIMEBASE without uppper bits).

Please send fewer attachements to the lists. Your sound fragment
is very useful, but I'd prefer to have it sent separately to me
upon a request (in uuencode :).

BTW, Legacy driver (ymf_sb) uses PC/DMA or whatever the name is,
which requires the north bridge support and, sometimes, additional
connections on the motherboard. This is not reflected in _any_
kernel documentation. I have spent numerous hours trying to make
it work on my laptop until I understood that even though my
chipset supports PC/DMA, necessary connections are missing.
At first glance, it looked as if IRQ does not come.

-- Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
