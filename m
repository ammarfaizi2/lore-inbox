Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277398AbRJJUIp>; Wed, 10 Oct 2001 16:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277397AbRJJUIg>; Wed, 10 Oct 2001 16:08:36 -0400
Received: from freeside.toyota.com ([63.87.74.7]:1290 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S277394AbRJJUIc>;
	Wed, 10 Oct 2001 16:08:32 -0400
Message-ID: <3BC4AACA.F7380F94@lexus.com>
Date: Wed, 10 Oct 2001 13:08:42 -0700
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.11-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.11 BUG vs 2.4.10-ac 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings -

I have had but little time to pursue the problems I reported
earlier, but I can provide some additional data points in the
hope that they may be of use here -

To recap, the system is a Compaq 6500 with 4 CPUs and 1.2
GB RAM.

Previously I reported that 2.4.11-pre kernels can all be reliably
made to lock hard within seconds, just by starting a dbench run.

I also reported that redhat roswell and rawhide kernels are solid
in this test, as is 2.4.10-ac6.

I have tested 2.4.11 final on this system, and sadly I must report
that it locks up hard within seconds of starting "dbench 16", and
although I booted Linux with verbose debugging and nmi_watchdog,
the oops scrolled by too quickly to catch, and as the system then
played possum, the PGUP, PGDN keys could not be used to scroll back
and inspect the oops, and the Magic SysRq keys also had no effect,
so I had to power cycle the box to revive it.

Just to confirm a hunch, I recompiled 2.4.11 with highmem support
disabled (So, it sees just under 1 GB RAM, no major loss), and
reran the dbench tests, with complete success - even with the load
up over 80 for an extended period of time, it would not fall over.

In short, it looks like a highmem bug, which is NOT in -ac.

cu,

jjs


