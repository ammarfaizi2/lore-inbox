Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135415AbRALATp>; Thu, 11 Jan 2001 19:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132672AbRALATf>; Thu, 11 Jan 2001 19:19:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131033AbRALATa>; Thu, 11 Jan 2001 19:19:30 -0500
Date: Thu, 11 Jan 2001 19:19:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Longair <list-reader@ideaworks3d.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.2.18] outgoing connections getting stuck in SYN_SENT
In-Reply-To: <14942.18985.174437.785751@starfruit.iwks.multi.local>
Message-ID: <Pine.LNX.3.95.1010111191618.1531A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Mark Longair wrote:

> I'm having a problem where twice a day or so, any new tcp connection
> it gets stuck in SYN_SENT.  Eventually this situation rights itself,
> but obviously in the meantime many services (e.g. squid, X) are
> broken.  The machine does IP masquerdading with ipchains, and
> masqueraded connections through it seem to be unaffected.  The kernel
> version is 2.2.18, although the same happened with 2.2.17.
> 
[SNIPPED]

You probably compiled your kernel with "CONFIG_INET_ECN" set.
If so, you need to turn it OFF in /proc/sys/net/...something_ecn.

Many/most/all servers are "not ready for prime time" and will
reject packets that have "strange" bits set.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
