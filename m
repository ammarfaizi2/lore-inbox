Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbRENLKZ>; Mon, 14 May 2001 07:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262339AbRENLKP>; Mon, 14 May 2001 07:10:15 -0400
Received: from mgw-x1.nokia.com ([131.228.20.21]:56763 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S262335AbRENLJ6>;
	Mon, 14 May 2001 07:09:58 -0400
Date: Mon, 14 May 2001 14:07:09 +0300
To: linux-kernel@vger.kernel.org
Cc: olaf@bigred.inka.de
Subject: Re: Question about ipip implementation
Message-ID: <20010514140709.A3325@Hews1193nrc>
In-Reply-To: <20010511173940.A418@Hews1193nrc> <E14yvjd-0002Rw-00@g212.hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14yvjd-0002Rw-00@g212.hadiko.de>; from olaf@bigred.inka.de on Sun, May 13, 2001 at 03:16:28PM +0200
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I read net/ipv4/ipip.c. It seems to me that ipip_rcv() function after
> > "unwrapping" tunelled IP packet creates "virtual Ethernet header" and submit
> 
> Does it? ipip_rcv() does this:

[SKIP]

> 		netif_rx(skb);
> 
> The packet as submitted starts with the IP header and the skb pointers
> are set up so that the MAC header has zero size.


Yes, I was wrong. But is it possible in similar situation just call ip_rcv for
the sk_buff?

-- 
Alexey
