Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130749AbQK1FJi>; Tue, 28 Nov 2000 00:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130876AbQK1FJ2>; Tue, 28 Nov 2000 00:09:28 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:15635
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S130749AbQK1FJL>; Tue, 28 Nov 2000 00:09:11 -0500
Date: Mon, 27 Nov 2000 20:38:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Toby Jaffey <toby@earth.li>
cc: linux-kernel@vger.kernel.org
Subject: Re: test-10 tulip "eth0 timed out" (smp, heavy IDE use)
In-Reply-To: <20001128042134.A1041@twoey>
Message-ID: <Pine.LNX.4.10.10011272031070.17331-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Toby,

Nothing can be done without the full re-write of the driver.
The global request_io_lock is slammed into play way to early and release
way to late.  You will have to suffer with this flaw until the spin of
2.5.  We are talking about a rewrite that is still at least 60 days from
being ready for me to test.

I still have to draft the recovery tools to mirror the disks for the data
lose in the pre-alpha tests.

On Tue, 28 Nov 2000, Toby Jaffey wrote:

> Using 2.4-test10 I got a series of timeout errors on my tulip network
> card (Linksys LNE version 4, 00:0d.0 Ethernet controller: Bridgecom,
> Inc: Unknown device 0985 (rev 11)). Networking then completely stopped
> working. Restarting the interface with ifconfig fixed the problem.
> 
> I am using an SMP kernel, compiled with gcc 2.95.2 on an ABit BP6 (dual
> celeron 500s, 128mb, PIIX4 using DMA).
> 
> [log extract]
> Nov 28 04:04:52 twoey kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Nov 28 04:04:52 twoey kernel: eth0: Transmit timed out, status fc664010,
> CSR12 00000000, resetting...
> [end]
> 
> This has only happenned once so far, I have not been able to repeat the
> problem. At the time, I was simultanously using two cd drives to rip
> audio cds with DMA turned on, also I was using both processors fully.
> 
> -- 
> www.nott.ac.uk/~psystrj ..::::::::::::::::::::::::::::::::::::::::::::::::.
>      /\_./o__ ....:::::::::' Mescaline, the only way to fly.          '::::     
>     (/^/(_^~'      '':::::                                             ::::  
>   ___.(_.)____         ':::::::::::::::::::::::::::::::::::::::::::::::::::
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
