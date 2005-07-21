Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVGUJA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVGUJA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 05:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGUJA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 05:00:27 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:20957 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261701AbVGUJAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 05:00:25 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Multi-threaded IO performance regression on 2.6 kernel?
Date: Thu, 21 Jul 2005 09:00:23 +0000 (UTC)
Organization: Cistron
Message-ID: <dbno77$a6c$1@news.cistron.nl>
References: <1784BBD8D1F15B4C9FB0F09F0A939F9001A3E463@SZEXMTA4.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1121936423 10444 194.109.0.112 (21 Jul 2005 09:00:23 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1784BBD8D1F15B4C9FB0F09F0A939F9001A3E463@SZEXMTA4.amd.com>,
Xie, Bill <bill.xie@amd.com> wrote:
>All,
>
>I am testing the multi-threaded IO performance on Opteron servers. 
>
>I use dd as the test tools. The single dd can reach 60MBps for single disk.
>
>on 2.6.5 kernel, If dd numbers exceed the CPU numbers, vmstat bi reduced
>to 20MBps.
>
>on 2.4.21 kernel, multi-threaded IO performance works fine, even I run
>40 dd command at same time.
>
>Does anybody experienced similar issue also?

First, use a more recent kernel, 2.6.11.x or 2.6.12.x. Then try if
changing the I/O scheduler (/sys/block/sda/queue/scheduler) to
deadline or cfq makes a difference.

I'm using 2.6.11.x and the cfq scheduler on most servers right now.

Mike.

