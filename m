Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280646AbRKST2r>; Mon, 19 Nov 2001 14:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280647AbRKST21>; Mon, 19 Nov 2001 14:28:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2319 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280646AbRKST2Z>; Mon, 19 Nov 2001 14:28:25 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Date: Mon, 19 Nov 2001 19:23:27 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9tbm7f$86o$1@penguin.transmeta.com>
In-Reply-To: <200111191801.fAJI1l922388@neosilicon.transmeta.com> <Pine.LNX.4.33.0111191003470.8205-100000@penguin.transmeta.com> <20011119123125.B1439@asooo.flowerfire.com>
X-Trace: palladium.transmeta.com 1006198091 18108 127.0.0.1 (19 Nov 2001 19:28:11 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 19 Nov 2001 19:28:11 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011119123125.B1439@asooo.flowerfire.com>,
Ken Brownfield  <brownfld@irridia.com> wrote:
>Linus, so far 2.4.15-pre4 with your patch does not reproduce the kswapd
>issue with Oracle, but I do need to perform more deterministic tests
>before I can fully sign off on that.
>
>BTW, didn't your patch go into -pre5?  Or is there an additional mod in
>-pre6 that we should try?

You're right, it's probably in pre5 already..

Anyway, it would be interesting to see if the patch by Andrea (I think
he called it "zone-watermarks") that changes the zone allocators to take
other zones into account makes a difference. See separate thread with
the subject line "15pre6aa1 (fixes google VM problem)". 

(I think the patch is overly complex as-is, but I htink the _ideas_ in
it are fine).

			Linus
