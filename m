Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287952AbSAHGzX>; Tue, 8 Jan 2002 01:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287953AbSAHGzO>; Tue, 8 Jan 2002 01:55:14 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:4791 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S287952AbSAHGzD>; Tue, 8 Jan 2002 01:55:03 -0500
Date: Tue, 8 Jan 2002 08:55:17 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <robho956@student.liu.se>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: System errors under heavy load and with kernels > 2.4.0-test3-pre5
Message-ID: <Pine.LNX.4.33.0201080840400.12617-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Linux version 2.4.0-test3 (root@a70) (gcc version 2.95.3 20010315
>(release)) #2 Sat Jan 5 22:01:56 CET 2002

I understand that you've tested upto and including 2.4.16 but that kernel
oops information is a bit dated. Please reproduce with latest 2.4.18-pre
and submit a decoded oops.

>Not overclocked. I even tried to lower the speed to 375 MHz, running 75
>MHz bus speed.

Although you're not overclocking your CPU, you're actually overclocking
most of the busses on your system now...

>The problems disappear if I disable the secondary cache, but I guess
>that is because the stress on the system decreases and not because it's
>faulty.

Thats because you were running an overclocked FSB, your L2 runs at a
multiple of your FSB. L2 caches are very delicate especially when
overclocked. E.g. I have a CPU (C366) which can do 600Mhz stable with the
L2 disabled and only 577 with it enabled. But losing your L2 cache slows
things _considerably_. Try running memtest86 (I believe it tests caches as
well), this definately sounds like hardware problems.

Regards,
	Zwane Mwaikambo



