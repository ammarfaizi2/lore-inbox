Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269980AbRHERTC>; Sun, 5 Aug 2001 13:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269981AbRHERSv>; Sun, 5 Aug 2001 13:18:51 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:24327 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269980AbRHERSi>;
	Sun, 5 Aug 2001 13:18:38 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200108051718.VAA17521@ms2.inr.ac.ru>
Subject: Re: alloc_skb cannot be called with GFP_DMA
To: andrea@suse.DE (Andrea Arcangeli)
Date: Sun, 5 Aug 2001 21:18:11 +0400 (MSK DST)
Cc: davem@redhat.com (Dave Miller), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010805181606.F21840@athlon.random> from "Andrea Arcangeli" at Aug 5, 1 08:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> alloc_isa_skb will avoid to slowdown alloc_skb so I prefer it compared
> to hiding the logic inside alloc_skb.

Stop! This is redundant. GFP_DMA is for skb data, not head!

So that, it is enough and right to clear GFP_DMA inside
alloc_skb when allocating skb head.

Alexey
