Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSEGSEN>; Tue, 7 May 2002 14:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315926AbSEGSEL>; Tue, 7 May 2002 14:04:11 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53008 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315925AbSEGSEH>; Tue, 7 May 2002 14:04:07 -0400
Date: Tue, 7 May 2002 14:00:42 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jesse Wyant <jrwyant@frx774.dhs.org>
cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: P4 Xeon summary inquiry
In-Reply-To: <200205070712.g477CSt00441@frx774.dhs.org>
Message-ID: <Pine.LNX.3.96.1020507135344.31216A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Jesse Wyant wrote:

> However, 'dnetc's throughput in RC5 keys/s is much lower with HT enabled: 
> it runs 4 clients, and each client chugs through about 720kKeys/s.  
> With HT disabled, the two dnetc clients run through 2.8MKeys/s each.  (So
> it's around half as fast with HT enabled!)  When I'm finished downloading
> RedHat 7.3, I'll reboot into Hyperthreading-enabled mode, and run 
> 'dnetc --benchmark' to confirm this.

  I believe that what you are seeing is caused by the two threads in each
CPU contending for cache, at least at L1 level, perhaps also L2. Other
than a careful study of the code or a hardware probe, I don't know if you
could even roughly qualtify that, but I'm moderately sure you're beating
the cache to death.

  If you had a Xeon with larger L2 it might be interesting to see if HT
ran at the same speed as the single thread CPU with half the cache. And if
you want to play more, you could use the BIOS to disable the L1 or L2
cache and see how much the performance changes. Doesn't matter, unless you
have another algorithm it doesn't address the behaviour.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

