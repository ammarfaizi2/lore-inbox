Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130486AbQK1ExT>; Mon, 27 Nov 2000 23:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130514AbQK1ExJ>; Mon, 27 Nov 2000 23:53:09 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:38911 "EHLO
        mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
        id <S130486AbQK1Ew4>; Mon, 27 Nov 2000 23:52:56 -0500
Date: Tue, 28 Nov 2000 04:21:34 +0000
From: Toby Jaffey <toby@earth.li>
To: linux-kernel@vger.kernel.org
Subject: test-10 tulip "eth0 timed out" (smp, heavy IDE use)
Message-ID: <20001128042134.A1041@twoey>
Reply-To: toby@earth.li
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.4-test10 I got a series of timeout errors on my tulip network
card (Linksys LNE version 4, 00:0d.0 Ethernet controller: Bridgecom,
Inc: Unknown device 0985 (rev 11)). Networking then completely stopped
working. Restarting the interface with ifconfig fixed the problem.

I am using an SMP kernel, compiled with gcc 2.95.2 on an ABit BP6 (dual
celeron 500s, 128mb, PIIX4 using DMA).

[log extract]
Nov 28 04:04:52 twoey kernel: NETDEV WATCHDOG: eth0: transmit timed out
Nov 28 04:04:52 twoey kernel: eth0: Transmit timed out, status fc664010,
CSR12 00000000, resetting...
[end]

This has only happenned once so far, I have not been able to repeat the
problem. At the time, I was simultanously using two cd drives to rip
audio cds with DMA turned on, also I was using both processors fully.

-- 
www.nott.ac.uk/~psystrj ..::::::::::::::::::::::::::::::::::::::::::::::::.
     /\_./o__ ....:::::::::' Mescaline, the only way to fly.          '::::     
    (/^/(_^~'      '':::::                                             ::::  
  ___.(_.)____         ':::::::::::::::::::::::::::::::::::::::::::::::::::
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
