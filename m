Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbTJIO4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTJIO4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:56:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262243AbTJIO4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:56:37 -0400
Date: Thu, 9 Oct 2003 10:56:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: mmap strangeness in 2.4.22
Message-ID: <Pine.LNX.4.53.0310091055470.1274@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a shared memory segment called 0xdeadface,
shown below.

When active, readable, writable, etc., it shows up
in /proc/NNN/maps as (deleted). How/why would this
be?

Also, `cat mem` in any /proc/NNN subdirectory returns
"No such process" when `cat` tries to read it.


Output from cat /proc/MYPID/maps:

08048000-0804b000 r-xp 00000000 08:11 457876     /root/Message-Based/monitor/monitor
0804b000-0804c000 rw-p 00002000 08:11 457876     /root/Message-Based/monitor/monitor
0804c000-08075000 rwxp 00000000 00:00 0
40000000-40013000 r-xp 00000000 08:11 393742     /root/Message-Based/clib/ld.so
40013000-40014000 rw-p 00012000 08:11 393742     /root/Message-Based/clib/ld.so
40014000-40015000 rw-p 00000000 00:00 0
40015000-4001c000 r-xp 00000000 08:11 964822     /root/Message-Based/lib/llib.so
4001c000-4001d000 rw-p 00006000 08:11 964822     /root/Message-Based/lib/llib.so
4001d000-40030000 r-xp 00000000 08:11 394079     /root/Message-Based/clib/crt.so
40030000-40031000 rw-p 00012000 08:11 394079     /root/Message-Based/clib/crt.so
40031000-400d2000 rw-s 00000000 00:04 0          /SYSVdeadface (deleted)
bfffe000-c0000000 rwxp fffff000 00:00 0

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


