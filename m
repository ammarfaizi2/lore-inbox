Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWF1XDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWF1XDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWF1XDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:03:10 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:52177 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751659AbWF1XDI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:03:08 -0400
Subject: Re: [git pull] Input update for 2.6.17
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606281502280.12404@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net>
	 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>
	 <20060627063734.GA28135@kroah.com>
	 <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>
	 <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>
	 <Pine.LNX.4.64.0606271231440.3927@g5.osdl.org>
	 <1151437593.25011.38.camel@localhost>
	 <Pine.LNX.4.64.0606272057160.3927@g5.osdl.org>
	 <Pine.LNX.4.64.0606272114330.3927@g5.osdl.org>
	 <44A229C0.5060702@garzik.org>
	 <Pine.LNX.4.64.0606281502280.12404@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 01:03:06 +0200
Message-Id: <1151535786.26495.84.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> > > Anyway, "urb->transfer_buffer" was initialized with
> > > 
> > > 	urb->transfer_buffer = skb->data;
> > > 
> > > and I'm pretty damn sure you're supposed to just kfree() it.
> > 
> > eh?  I would think dev_kfree_skb(), because who knows whether the skb was
> > cloned, split, data buffer adjusted, destructors need to be called...
> 
> Well, we don't actually have the skb available any more.
> 
> > kfree()ing skb->data sounds like a recipe for corruption and crashes...
> 
> Yeah. But I didn't actually look very deeply, maybe I mistook the init 
> sequence. That said, corruption and crashes is obviously what I see, and 
> why I started looking at it ;)

sorry, I haven't found the time to look into that. The hci_usb driver is
actually a mess and in a desperate need of a rewrite. However I haven't
seen anything like this oops in the past. Let me try to reproduce this.

Regards

Marcel


