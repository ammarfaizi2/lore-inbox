Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261436AbSJABAw>; Mon, 30 Sep 2002 21:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261437AbSJABAv>; Mon, 30 Sep 2002 21:00:51 -0400
Received: from moore.degeorge.org ([66.92.236.98]:27155 "EHLO
	moore.degeorge.org") by vger.kernel.org with ESMTP
	id <S261436AbSJABAo>; Mon, 30 Sep 2002 21:00:44 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: "David L. DeGeorge" <dld@degeorge.org>
To: linux-kernel@vger.kernel.org
Subject: Re: CPU/cache detection wrong
Date: Mon, 30 Sep 2002 21:06:10 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209302106.10518.dld@degeorge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too have incorrect CPU/cache detection using  2.4.20-pre7-ac3. I seem to 
recall it working correctly on 2.4.19-ac1 (this was the version in which the 
ac did not get added by the patch). Anyway I have a tualatin PIII with a 512K 
L2 cache.  I inserted the printk in setup.c that Alan asked for earlier in 
the thread and got three outputs (it's a two processor machine). I have 
edited everything but the printk output and the CPU:... lines. Things are 
working fine with the kernel command line cachesize=512.
David
Sep 30 12:56:02 janus kernel: Cache info byte: 01
Sep 30 12:56:02 janus kernel: Cache info byte: 02
Sep 30 12:56:02 janus kernel: Cache info byte: 03
Sep 30 12:56:02 janus kernel: Cache info byte: 00
Sep 30 12:56:02 janus kernel: Cache info byte: 00
Sep 30 12:56:02 janus last message repeated 6 times
Sep 30 12:56:02 janus kernel: Cache info byte: 83
Sep 30 12:56:02 janus kernel: Cache info byte: 08
Sep 30 12:56:02 janus kernel: Cache info byte: 04
Sep 30 12:56:02 janus kernel: Cache info byte: 0C
Sep 30 12:56:02 janus kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Sep 30 12:56:02 janus kernel: CPU: L2 cache: 256K
...........................................................
Sep 30 12:56:02 janus kernel: Cache info byte: 01
Sep 30 12:56:02 janus kernel: Cache info byte: 02
Sep 30 12:56:02 janus kernel: Cache info byte: 03
Sep 30 12:56:02 janus kernel: Cache info byte: 00
Sep 30 12:56:02 janus last message repeated 7 times
Sep 30 12:56:02 janus kernel: Cache info byte: 83
Sep 30 12:56:02 janus kernel: Cache info byte: 08
Sep 30 12:56:02 janus kernel: Cache info byte: 04
Sep 30 12:56:02 janus kernel: Cache info byte: 0C
Sep 30 12:56:02 janus kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Sep 30 12:56:02 janus kernel: CPU: L2 cache: 256K
.....................................................................................
Sep 30 12:56:02 janus kernel: Cache info byte: 01
Sep 30 12:56:02 janus kernel: Cache info byte: 02
Sep 30 12:56:02 janus kernel: Cache info byte: 03
Sep 30 12:56:02 janus kernel: Cache info byte: 00
Sep 30 12:56:02 janus last message repeated 7 times
Sep 30 12:56:02 janus kernel: Cache info byte: 83
Sep 30 12:56:02 janus kernel: Cache info byte: 08
Sep 30 12:56:02 janus kernel: Cache info byte: 04
Sep 30 12:56:02 janus kernel: Cache info byte: 0C
Sep 30 12:56:02 janus kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Sep 30 12:56:02 janus kernel: CPU: L2 cache: 256K

