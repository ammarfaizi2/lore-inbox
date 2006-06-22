Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWFVI5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWFVI5u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 04:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWFVI5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 04:57:50 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:967 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932476AbWFVI5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 04:57:49 -0400
Message-ID: <449A5B83.4090104@pobox.com>
Date: Thu, 22 Jun 2006 04:57:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, snakebyte@gmx.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: Memory corruption in 8390.c ? (was Re: Possible leaks in network
 drivers)
References: <1150909982.15275.100.camel@localhost.localdomain> <E1FtDU0-0005nd-00@gondolin.me.apana.org.au> <20060622023029.GA6156@gondor.apana.org.au> <449A533E.4090201@pobox.com> <20060622082931.GA26083@gondor.apana.org.au>
In-Reply-To: <20060622082931.GA26083@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Thu, Jun 22, 2006 at 04:22:22AM -0400, Jeff Garzik wrote:
>>> it if needed.  Actually, someone should sift through every instance of
>>> skb_pad on a non-linear skb as they do not fit the reasons why this was
>>> originally created.
>> Non-linear skbs smaller than ETH_ZLEN seem unlikely.
> 
> When I was grepping it seems that a few drivers were using it with
> a length other than ETH_ZLEN.  I've just done another grep and here
> are the potential suspects:
> 
> cassini.c
> starfire.c
> yellowfin.c

That doesn't really invalidate the point :)  These drivers are still 
only padding very small packets.

	Jeff



