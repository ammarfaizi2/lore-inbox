Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270101AbRH1Uwv>; Tue, 28 Aug 2001 16:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270206AbRH1Uwb>; Tue, 28 Aug 2001 16:52:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44813 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270101AbRH1Uw0>; Tue, 28 Aug 2001 16:52:26 -0400
Date: Tue, 28 Aug 2001 13:49:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010828.130110.26275634.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0108281348220.15377-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Aug 2001, David S. Miller wrote:
>
>    At least something seems to be broken in it. I did run some 900MB processes
>    on a 512MB machine with 2.4.9 and kswapd took between 70 and 90% of the CPU
>    time.
>
> That's all swapmap lookup stupidity, you'll see __get_swap_page()
> near the top of your profiles.  The algorithm is just sucky.

Well, in all fairness the kswapd changes _do_ make kswapd more eager to
keep running too (ie kswapd tends to keep running until there is no
shortage any more - which it traditionally hasn't really done).

There might be an argment for making kswapd less eager, and more of a
background thing.

Regardless of where it actually spends the CPU time.

		Linus

