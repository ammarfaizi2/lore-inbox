Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUBXAl6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUBXAl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:41:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47548 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262116AbUBXAlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:41:52 -0500
Date: Tue, 24 Feb 2004 00:41:51 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Please back out the bluetooth sysfs support
Message-ID: <20040224004151.GF31035@parcelfarce.linux.theplanet.co.uk>
References: <20040223103613.GA5865@lst.de> <20040223101231.71be5da2.davem@redhat.com> <1077560544.2791.63.camel@pegasus> <20040223184525.GA12656@lst.de> <1077582336.2880.12.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077582336.2880.12.camel@pegasus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 01:25:36AM +0100, Marcel Holtmann wrote:
> Hi Christoph,
> -		skb->dev = (void *) &bfusb->hdev;
> +		skb->dev = (void *) bfusb->hdev;

Wait a bloody minute.  skb->dev is supposed to be net_device; what's going
on here?
