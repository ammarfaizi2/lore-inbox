Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266079AbUFVXFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266079AbUFVXFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUFVXFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:05:24 -0400
Received: from mail.njit.edu ([128.235.251.173]:49150 "EHLO mail-gw5.njit.edu")
	by vger.kernel.org with ESMTP id S265088AbUFVXDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:03:54 -0400
Date: Tue, 22 Jun 2004 19:03:22 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: Jonathan Corbet <corbet@lwn.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: sk_buff structure 
In-Reply-To: <20040622212403.21346.qmail@lwn.net>
Message-ID: <Pine.GSO.4.58.0406221855490.15759@chrome.njit.edu>
References: <20040622212403.21346.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the pointer. It was very helpful. Need to clarify a few more
questions though.

1. Does this mean that all the headers reside in skb->data - skb->head or
just the ethernet header ?
2. Or is it that the TCP and IP headers are considered part of data in
sk_buff and are stored in the skb->tail - skb->data section ?

I ask the second questions because I saw

skb->h.raw = skb->nh.raw = skb->data;

in netif_receive_skb() (/net/core/dev.c) function. With this statement it
would mean that there is no line of seperation between the two layers. Or
am I missing something here ?

Thanks,
Rahul.

On Tue, 22 Jun 2004, Jonathan Corbet wrote:

> > In this structure there are pointers called headroom, data, tailroom and
> > end. Does anyone know what these are used for. Or can anyone point me to a
> > good explanation for these fields.
>
> There is a basic discussion in chapter 14 of Linux Device Drivers which
> you can read online at http://www.xml.com/ldd/chapter/book/index.html.
>
> jon
>
> Jonathan Corbet
> Executive editor, LWN.net
> corbet@lwn.net
>
