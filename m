Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278886AbRJ1XlV>; Sun, 28 Oct 2001 18:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278890AbRJ1XlL>; Sun, 28 Oct 2001 18:41:11 -0500
Received: from Expansa.sns.it ([192.167.206.189]:37644 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278886AbRJ1Xkz>;
	Sun, 28 Oct 2001 18:40:55 -0500
Date: Mon, 29 Oct 2001 00:42:03 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Fabrice Lorrain (home)" <fabrice.lorrain@chello.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: arp cache tuning in 2.4.x (x >= 10)
In-Reply-To: <3BDC7945.9166B90D@chello.fr>
Message-ID: <Pine.LNX.4.33.0110290033530.27202-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Oct 2001, Fabrice Lorrain (home) wrote:

> (please CC, I'm not on the list)
> (a CC to lorrain@univ-mlv.fr would be appreciated to)
> Hi,
>
> For quite some time now, I have "Neighbour table overflow." on
> one of our router (serving more than 1000 boxes).
>
> A bunch of google search gave me to answer :
> 1 - playing with /proc/sys/net/ipv4/neigh/default/gc_thres*
> 2 - configure CONFIG_ARPD and find an user-space arp daemon.
>
> Can any of you guys give more explanations on both solutions?
> Mainly :
> - what are sane value for 1),
> - is 2 really a "sane" solution (from Configure.help :
> "This code is experimental and also obsolete").
>
you can find arpd at
http://expansa.sns.it/knetfilter
I am actually manteining the user space daemon (at less one of them).
In the tarball you will find (in a bad english) the information you need.

Actually I have been reported of arpd not working properly
with latest kernels 2.4, since the kernel is not properly talking with
arpd device, and the limit of 255 entries for arp cache is not respected.
As a result you get a big degradation of performances.
I did some check, but arpd code seems to be correct, so the bug should be
somewhere else. I suspect the bug is somewhere inside of neighbour.c,
but I would need to make some deep test, and the  networks I have access
to do not have so mutch arp request going around.

Alan, also, pointed me to write to some guy about this, but I had no
reply.

bests

Luigi Genoni


