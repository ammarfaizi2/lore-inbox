Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135447AbRARUxH>; Thu, 18 Jan 2001 15:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135567AbRARUw6>; Thu, 18 Jan 2001 15:52:58 -0500
Received: from nat-pool-e.redhat.com ([199.183.24.21]:49156 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135447AbRARUwt>; Thu, 18 Jan 2001 15:52:49 -0500
Date: Thu, 18 Jan 2001 15:50:42 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
To: <kuznet@ms2.inr.ac.ru>
cc: Rick Jones <raj@cup.hp.COM>, <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <200101182030.XAA08626@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.30.0101181547580.24913-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jan 2001 kuznet@ms2.inr.ac.ru wrote:

> Actually, TUX-1.1 (Ingo, do I not lie, did you not kill this code?)
> does this. It does not ack quickly, when complete request is received
> and still not answered, so that all the redundant acks disappear.

(it's TUX 2.0 meanwhile), and yes, TUX uses it. We speculatively delay ACK
of parsed input packet in the hope of merging it with the first output
packet. If the output frame does not happen for 200 msecs then we send a
standalone ACK to be RFC-conform. This way TUX can do single-packet web
replies for small requests. (well, plus SYN-ACK and FIN-ACK)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
