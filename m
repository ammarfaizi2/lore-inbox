Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269152AbRGaByf>; Mon, 30 Jul 2001 21:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269156AbRGaByY>; Mon, 30 Jul 2001 21:54:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50847 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269152AbRGaByT>;
	Mon, 30 Jul 2001 21:54:19 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15206.3993.800893.762127@pizda.ninka.net>
Date: Mon, 30 Jul 2001 18:53:29 -0700 (PDT)
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, torvalds@transmeta.com,
        kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] netif_rx from non interrupt context
In-Reply-To: <4.3.1.0.20010730121828.05eaf310@mail1>
In-Reply-To: <4.3.1.0.20010730121828.05eaf310@mail1>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Maksim Krasnyanskiy writes:
 > Generic function for the net drivers that call netif_rx from non interrupt context.
 > And TUN/TAP driver patch.

No, let us do it explicitly in the drivers, not create a new API for
this.

Maybe we should add "Send to socket with BH disabled" or a "insert to
generic linked list with spinlock held" interfaces too? :-)

Later,
David S. Miller
davem@redhat.com
