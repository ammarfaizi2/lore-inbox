Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263662AbUJ3JvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbUJ3JvK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 05:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbUJ3JvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 05:51:10 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:49901 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S263662AbUJ3JvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 05:51:05 -0400
Subject: Re: net: generic netdev_ioaddr
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <m3u0sdb53f.fsf@defiant.pm.waw.pl>
References: <1099044244.9566.0.camel@localhost>
	 <20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
	 <courier.418290EC.00002E85@courier.cs.helsinki.fi>
	 <m3y8hpbaf9.fsf@defiant.pm.waw.pl>
	 <20041029193827.GV24336@parcelfarce.linux.theplanet.co.uk>
	 <m3u0sdb53f.fsf@defiant.pm.waw.pl>
Date: Sat, 30 Oct 2004 12:52:26 +0300
Message-Id: <1099129946.10961.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Al Viro <viro@parcelfarce.linux.theplanet.co.uk> writes:
> > What uses ->base_addr from the data returned by SIOCGIFMAP?

On Fri, 2004-10-29 at 23:13 +0200, Krzysztof Halasa wrote:
> 
> ifconfig I think:

[snip] 

> With this driver it happens to be MMIO address.
> 
> I understand presenting this value to users might have some value:
> it can help determine the physical port/card for a given netdev.
> But it should be something like a description text set by the driver
> (ie. containing PCI bus/device, or even ISA address for ISA non-PnP
> card, possibly with other information).

It seems that the user can also setup dev->base_addr with "netdev="
kernel parameter before a driver starts probing (for example
drivers/net/appletalk/cops.c). Should we get rid of "netdev=" too and
push preconfiguring down to the drivers that actually use it?

		Pekka

