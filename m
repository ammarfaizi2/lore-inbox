Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423195AbWF1HDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423195AbWF1HDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423196AbWF1HDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:03:39 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7349 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1423195AbWF1HDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:03:38 -0400
Message-ID: <44A229C0.5060702@garzik.org>
Date: Wed, 28 Jun 2006 03:03:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Marcel Holtmann <marcel@holtmann.org>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
References: <200606260235.03718.dtor_core@ameritech.net>  <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>  <20060627063734.GA28135@kroah.com>  <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>  <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>  <Pine.LNX.4.64.0606271231440.3927@g5.osdl.org> <1151437593.25011.38.camel@localhost> <Pine.LNX.4.64.0606272057160.3927@g5.osdl.org> <Pine.LNX.4.64.0606272114330.3927@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606272114330.3927@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Anyway, "urb->transfer_buffer" was initialized with
> 
> 	urb->transfer_buffer = skb->data;
> 
> and I'm pretty damn sure you're supposed to just kfree() it.

eh?  I would think dev_kfree_skb(), because who knows whether the skb 
was cloned, split, data buffer adjusted, destructors need to be called...

kfree()ing skb->data sounds like a recipe for corruption and crashes...

	Jeff


