Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292925AbSCELPg>; Tue, 5 Mar 2002 06:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292582AbSCELP1>; Tue, 5 Mar 2002 06:15:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20352 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292860AbSCELPY>;
	Tue, 5 Mar 2002 06:15:24 -0500
Date: Tue, 05 Mar 2002 03:13:12 -0800 (PST)
Message-Id: <20020305.031312.92586410.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: [BETA-0.95] Sixth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


0.94 turned out to be the "not quite Ginseng" release, but lets try to
rectify that :-)

This is the "praying for powder snow up in Tahoe" release, or TAHOE
for short.  Get it at:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/TIGON3/tg3-0.95.patch.gz

[FIX] If we have to check the MAC_STAT register for link changes,
      do not do it from interrupts.  Do it from a timer instead.
      Hey maybe the Dell onboard Tigon3 problems are fixed for real
      now. :-)
[FIX] Off by one error in tg3_alloc_rx_skb() can lead to OOPS on
      ifdown.
[FIX] 5700 chip interrupt status reporting protocol is racey,
      work around it.
[DEBUG] Add assertions to TX ring processing.
[NICETY] When link comes up, report negotiated flow control settings.
[FEATURE] Adaptive RX coalescing.
[FEATURE] Improved DMA bursting settings, major performance
          improvement especially on non-x86 platforms (in particular
	  Alpha and Sparc64 should get 10MB/sec extra bandwidth out of
          this).
[DOC] Add Configure.help entry for CONFIG_TIGON3

I'm really really really really really (NO, I MEAN REALLY) interested
in performance comparisons of our 0.95 driver vs. Broadcom's stuff.

But, there is one special condition if you report benchmark numbers.
If our driver is faster _AND_ you are an _Australian_ in _Australia_,
you must send Jeff and I a case of Victoria Bitter for a job well
done. :-))))))

Note that this thing is to Marcelo very soon.  So get testing!

Franks a lot,
David S. Miller
davem@redhat.com
