Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292005AbSB0IFf>; Wed, 27 Feb 2002 03:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292234AbSB0IFY>; Wed, 27 Feb 2002 03:05:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2433 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291531AbSB0IFT>;
	Wed, 27 Feb 2002 03:05:19 -0500
Date: Wed, 27 Feb 2002 00:03:18 -0800 (PST)
Message-Id: <20020227.000318.02301574.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: [BETA-0.91] New test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks to everyone who has tested and gotten back to us so
far.  A new release is up at:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3-0.91.patch.gz

Older releases will be stored in the "old/" subdirectory.
As before, this is against 2.4.18 but it should be easy to add
this to any other tree.

Brief changelog against 0.91:

[BUG FIX} 5701 and later chips not configured properly for
          interrupt handling (me)
[BUG FIX] Try to rectify vital product data read failures
          on Dell Vipor boards (me)
[FEATURE] Finish initial implementation of the rest of the ethtool
	  support.  Largely untested. (me+jeff)
[FIX]	  Add missing PCI/subsystem IDs (jeff)
[FIX]	  Add missing defines for registers we do not make use
	  of yet on the card. (me)
[FIX]	  Add missing IDs and recognition of 5703 boards and PHYs.
[FIX]	  PCI-X bus speeds not reported properly.

Success/failure reports are appreciated.  I would like to note
that the most important thing to tell us is the one line ident
the kernel log gets for each board it probes.  Like so:

eth1: Tigon3 [partno(BCM95700A6) rev 7102 PHY(5401)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:04:76:2f:e2:d0

That has all the details we need to see in order to know exactly
what kind of card you have.  The lspci dumps are nice, but basically
superfluous :-)  Telling us what platform (x86, ppc, alpha, ia64,
etc.) you are on would be appreciated as well.

Thanks again.
