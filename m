Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130867AbQKTNHs>; Mon, 20 Nov 2000 08:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130472AbQKTNHj>; Mon, 20 Nov 2000 08:07:39 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:23656 "EHLO ife.ee.ethz.ch")
	by vger.kernel.org with ESMTP id <S129835AbQKTNH1>;
	Mon, 20 Nov 2000 08:07:27 -0500
Message-ID: <3A191B03.6DE258C8@ife.ee.ethz.ch>
Date: Mon, 20 Nov 2000 13:37:23 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Organization: IfE
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: de,fr,ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: test11-pre6 still very broken
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <20001117223137.A26341@wirex.com> <3A162EFE.A980A941@talontech.com> <20001117235624.B26341@wirex.com> <8v6h3d$rp$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> I'd disagree.  UHCI has tons of advantages, not the least of which is
> [Cthat it was there first and is widely available.  If OHCI hadn't been
> done we'd have _one_ nice good USB controller implementation instead of

UHCI has a couple of disadvantages, though (and some of them could have
been fixed with only very little added gates).

For example:

- one cannot reliably unlink transfer buffers from the queues without
  waiting 1ms
- bandwidth reclamation can be a real PCI hog

> I hope EHCI makes it all moot. Some way or another.

Only for USB2 devices. EHCI is supposed to be paired with an existing
UHCI or OHCI controller core that is supposed to take over the USB connector
if an USB 1.x hub or device is plugged in. So we end up needing to support
UHCI and OHCI for a very long time, I don't see mice and keyboards going
USB2 anytime soon 8-)

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
