Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272973AbTHKSg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272941AbTHKSes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:34:48 -0400
Received: from mail1.scram.de ([195.226.127.111]:62987 "EHLO mail1.scram.de")
	by vger.kernel.org with ESMTP id S272875AbTHKSeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:34:03 -0400
Date: Mon, 11 Aug 2003 20:33:23 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       <dahinds@users.sourceforge.net>
Subject: Re: PCI1410 Interrupt Problems
In-Reply-To: <20030807000914.J16116@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308112028300.10344-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: ---- Start SpamAssassin results
  0.50 points, 5 required;
  * -0.5 -- Has a In-Reply-To header
  *  0.0 -- Message-Id indicates a non-spam MUA (Pine)
  * -0.5 -- BODY: Contains what looks like a quoted email text
  *  0.9 -- RBL: Received via a relay in dnsbl.njabl.org
  [RBL check: found 145.115.226.217.dnsbl.njabl.org., type: 127.0.0.3]
  *  0.6 -- RBL: Received via a relay in relays.osirusoft.com
  [RBL check: found 145.115.226.217.relays.osirusoft.com., type: 127.0.0.3]
  ---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> Unfortunately, there are some hacks in the kernel at the moment which
> mess up the Cardbus IRQ routing by touching this register - the kernel
> should not be the one to play with hardware design specific register
> settings, especially when they are applied without thought across
> many hardware variants.

after thinking a bit, i believe, you're right here. Initially, i just
wanted to have an option to mess with this register, but there is already
the setpci tool which can do exactly this. So for now, i just added the
setpci command to my modules.conf and i'm set.

It's just a shame that PCI/Cardbus bridge manufacturers try to save a few
cents by not soldering the configuration EEPROM to their board and supply
some specialized drivers for Win just to make their crap work. So if you
place 2 different cards in the same PC with the same PCI1410 but different
pin mapping, you're doomed...

--jochen

