Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRB0L5I>; Tue, 27 Feb 2001 06:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129840AbRB0L46>; Tue, 27 Feb 2001 06:56:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129792AbRB0L44>; Tue, 27 Feb 2001 06:56:56 -0500
Subject: Re: Linux 2.4.1 network (socket) performance
To: davem@redhat.com (David S. Miller)
Date: Tue, 27 Feb 2001 11:59:14 +0000 (GMT)
Cc: root@chaos.analogic.com, manfred@colorfullife.com (Manfred Spraul),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <15002.60558.421029.405754@pizda.ninka.net> from "David S. Miller" at Feb 26, 2001 03:53:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ximk-0003FW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm still talking with Alexey about how to fix this, I might just
> prefer killing this fallback mechanism of skb_alloc_send_skb then
> make AF_UNIX act just like everyone else.
> 
> This was always just a performance hack, and one which makes less
> and less sense as time goes on.

When I first did the hack it was worth about 20% performance, but at the time
the fallback allocation and initial allocations didnt eat into pools in a 
problematic way

