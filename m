Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUG3SXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUG3SXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267775AbUG3SXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:23:13 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:62854 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S267772AbUG3SUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:20:52 -0400
Date: Fri, 30 Jul 2004 20:20:54 +0200
From: Martin Mares <mj@ucw.cz>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Matthew Wilcox <willy@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730182054.GA3678@ucw.cz>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <200407301057.12445.jbarnes@engr.sgi.com> <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk> <200407301112.10361.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301112.10361.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> That might be a good solution, actually.  Then it would be cached for devices 
> that don't want you to look at it after they've been POSTed too.

There already exists a "pci=rom" switch which tells the PCI core to assign
addresses to the ROM BAR's as well. Either we can offer the files in the sysfs
only if this switch is enabled, or we can create another switch for making
copies of the ROM's during system boot.

Anyway, the devices sharing ROM decoder with another BAR seem to be pretty
rare.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Anti-trust laws should be approached with exactly that attitude.
