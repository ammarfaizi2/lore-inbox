Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271987AbRIVT6T>; Sat, 22 Sep 2001 15:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271989AbRIVT6K>; Sat, 22 Sep 2001 15:58:10 -0400
Received: from as1-5-2.tbg.s.bonet.se ([217.215.34.209]:41382 "EHLO
	flashdance.cx") by vger.kernel.org with ESMTP id <S271987AbRIVT6C>;
	Sat, 22 Sep 2001 15:58:02 -0400
Date: Sat, 22 Sep 2001 21:59:04 +0200 (CEST)
From: Peter Magnusson <iocc@linux-kernel.flashdance.cx>
X-X-Sender: <iocc@flashdance>
To: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <Pine.LNX.4.33L2.0109222158180.26508-100000@flashdance>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance>,
> Peter Magnusson  <iocc@flashdance.nothanksok.cx> wrote:
> >
> >2.4.10-pre4: quite ok VM, but put little more on the swap than 2.4.7
> >2.4.10-pre8: not good
>
> Ehh..
>
> There are _no_ VM changes that I can see between pre4 and pre8.
>
> >2.4.10-pre9: not good ... Linux didnt had used any swap at all, then i
> >             unrared two very large files at the same time. And now 104
> >             Mbyte swap is used! :-( 2.4.7 didnt do like this.
> >             Best is to use the swap as little as possible.
>
> .. and there are none between pre8 and pre9.
>
> Basically, it sounds lik eyou have tested different loads on different
> kernels, and some loads are nice and others are not.

I guess i just was lucky when i used pre4 before.
I have rebooted to pre4 now. unrared exactly the same very big files
that i did in pre9. 70 Mbyte swap used and the box has just been
rebooted!

My guess:

It treats the file system cache as important as normal programs and
thats is very wrong. Its like this on all kernels over 2.4.7.

> Also note that the amount of "swap used" is totally meaningless in
> 2.4.x. The 2.4.x kernel will _allocate_ the swap backing store much
> earlier than 2.2.x, but that doesn't actuall ymean that it does any of
> the IO. Indeed, allocating the swap backing store just means that the

I go after what top (in the Swap used field), xosview says. It havent
lied for me yet. And its hard to miss the slowdown when my computer
trys to swap out about 100 Mbyte.

The "SWAP" field in top lies however, but its not that Im looking on.


