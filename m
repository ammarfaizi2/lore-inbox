Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272270AbRIPFcW>; Sun, 16 Sep 2001 01:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273166AbRIPFcC>; Sun, 16 Sep 2001 01:32:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6922 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272270AbRIPFb4>; Sun, 16 Sep 2001 01:31:56 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: broken VM in 2.4.10-pre9
Date: Sun, 16 Sep 2001 05:31:11 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9o1dev$23l$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance>
X-Trace: palladium.transmeta.com 1000618315 17555 127.0.0.1 (16 Sep 2001 05:31:55 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Sep 2001 05:31:55 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance>,
Peter Magnusson  <iocc@flashdance.nothanksok.cx> wrote:
>
>2.4.10-pre4: quite ok VM, but put little more on the swap than 2.4.7
>2.4.10-pre8: not good

Ehh..

There are _no_ VM changes that I can see between pre4 and pre8.

>2.4.10-pre9: not good ... Linux didnt had used any swap at all, then i
>             unrared two very large files at the same time. And now 104
>             Mbyte swap is used! :-( 2.4.7 didnt do like this.
>             Best is to use the swap as little as possible.

.. and there are none between pre8 and pre9.

Basically, it sounds lik eyou have tested different loads on different
kernels, and some loads are nice and others are not.

Also note that the amount of "swap used" is totally meaningless in
2.4.x. The 2.4.x kernel will _allocate_ the swap backing store much
earlier than 2.2.x, but that doesn't actuall ymean that it does any of
the IO. Indeed, allocating the swap backing store just means that the
swap pages are then kept track of, so that they can be aged along with
other stores.

So whether Linux uses swap or not is a 100% meaningless indicator of
"goodness".  The only thing that matters is how well the job gets done,
ie was it reasonably responsive, and did the big untars finish quickly.. 

Don't look at how many pages of swap were used. That's a statistic,
nothing more.

		Linus
