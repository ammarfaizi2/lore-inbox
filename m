Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUEVVYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUEVVYP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUEVVYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 17:24:15 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:50818 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261914AbUEVVYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 17:24:14 -0400
Date: Sat, 22 May 2004 23:24:10 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Exporting PCI ROMs via syfs
Message-ID: <20040522212410.GA2641@ucw.cz>
References: <20040521010510.84867.qmail@web14928.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521010510.84867.qmail@web14928.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Some problems:
> Radeon cards need a work around sometimes to enable their ROM. But this can be
> run once when the driver loads.
> There is one card that can't access the ROM and function at the same time, I
> believe Alan Cox know which one it is.

The PCI specs explicitly allow the cards to use a single address decoder for
both the ROM address and one of the BARs and there really are cards which make
use of this silliness.

Probably the only reasonable way how to do that reliably is to make a copy of
the ROM before the device is enabled.

OTOH, it might be sensible to add a sysfs-based interface for reading the ROMs
which would be available only to root and which would work only on cards
without the shared decoders :-)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
To avoid bugs in your room, just keep Windows closed.
