Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130225AbRBZO2j>; Mon, 26 Feb 2001 09:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130218AbRBZO23>; Mon, 26 Feb 2001 09:28:29 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130207AbRBZO2P>;
	Mon, 26 Feb 2001 09:28:15 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.2 -> 2.4: /proc/net/tcp 10x slower ?
From: Sven Rudolph <rudsve@drewag.de>
Date: 26 Feb 2001 15:12:01 +0100
Message-ID: <xfkelwlo7ny.fsf@uxrs2.drewag.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Usually identd's on Linux parse /proc/net/tcp.

When migrating from Linux 2.2.17 to 2.4.2 identd became much slower.

I traced it back to the point where /proc/net/tcp is read.

On the same slightly loaded system:

2.2.17 $ time cat /proc/net/tcp >/dev/null
real    0m0.004s
user    0m0.000s
sys     0m0.010s

(Or sometimes 0.000s due to granularity)

2.2.17 $ time cat /proc/net/tcp >/dev/null
real    0m0.083s
user    0m0.000s
sys     0m0.080s


Is this expected? Or is there a more efficient interface that identd
should use?

	Sven

