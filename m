Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTBUGDA>; Fri, 21 Feb 2003 01:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTBUGDA>; Fri, 21 Feb 2003 01:03:00 -0500
Received: from [63.205.85.133] ([63.205.85.133]:35079 "EHLO schmee.sfgoth.com")
	by vger.kernel.org with ESMTP id <S267174AbTBUGC7>;
	Fri, 21 Feb 2003 01:02:59 -0500
Date: Thu, 20 Feb 2003 22:12:55 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "David S. Miller" <davem@redhat.com>
Cc: chas williams <chas@locutus.cmf.nrl.navy.mil>,
       linux-kernel@vger.kernel.org
Subject: Re: [ATM] who 'owns' the skb created by drivers/atm?
Message-ID: <20030220221255.A11525@sfgoth.com>
References: <Pine.LNX.4.44.0302211241070.12797-100000@blackbird.intercode.com.au> <1045808570.22228.2.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <1045808570.22228.2.camel@rth.ninka.net>; from davem@redhat.com on Thu, Feb 20, 2003 at 10:22:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Thu, 2003-02-20 at 17:42, James Morris wrote:
> > skb->cb is owned by whatever layer is currently processing the skb.
> 
> Furthermore, once you netif_rx() an SKB it is no longer yours.
> It is owned by the networking stack.
> 
> If the ATM layer wants to do fancy things and still pass the SKB
> to netif_rx(), _it_ should clone the SKB and give that clone to
> the ATM layer directly.

As far as I'm aware the ATM layer doesn't care what happens to the
SKB after it gets passed to netif_rx(), so I don't know why this would
be a problem.  Some people seem to be suggesting that we need to zero
out ->cb before passing the SKB to netif_rx() but I don't see why
that would be neccesary.

-Mitch
