Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbUBXSDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbUBXSDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:03:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46042 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262341AbUBXSDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:03:34 -0500
Date: Tue, 24 Feb 2004 10:03:25 -0800
From: "David S. Miller" <davem@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Please back out the bluetooth sysfs support
Message-Id: <20040224100325.761f48eb.davem@redhat.com>
In-Reply-To: <1077621601.2880.27.camel@pegasus>
References: <20040223103613.GA5865@lst.de>
	<20040223101231.71be5da2.davem@redhat.com>
	<1077560544.2791.63.camel@pegasus>
	<20040223184525.GA12656@lst.de>
	<1077582336.2880.12.camel@pegasus>
	<20040224004151.GF31035@parcelfarce.linux.theplanet.co.uk>
	<20040223232149.5dd3a132.davem@redhat.com>
	<1077621601.2880.27.camel@pegasus>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 12:20:01 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> > > > -		skb->dev = (void *) &bfusb->hdev;
> > > > +		skb->dev = (void *) bfusb->hdev;
> > > 
> > > Wait a bloody minute.  skb->dev is supposed to be net_device; what's going
> > > on here?
> > 
> > Oh yeah, this is busted.
> > I'm surprised this doesn't explode.
> 
> we used this from the beginning and I don't see where this can explode,
> because the SKB's are only used inside the Bluetooth subsystem.

Ok, if that is %100 true, then it's OK.
