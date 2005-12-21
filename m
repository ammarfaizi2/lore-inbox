Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVLUHKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVLUHKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVLUHKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:10:09 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:41842 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932294AbVLUHKH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:10:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sqykHYfZsXAru9XW8752jG+mZSBdHsNbyW6JOi54WEV2g2Qhf82Xe6E1P0aRxL4JWAEvBC3aEFGGF190Xr+Dmp25v3h5j9Ifa9Ua8eHvT85DiQ8Y3U+kuTCAZ/iJ4RyZYvksGhGuX/NHHKOjeHq0vm25eZq+F7LXTf6Or6NxlHY=
Message-ID: <41b516cb0512202310q78d5a25apab3c9d6fbb17089e@mail.gmail.com>
Date: Tue, 20 Dec 2005 23:10:07 -0800
From: Chris Leech <chris.leech@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Fwd: [RFC][PATCH 4/5] I/OAT DMA support and TCP acceleration
In-Reply-To: <41b516cb0512202305p45439464o6b7ba6c2c88062bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1135142263.13781.21.camel@cleech-mobl>
	 <43A8F43B.6020307@cosmosbay.com>
	 <41b516cb0512202305p45439464o6b7ba6c2c88062bc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, bounced from vger the first time due to formatting

---------- Forwarded message ----------
From: Chris Leech <christopher.leech@intel.com>
Date: Dec 20, 2005 11:05 PM
Subject: Re: [RFC][PATCH 4/5] I/OAT DMA support and TCP acceleration
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev
<netdev@vger.kernel.org>, "Grover, Andrew" <andrew.grover@intel.com>,
"Ronciak, John" <john.ronciak@intel.com>

On 12/20/05, Eric Dumazet <dada1@cosmosbay.com> wrote:
>  Please consider not enlarging cb[] if not CONFIG_NET_DMA ?
>
> I mean, most machines wont have a compatable NIC, so why should they pay the
> price (memory, cpu) in a critical structure named sk_buff ?
>
> #ifdef CONFIG_NET_DMA
> typedef dma_cookie_t net_dma_cookie_t;
> #else
> typedef struct {} net_dma_cookie_t;
> #endif
>
> ...
>
>         char   cb[40+sizeof(net_dma_cookie_t)];
>

 That could be a good way to deal with it.  Actually, I should double
check the length of tcp_skb_cb.  I took a quick look and thought that
there might be some room left there anyway, even though the comment in
tcp.h says otherwise.

 -Chris
