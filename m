Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUHCVpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUHCVpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUHCVoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:44:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:12961 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266890AbUHCVmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:42:45 -0400
Subject: Re: Exposing ROM's though sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Jon Smirl <jonsmirl@yahoo.com>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1091226981.5066.15.camel@localhost.localdomain>
References: <1091207136.2762.181.camel@rohan.arnor.net>
	 <20040730172433.2312.qmail@web14924.mail.yahoo.com>
	 <20040730191448.GA2461@ucw.cz>  <200407301326.48094.jbarnes@engr.sgi.com>
	 <1091226981.5066.15.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1091569261.1862.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 07:41:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> emu86 is rather buggy. It can't boot C&T BIOSes for example. qemu might
> be a better engine for this anyway in truth.

And I like the idea of chosing a solution that won't limit us to x86 hosts
anyway ;)

With proper support from the "VGA arbitration driver" that Jon talked about
earlier, that should be quite portable, the kernel driver doing the job of
providing PIO accessors to VGA space and mmap functionality for VGA memory
hole if it exist (can modern cards be POST'ed with an x86 BIOS on machines
that won't let you access any VGA memory hole, that is that won't let you
generate PCI memory cycles to low addresses that overlap RAM ? If yes, then
pmacs would be able to soft-boot x86 cards that way).

Ben.


