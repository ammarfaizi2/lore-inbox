Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUBXT00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUBXT0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:26:25 -0500
Received: from linux-bt.org ([217.160.111.169]:34970 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262388AbUBXT0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:26:24 -0500
Subject: Re: Please back out the bluetooth sysfs support
From: Marcel Holtmann <marcel@holtmann.org>
To: "David S. Miller" <davem@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040224100325.761f48eb.davem@redhat.com>
References: <20040223103613.GA5865@lst.de>
	 <20040223101231.71be5da2.davem@redhat.com>
	 <1077560544.2791.63.camel@pegasus> <20040223184525.GA12656@lst.de>
	 <1077582336.2880.12.camel@pegasus>
	 <20040224004151.GF31035@parcelfarce.linux.theplanet.co.uk>
	 <20040223232149.5dd3a132.davem@redhat.com>
	 <1077621601.2880.27.camel@pegasus>
	 <20040224100325.761f48eb.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1077650761.2919.42.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 20:26:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> > > > > -		skb->dev = (void *) &bfusb->hdev;
> > > > > +		skb->dev = (void *) bfusb->hdev;
> > > > 
> > > > Wait a bloody minute.  skb->dev is supposed to be net_device; what's going
> > > > on here?
> > > 
> > > Oh yeah, this is busted.
> > > I'm surprised this doesn't explode.
> > 
> > we used this from the beginning and I don't see where this can explode,
> > because the SKB's are only used inside the Bluetooth subsystem.
> 
> Ok, if that is %100 true, then it's OK.

I went through the code to check it and we only use skb->dev between the
HCI driver and the HCI core layer. All layers above are clean.

Regards

Marcel


