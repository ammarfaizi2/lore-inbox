Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBZX5A>; Mon, 26 Feb 2001 18:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBZX4u>; Mon, 26 Feb 2001 18:56:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35743 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129161AbRBZX4b>;
	Mon, 26 Feb 2001 18:56:31 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15002.60558.421029.405754@pizda.ninka.net>
Date: Mon, 26 Feb 2001 15:53:50 -0800 (PST)
To: root@chaos.analogic.com
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1 network (socket) performance
In-Reply-To: <Pine.LNX.3.95.1010223104549.2101B-100000@chaos.analogic.com>
In-Reply-To: <3A966FF1.2C9E5641@colorfullife.com>
	<Pine.LNX.3.95.1010223104549.2101B-100000@chaos.analogic.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Richard B. Johnson writes:
 > > unix socket sends eat into memory reserved for atomic allocs.

OK (Manfred is being quoted here, to be clear).

I'm still talking with Alexey about how to fix this, I might just
prefer killing this fallback mechanism of skb_alloc_send_skb then
make AF_UNIX act just like everyone else.

This was always just a performance hack, and one which makes less
and less sense as time goes on.

Later,
David S. Miller
davem@redhat.com
