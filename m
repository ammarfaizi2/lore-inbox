Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267871AbUG3XmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267871AbUG3XmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 19:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267873AbUG3XmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 19:42:12 -0400
Received: from the-village.bc.nu ([81.2.110.252]:35751 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267871AbUG3XmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 19:42:04 -0400
Subject: Re: Exposing ROM's though sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Christoph Hellwig <hch@infradead.org>,
       Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com>
	 <200407301010.29807.jbarnes@engr.sgi.com>
	 <20040730182410.A12171@infradead.org>
	 <200407301057.12445.jbarnes@engr.sgi.com>
	 <20040730181205.GW10025@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091227152.5054.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 30 Jul 2004 23:39:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-07-30 at 19:12, Matthew Wilcox wrote:
> I don't see a good way of doing this, unfortunately.  It'd probably be
> enough to call ->suspend on the driver while you read the contents of
> the ROM, but that's pretty ugly.

Is the BIOS guaranteed readable in D3 if we call suspend ?

Since we only need the BIOS in some special cases we could just reject
the request if the device is in use. If it has a driver - ask the
driver, if it doesn't then ask sysfs.
