Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUHTK0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUHTK0q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUHTK0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:26:46 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:61056 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266004AbUHTK02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:26:28 -0400
Date: Fri, 20 Aug 2004 12:26:23 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040820102623.GG781@ucw.cz>
References: <20040819140152.GB12634@ucw.cz> <20040819231158.97039.qmail@web14926.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819231158.97039.qmail@web14926.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
 
> The shadowing logic is a must have for laptops. BenH and I discovered
> this the hard way. Some laptops take the system and video ROM images,
> combine them and then compress them into a ROM. At boot time these ROM
> images are decompressed into RAM at C0000 and F0000. For these system
> the only place to get the ROM data for things like video timings is
> from the shadow area. Putting the shadow logic into the shared ROM code
> lets up remove it from all of the video drivers. This lets us write
> video drivers that don't care if the card is primary or secondary.

I understand this and I didn't want to remove the shadow ROM logic,
just to separate it from the real PCI ROM space, the reasons being (1) clarity,
(2) it might be useful to look at both.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Purchasing Windows is an Unrecoverable Application Error.
