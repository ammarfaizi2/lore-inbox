Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRDTVB2>; Fri, 20 Apr 2001 17:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRDTVBS>; Fri, 20 Apr 2001 17:01:18 -0400
Received: from www.chieflandrelayforlife.com ([204.157.225.180]:38785 "EHLO
	mail.co.gilchrist.fl.us") by vger.kernel.org with ESMTP
	id <S131730AbRDTVBH>; Fri, 20 Apr 2001 17:01:07 -0400
Date: Fri, 20 Apr 2001 17:01:05 -0400 (EDT)
From: <lkern@mail.co.gilchrist.fl.us>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic Linux 2.4.3 RH7
Message-ID: <Pine.LNX.4.21.0104201647250.1287-100000@proxy.co.gilchrist.fl.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine has been locking up between 0-3 times a day
sporadically.  Nothing predictable about it. Hadn't locked up for 3
days, and locked 3x today, the last 2 times within 20 minutes of each 
other. Had run stable with 2.2.18, and was running fairly stable on 2.4.3
up until about last week.  (might be coincidence, or not, but seems to
happen when I am on IRC -- DOS?, nothing in log files or firewall logs
however)

Machine info:

RedHat 7, Intel Celeron 450, 256Meg ECC PC100 DRAM, 1 15G IDE (/usr, /tmp,
/home,
/var, swap ), 1 2G SCSI (/, /boot, swap) HDD, 2 identical tulip chipset
eth cards.

I just swapped the RAM out this last crash, seeing if that makes any
differences.

Kernel is configured as advanced router with packet filtering, ip
firewalling, NAT, IPTABLES and others enabled running a fairly
comprehensive iptables ruleset, nothing superhuge though.


Machine was recently upgraded to 2.4.3 kernel, from 2.2.18.
Dump message is partially as follows:

Mismatch in TCPACCEPT IN=ETH0 OUT= MAC= 00:00:e8:24:53

(some other stuff below this, but the machine then rolled to the below and
I couldn't finish copying down the above, remainder is as follows:

Kernel Panic:  Attempted to Kill init!
Unable to handle kernel paging request at virtual address e030a40c

printing eip:
c01194ae
*pid=00000000
Oops: 0000
CPU: 0
Eip: 0010 [<c01194ae7>]
EFLAGS: 0010087

(stack information skipped, if you need it let me know and I will write it
all down the next time)

Process: swapper (pid0, stack page c02dl000)

stack 00000000

Code 8b1186108b 590c85d274 088b410489 42048910

Kernel Panic: Aiee, killing interrupt handler
In interrupt handler - not syncing

Any ideas?

-buddy ellis


