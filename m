Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310660AbSCMPdm>; Wed, 13 Mar 2002 10:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310663AbSCMPdc>; Wed, 13 Mar 2002 10:33:32 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:24502 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S310660AbSCMPdU>; Wed, 13 Mar 2002 10:33:20 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 13 Mar 2002 07:33:10 -0800
Message-Id: <200203131533.HAA09497@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: IDE(?) lockups in 2.5.7pre1, 2.5.6, 2.5.6pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Under 2.5.6-pre3 and 2.5.6, my desktop workstation would
occasionally get into a state where all disk I/O would block.
Process would run until they had to go to the disk, and then they
would stop.  Hitting ctrl-<scroll lock> shows these process in "D"
state.  The IDE controller in this machine is:

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)

	I just built 2.5.7-pre1 and have discovered the other machne
that has a VIA IDE controller developed the same problem just after
printing its first "login: " prompt, although it did not have the problem
on a subsequent reboot.  This other machine did not lock up with
2.5.6-pre3 or 2.5.6, although that is probably just due to random
chance, as the problem was occurring only once a day.  The
IDE controller in this second machine is:

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)

	I will try to track this down from the process stack traces
when it happens next, but I thought I ought to report it in the meantime.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
