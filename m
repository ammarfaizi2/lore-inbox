Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284953AbRLQBVT>; Sun, 16 Dec 2001 20:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284952AbRLQBVJ>; Sun, 16 Dec 2001 20:21:09 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:38665 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S284950AbRLQBU7>; Sun, 16 Dec 2001 20:20:59 -0500
Message-ID: <3C1D4871.82053E7A@zk3.dec.com>
Date: Sun, 16 Dec 2001 20:20:49 -0500
From: Peter Rival <frival@zk3.dec.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc1 does not boot my Alphas
In-Reply-To: <20011216160404.A2945@mail.harddata.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try again, this time adding "srmcons" to the boot flags.  You're croaking
before we get the console set up under Linux so none of the boot messages are
getting out; srmcons uses the SRM console to print its messages.  This won't
fix the bugs, but at least we'll be able to see exactly where you die.

 - Pete

Michal Jaegermann wrote:

> I just happen to have an access right now to two Alpha machines,
> UP1100 and UP1500, both with Nautilus chipset.  Neither of these
> can be booted with 2.4.16 or 2.4.17rc1. On an attempt to boot
> I can see only messages from a boot loader (aboot):
> .....
> zero-filling 155872 bytes at 0xffffc0000ad1308
> starting kernel vmlinux.......
>
> and that is it.  The only thing which works now is a power switch.
> The same happens if I try 2.4.17aa1rc1 (Andrea patches).
>
> A kernel with the highest version which I managed to boot so far,
> on both machines, is 2.4.13-ac8.  Anybody with a handly on what is
> going on?  I did not check yet if various Alpha specific patches
> which were present in "ac" were merged into mainline.  But so
> far things seem to be quite thorougly broken for Alpha (or at
> least Nautilus).
>
>   Michal
>   michal@harddata.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

