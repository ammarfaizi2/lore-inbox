Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269391AbRGaSNz>; Tue, 31 Jul 2001 14:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269393AbRGaSNq>; Tue, 31 Jul 2001 14:13:46 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:26127 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269391AbRGaSNf>;
	Tue, 31 Jul 2001 14:13:35 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107311813.WAA09018@ms2.inr.ac.ru>
Subject: Re: [PATCH] netif_rx from non interrupt context
To: maxk@qualcomm.com (Maksim Krasnyanskiy)
Date: Tue, 31 Jul 2001 22:13:27 +0400 (MSK DST)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, andrea@suse.de,
        torvalds@transmeta.com
In-Reply-To: <4.3.1.0.20010731100209.05fce100@mail1> from "Maksim Krasnyanskiy" at Jul 31, 1 10:11:49 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> a critical path. Also it makes sense (to me) to hide softirq implementation details from the net drivers.

He tells right thing... The fact that netif_rx() is invalid in this context
and, especially, way to make it valid is not evident. It was not evident
for me three days ago, at least. :-)

Seems, it is better to hide this yet.

Alexey
