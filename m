Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129491AbRCHTfI>; Thu, 8 Mar 2001 14:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRCHTe6>; Thu, 8 Mar 2001 14:34:58 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:62452 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129491AbRCHTet>; Thu, 8 Mar 2001 14:34:49 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103081934.f28JYGS05891@webber.adilger.net>
Subject: Re: kernel BUG doing sysrq-t on 2.4.2-ac14
In-Reply-To: <NDBBKKONDOBLNCIOPCGHCEEBFEAA.vhou@khmer.cc> from Vibol Hou at "Mar
 8, 2001 11:06:08 am"
To: Vibol Hou <vhou@khmer.cc>
Date: Thu, 8 Mar 2001 12:34:15 -0700 (MST)
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vibol writes:
> While testing to see if SYSRQ-T would print the entire tasklist, a kernel
> bug popped up.  All I have is the tasklist up to the point where the bug
> showed up.

Actually, if you look closely, there is an OOPS report in there at the
end as well.  Unfortunately, since the tasklist output also looks like
an OOPS, it is basically impossible to extract.

> SNIP
>        [<c01e071d>] [<c01e079b>] [<c013cd93>] [<c013NceMIf5 W>]a tch<4d>og[<
> cde
> 01t0ec95t5ed7> L]O CK
> UPh ottnp Cd PU  0 ,  reSg is7FteFFrsF:FF

You can see it says "NMI Watchdog detected LOCKUP on CPU 0, registers:"

> [< c0109557>] kernel BUG at printk.c:327!

It may be that if the tasklist is too long, and it runs with interrupts
disabled, that this will trigger the NMI watchdog timer.  Since I don't
know anything about the console, I can't help.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
