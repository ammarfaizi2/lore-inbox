Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268094AbRG2RLo>; Sun, 29 Jul 2001 13:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268096AbRG2RLf>; Sun, 29 Jul 2001 13:11:35 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:48909 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268094AbRG2RLW>; Sun, 29 Jul 2001 13:11:22 -0400
Date: Sun, 29 Jul 2001 10:07:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
cc: Andrea Arcangeli <andrea@suse.de>, <maxk@qualcomm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <davem@redhat.com>
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
In-Reply-To: <200107282328.DAA01045@mops.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0107291002570.8151-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Sun, 29 Jul 2001, Alexey Kuznetsov wrote:
>
> Before falling to euforia, the last question:
> Is Ingo really happy with this? He blamed about latency,
> it is not better than in 2.4.5 (with cpu_idle fix) :-)

I think the latency issue was really the fact that we weren't always
running softirqs in a timely fashion after they had been disabled by a
"disable_bh()". That is fixed with the new softirq stuff, regardless of
the other issues.

But it would be good to have some specweb runs etc done to verify.

Ingo?

		Linus

