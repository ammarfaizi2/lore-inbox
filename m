Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUG3Um0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUG3Um0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267787AbUG3UmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:42:25 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:17545 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S267832AbUG3UlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:41:20 -0400
Date: Fri, 30 Jul 2004 22:41:21 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730204121.GA5718@ucw.cz>
References: <20040730201052.GA5249@ucw.cz> <20040730203225.81054.qmail@web14926.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730203225.81054.qmail@web14926.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Reasons for ROMs in sysfs:

Good ones, although I believe than re-initializing cards after resume
should better be in the kernel.

> The only time the ROM will get cached is when you load a kernel device
> driver for a card that implements minimalistic PCI decoding (very few
> cards) and the driver asks for it. The driver would ask for caching
> since it knows that the decoder lines aren't complete.

And, even with your list of reasons, it is still very unlikely that anybody
will ever need the cached copy :-)  I still do not see a device which
would have shared decoders AND needed such initialization in userspace.

(Also, while we are speaking about video hardware -- they either have no
kernel driver, so nobody can ask for the copy, or they have one, but in
that case the BIOS mode switching calls and similar things can be accomplished
by the kernel driver with no need of messing with the ROM in the userspace.)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
How an engineer writes a program: Start by debugging an empty file...
