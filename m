Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbUBXHWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 02:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUBXHWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 02:22:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262192AbUBXHWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 02:22:02 -0500
Date: Mon, 23 Feb 2004 23:21:49 -0800
From: "David S. Miller" <davem@redhat.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: marcel@holtmann.org, hch@lst.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Please back out the bluetooth sysfs support
Message-Id: <20040223232149.5dd3a132.davem@redhat.com>
In-Reply-To: <20040224004151.GF31035@parcelfarce.linux.theplanet.co.uk>
References: <20040223103613.GA5865@lst.de>
	<20040223101231.71be5da2.davem@redhat.com>
	<1077560544.2791.63.camel@pegasus>
	<20040223184525.GA12656@lst.de>
	<1077582336.2880.12.camel@pegasus>
	<20040224004151.GF31035@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 00:41:51 +0000
viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Tue, Feb 24, 2004 at 01:25:36AM +0100, Marcel Holtmann wrote:
> > Hi Christoph,
> > -		skb->dev = (void *) &bfusb->hdev;
> > +		skb->dev = (void *) bfusb->hdev;
> 
> Wait a bloody minute.  skb->dev is supposed to be net_device; what's going
> on here?

Oh yeah, this is busted.
I'm surprised this doesn't explode.
