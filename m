Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132017AbQLJUC2>; Sun, 10 Dec 2000 15:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132473AbQLJUCT>; Sun, 10 Dec 2000 15:02:19 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:4877 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S132017AbQLJUCJ>; Sun, 10 Dec 2000 15:02:09 -0500
Date: Sun, 10 Dec 2000 21:44:28 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: <thunder7@xs4all.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18pre25: VM: do_try_to_free_pages failed for
Message-ID: <Pine.LNX.4.30.0012102104380.5455-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thunder7 wrote:
> for almost everything:
>Dec 10 13:33:47 middle kernel: VM: do_try_to_free_pages failed for kswapd...
[....]
> <tried to log in over the network, didn't work, pressed C-A-D and
> watched fsck mull over 60+ Gb>

You could try out my patch that "reserves" virtual memory for root, so
you should be able to login/ssh and clean up if your "faulty" or
memory hungry daemons aren't run by root -- it works fine for me
and I didn't get negative feedback so far:
	http://mlf.linux.rulez.org/mlf/ezaz/reserved_root_vm+oom_killer-5.diff
More on the patch,
	http://boudicca.tux.org/hypermail/linux-kernel/2000week48/0624.html

> Most messages I was able to dig up about this mentioned 2.2.17 and
> suggested upgrading to 2.2.18pre. I didn't think there is anything
> changed between 2.2.18pre25 and 2.2.18pre26(2.2.18 to be) in VM
> handling, so the problem still seems to persist. What are the
> suggestions? Moving to 2.4 is not possible, since the isdn
> compression module isdn_lzscomp.o won't work in 2.4.

Andrea Arcangeli's VM global patch got good feedback and according to
Alan Cox it's a potential candidate for 2.2.19,
ftp://ftp.nl.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre18/VM-global-2.2.18pre18-7.bz2

Good luck,

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
