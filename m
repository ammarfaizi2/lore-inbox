Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbTBTNvm>; Thu, 20 Feb 2003 08:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTBTNvl>; Thu, 20 Feb 2003 08:51:41 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:7662 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265532AbTBTNvk>; Thu, 20 Feb 2003 08:51:40 -0500
Date: Thu, 20 Feb 2003 09:07:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: oom running aim7 on 2.5.61-mm1
Message-ID: <20030220140715.GA6851@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This test creates memory pressure, but shouldn't OOM:

2.5.62-mm1 ran AIM7 compute and other tests without OOM.

> I'll try 2.5.61-mm1 with elevator=cfq.

I ran 2.5.61-mm1 with both default and cfq I/O elevators.
These results could be skewed by the mm_struct leak in 61-mm1,
but FWIW:

Default 2.5.61-mm1 I/O scheduler did better in most cases:

AIM7 dbase test:
                      load      jobs/minute (higher is better)
2.5.61-mm1               8      76.6
2.5.61-mm1-cfq           8      68.7

2.5.61-mm1-cfq           16     100.0
2.5.61-mm1               16     132.4

2.5.61-mm1-cfq           32     136.5
2.5.61-mm1               32     198.7


AIM7 fileserver test
                      load      jobs/minute (higher is better)
2.5.61-mm1-cfq           10     149.8
2.5.61-mm1               10     175.3


Tiobench ext sequential reads
                      threads  MB/sec  CPU usage   max latency
2.5.61-mm1-cfq             16    9.34    14.06%          497.8 (seconds)
2.5.61-mm1                 16   15.52    53.86%            5.2

More quad xeon benchmarks at:
http://home.earthlink.net/~rwhron/kernel/bigbox.html

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

