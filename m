Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130287AbRAaPry>; Wed, 31 Jan 2001 10:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130027AbRAaPre>; Wed, 31 Jan 2001 10:47:34 -0500
Received: from main.cyclades.com ([209.128.87.2]:5385 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129805AbRAaPrX>;
	Wed, 31 Jan 2001 10:47:23 -0500
Date: Wed, 31 Jan 2001 07:46:53 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.2.18: Protocol 0008 is buggy
In-Reply-To: <E14NxRb-0002Ku-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101310744151.3420-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Jan 2001, Alan Cox wrote:
> 
> It should be set before netif_rx() is called on the packet. Typically that
> means the driver or its support code sets protocol and nh.raw and if a
> second header is pulled up then they are set again by whichever code does that
> and calls netif_rx again

Another question. The function that prints the "buggy protocol" msg is
dev_queue_xmit_nit(), which is called by dev_queue_xmit(). Isn't that a Tx
function?? What would it have to do with netif_rx() (which from what I
understand is called to send Rx packets upstream, not used in the Tx
datapath)??

Thanks again!

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
