Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbUJaBEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUJaBEj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 21:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUJaBEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 21:04:39 -0400
Received: from inx.pm.waw.pl ([195.116.170.20]:54666 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261454AbUJaBEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 21:04:36 -0400
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: net: generic netdev_ioaddr
References: <1099044244.9566.0.camel@localhost>
	<20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
	<courier.418290EC.00002E85@courier.cs.helsinki.fi>
	<m3y8hpbaf9.fsf@defiant.pm.waw.pl>
	<20041029193827.GV24336@parcelfarce.linux.theplanet.co.uk>
	<m3u0sdb53f.fsf@defiant.pm.waw.pl>
	<1099129946.10961.9.camel@localhost>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 31 Oct 2004 02:02:48 +0100
In-Reply-To: <1099129946.10961.9.camel@localhost> (Pekka Enberg's message of
 "Sat, 30 Oct 2004 12:52:26 +0300")
Message-ID: <m3r7nfem2v.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> writes:

>> With this driver it happens to be MMIO address.

Of course 0x4000 was an IO (non-MMIO) address.

> It seems that the user can also setup dev->base_addr with "netdev="
> kernel parameter before a driver starts probing (for example
> drivers/net/appletalk/cops.c). Should we get rid of "netdev=" too and
> push preconfiguring down to the drivers that actually use it?

Sure, cops.io= should be fine. Or cops.hw=io,irq,mem etc.

Still, this is an issue with non-PnP ISA cards only.
-- 
Krzysztof Halasa
