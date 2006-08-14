Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752033AbWHNMjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbWHNMjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbWHNMjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:39:24 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:33946 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752033AbWHNMjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:39:22 -0400
Date: Mon, 14 Aug 2006 16:38:58 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060814123858.GA16954@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <1155558313.5696.167.camel@twins> <20060814123530.GA5019@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060814123530.GA5019@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 14 Aug 2006 16:39:02 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 04:35:30PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> > I'm still not clear on how you want to do this, only the trivial case of
> > a sniffer was mentioned by you. To be able to do true zero-copy receive
> > each packet will have to have its own page(s). Simply because you do not
> > know the destination before you receive it, the packet could end up
> > going to a whole different socket that the prev/next. As soon as you
> > start packing multiple packets on 1 page, you've lost the zero-copy
> > receive game.
> 
> Userspace can sak for next packet and pointer to the new location will
> be removed.

... returned.

The same will be applied for sending support - userspace will request
new packet with given size and pointer to some chunk inside mapped area
will be returned.

-- 
	Evgeniy Polyakov
