Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319126AbSIJOAS>; Tue, 10 Sep 2002 10:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319124AbSIJOAS>; Tue, 10 Sep 2002 10:00:18 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:15810 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S319123AbSIJOAR>; Tue, 10 Sep 2002 10:00:17 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 10 Sep 2002 15:47:08 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: ignore pci devices?
Message-ID: <20020910134708.GA7836@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

I have a small problem:  Some vendor has built a PCI board which
(ab-)uses the bt848/878 chip in creative ways to do some DMA.  It is
*not* a video card, thus letting the bttv driver control the card isn't
very useful and causes trouble.  The card has no PCI Subsystem ID, so I
can't identify and blacklist it easily.  Thus I need some way to allow
the users to tell bttv (or the kernel) to ignore that particular PCI
card.

Is there already something generic for this?  Some kernel parameter
which makes pci_module_init() skip a given PCI device for example?

Another way to fix this I'm thinking about is to add a insmod option
along the lines "ignore=<bus>,<slot>" to bttv.  Comments?  Better idea?

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
