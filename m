Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbRAaPny>; Wed, 31 Jan 2001 10:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRAaPno>; Wed, 31 Jan 2001 10:43:44 -0500
Received: from main.cyclades.com ([209.128.87.2]:4361 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129725AbRAaPnb>;
	Wed, 31 Jan 2001 10:43:31 -0500
Date: Wed, 31 Jan 2001 07:43:14 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.2.18: Protocol 0008 is buggy
In-Reply-To: <E14NxRb-0002Ku-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101310739150.3420-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Jan 2001, Alan Cox wrote:

> > What I'd like to know is: what exactly causes this msg?? It seems that
> > it's printed when someone sends a packet without properly setting 
> > skb->nh.raw first, but who's supposed to set skb->nh.raw?? The HW driver??
> > The data link (HDLC) driver?? The kernel protocol drivers? How should I go
> > about fixing this problem, where should I start??
> 
> It should be set before netif_rx() is called on the packet. Typically that
> means the driver or its support code sets protocol and nh.raw and if a
> second header is pulled up then they are set again by whichever code does that
> and calls netif_rx again

Alan,

Could you please tell me where I can find an example of this?? I searched
the whole drivers/net directory, and couldn't find any occurrence.

Is this really supposed to be done in the HW driver / support code level,
or is it supposed to be done in the protocol (IP / ARP) level??

Thanks for the reply!!

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
