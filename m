Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUHVTvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUHVTvK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 15:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268085AbUHVTvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 15:51:10 -0400
Received: from h002.c000.snv.cp.net ([209.228.32.66]:2202 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S268083AbUHVTvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 15:51:02 -0400
X-Sent: 22 Aug 2004 19:51:01 GMT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: romieu@fr.zoreil.com, jgarzik@pobox.com
From: dag@bakke.com
Subject: Re: RTL-8139 Network card slow down on 2.6.8.1-mm
X-Sent-From: dag@bakke.com
Date: Sun, 22 Aug 2004 12:50:45 -0700 (PDT)
X-Mailer: Web Mail 5.6.4-0
Message-Id: <20040822125101.13842.h009.c000.wm@mail.bakke.com.criticalpath.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francois, Jeff

I have noticed an anomaly with the 8139C network card which I would like
to hear your opinion about, if you have time to spare.
I don't think it is the same problem which started this thread.

I have been testing a specific kind of networking equipment with two
laptops equipped with RTL8139C cardbus cards. 
I use the application 'iperf' to measure troughput.
To establish the base level bandwidth, I use a crossover cable between
the two PCs, and measure the bandwidth "back to back".

With UDP, I easily achieve around 93-94 Mbps with these cards, be it
one-way or two-way traffic.

With TCP, I achieve 92-93 Mbps with one-way traffic. Two-way traffic is
variable, and my main question revolves around this fact.

I have on one, single occation been able to measure 90 Mbps two-way TCP
traffic. More common is 86-87 Mbps. Occasionally, two-way traffic drops
down to 67 Mbps. The only way to get it back up is to pull the cards and
put them back in.

If there had been packet drops (I need to generate stats here...) I'd
understand it if the TCP protocol was throttling the troughput. But I am
not convinced that is the issue here.


- What troughput (2way, TCP) should I be able to achieve with the
RTL8139C and the 8139too driver?

- Does the hardware support flow control?

- Is there a particular reason the NAPI patch for the 8139 isn't merged
yet?

I am currently testing with 2.6.8.1 + the 8139 napi patch + the two 8139
patches in -mm1.


Regards,


Dag B.
