Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSGIOFW>; Tue, 9 Jul 2002 10:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSGIOFU>; Tue, 9 Jul 2002 10:05:20 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:49314 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315370AbSGIOFT>; Tue, 9 Jul 2002 10:05:19 -0400
Date: Tue, 9 Jul 2002 10:05:58 -0400
To: zwane@linuxpower.ca, jamagallon@able.es
Cc: andrea@suse.de, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: pipe and af/unix latency differences between aa and jam on smp
Message-ID: <20020709140558.GA21293@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> *Local* Communication latencies in microseconds - smaller is better

> kernel                          Pipe    AF/Unix
> -----------------------------  -------  -------
> 2.4.19-pre7-jam6                29.513   42.369
> 2.4.19-pre8-jam2                 7.697   15.274
> 2.4.19-pre8-jam2-nowuos          7.739   14.929

> (last line says that wake-up-sync is not responsible...)

> Main changes between first two were irqbalance and ide6->ide10.

The system is scsi only.  pre7-jam6 and pre8-jam2 .config's were 
identical.

> Could you try latest -rc1-aa2 ? It includes also irqbalance,

Based on Andrea'a diff logs, irqbalance appeared in 2.4.19pre10aa3.
There are small differences between the pre10-jam2 and aa irqbalance
patches.  One new datapoint with pre10-jam3:

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
kernel                          Pipe    AF/Unix
-----------------------------  -------  -------
2.4.19-pre10-jam2                7.877   16.699
2.4.19-pre10-jam3               33.133   66.825
2.4.19-pre10-aa2                34.208   62.732
2.4.19-pre10-aa4                33.941   70.216
2.4.19-rc1-aa1-1g-nio           34.989   52.704

A config difference between pre10-jam2 and pre10-jam3 is:
CONFIG_X86_SFENCE=y	# pre10-jam2
pre10-jam2 was compiled with -Os and pre10-jam3 with -O2.

> Out of interest, is that a P4/Xeon?

Quad P3/Xeon 700 mhz with 1MB cache.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

