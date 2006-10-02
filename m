Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWJBP50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWJBP50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWJBP5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:57:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51073 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750838AbWJBP5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:57:24 -0400
Subject: Re: [PATCH] Introduce BROKEN_ON_64BIT facility
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: chas3@users.sourceforge.net, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, mac@melware.de,
       markus.lidel@shadowconnect.com, samuel@sortiz.org,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       Greg KH <greg@kroah.com>, thomas@winischhofer.net, ak@suse.de
In-Reply-To: <20061002151853.GK16272@parisc-linux.org>
References: <200610021352.k92DqRwa015220@cmf.nrl.navy.mil>
	 <1159801956.8907.13.camel@localhost.localdomain>
	 <20061002151853.GK16272@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 17:21:11 +0100
Message-Id: <1159806071.8907.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (whitespace damaged; more for comment than for application).
> 
> > -        if ((u32)skb->data & 3) {
> > +        if ((unsigned long)skb->data & 3) {
> 
> I suppose it quietens a compiler warning.  Doesn't actually fix a bug
> though.

Right but it does no harm casting it to either so its worth cleaning up.

