Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbTCTRQC>; Thu, 20 Mar 2003 12:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTCTRQC>; Thu, 20 Mar 2003 12:16:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5322 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261357AbTCTRQA>;
	Thu, 20 Mar 2003 12:16:00 -0500
Date: Thu, 20 Mar 2003 09:23:34 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-Id: <20030320092334.31ee2254.rddunlap@osdl.org>
In-Reply-To: <20030320163207.GH28454@lug-owl.de>
References: <3E78D0DE.307@zytor.com>
	<20030320163207.GH28454@lug-owl.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003 17:32:07 +0100 Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:

| However, please keep in mind that it's a *PITA* if you're working on a
| machine with not > 500MHz and > 128MB RAM:
| 
| jbglaw@schnarchnase:/tmp$ ls -l linux-2.5.65.tar.*
| -rw-r--r--    1 jbglaw   jbglaw   31889910 Mar 20 11:37
| linux-2.5.65.tar.bz2
| -rw-r--r--    1 jbglaw   jbglaw   39711645 Mar 20 11:44
| linux-2.5.65.tar.gz
| jbglaw@schnarchnase:/tmp$ time tar xjf linux-2.5.65.tar.bz2
| 
| real    194m21.665s
| user    172m55.026s
| sys     14m19.018s
| jbglaw@schnarchnase:/tmp$ mv linux-2.5.65 linux-2.5.65xx
| jbglaw@schnarchnase:/tmp$ time tar xzf linux-2.5.65.tar.gz
| 
| real    39m39.294s
| user    22m32.306s
| sys     13m56.524s
| jbglaw@schnarchnase:/tmp$ free
|              total       used       free     shared    buffers     cached
| Mem:         10100       9792        308          0        952       5232
...
| jbglaw@schnarchnase:/tmp$ cat /proc/cpuinfo 
...
| bogomips        : 15.10
| 
| jbglaw@schnarchnase:/tmp$ uname -a
| Linux schnarchnase 2.5.65 #1 Thu Mar 20 07:39:11 CET 2003 i486 unknown unknown GNU/Linux

What kind of processor/system is that?

I also see quite a difference in untarring gz vs. bz2.

On a Pentium classic with genuine f00f bug, 180 Mhz, 80 MB of RAM,
running Linux 2.5.64, I get:

[rddunlap@eeyore linsrc]$ time tar xzf linux-2.5.65.tar.gz
41.98user 38.15system 1:45.94elapsed 75%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (314major+97minor)pagefaults 0swaps
[rddunlap@eeyore linsrc]$ mv linux-2.5.65 linux-2565

[rddunlap@eeyore linsrc]$ time tar xjf linux-2.5.65.tar.bz2
243.99user 39.62system 5:29.39elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (324major+971minor)pagefaults 0swaps

--
~Randy
