Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265796AbRF1NnO>; Thu, 28 Jun 2001 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265837AbRF1NnE>; Thu, 28 Jun 2001 09:43:04 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:6079 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S265796AbRF1NnA>;
	Thu, 28 Jun 2001 09:43:00 -0400
Date: Thu, 28 Jun 2001 16:40:47 +0300
To: ext Andi Kleen <ak@suse.de>
Cc: Gautier Harmel <Gautier.Harmel@qosmos.net>, linux-kernel@vger.kernel.org
Subject: Re: How to pass packets up to protocols layer ?
Message-ID: <20010628164047.A9478@terrapin>
In-Reply-To: <3B3AFFDE.2763D18F@qosmos.net.suse.lists.linux.kernel> <oup3d8k4vz0.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <oup3d8k4vz0.fsf@pigdrop.muc.suse.de>
User-Agent: Mutt/1.3.18i
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Either use netif_rx()/ for complete packets that should go through the
> whole stack again or nf_reinject() from your hook.

Is it really possible to call netif_rx from netfilter hook? I try to
call netif_rx(skb) from PRE_ROUTING hook (returning NF_STOLEN)
and kernel immediately crashes, even if I did nothing with skb at all.
Why it happens this way?

-- 
Alexey
