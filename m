Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267653AbTAXNtt>; Fri, 24 Jan 2003 08:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267655AbTAXNtt>; Fri, 24 Jan 2003 08:49:49 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:57093 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267653AbTAXNts>; Fri, 24 Jan 2003 08:49:48 -0500
Message-ID: <3E3146BC.4D0A1A64@aitel.hist.no>
Date: Fri, 24 Jan 2003 14:59:24 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm5 got stuck during boot
References: <20030123195044.47c51d39.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> .  -mm5 has the first cut of Nick Piggin's anticipatory I/O scheduler.

Interesting, but it didn't boot completely.
It came all the way to mount root from /dev/md0  (dirty raid1)
freed 316k of kernel memory, and then nothing happened.
numloc and capslock worked, and so did sysrq.
It was as if the kernel "forgot" to run init.
Nothing happened, but it wasn't hanging either.

sysrq "show pc" told me something about default idle.
I noticed that the root raid-1 came up dirty. (2.5.X
seems unable to shut down a raid-1 device "clean" if
it  happens to be the root fs.  So there's _always_
a bootup resync that starts as soon as the raid
is autodetected. (Before mounting root)


This is a UP P4, preempt, no module support,
compiled with gcc 2.95.4 from debian.

Stock 2.5.59 works, the only config change is to enable
that new CONFIG_HANGCHECK_TIMER.  

Helge Hafting
