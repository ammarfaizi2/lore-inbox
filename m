Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263409AbTECTjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 15:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbTECTjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 15:39:46 -0400
Received: from port-212-202-172-137.reverse.qdsl-home.de ([212.202.172.137]:38812
	"EHLO jackson.localnet") by vger.kernel.org with ESMTP
	id S263409AbTECTjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 15:39:45 -0400
Date: Sat, 03 May 2003 21:55:34 +0200 (CEST)
Message-Id: <20030503.215534.846937682.rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc1 VM swaps out too much
From: Rene Rebe <rene.rebe@gmx.net>
X-Mailer: Mew version 3.1 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C36k-0002Kl-KX*o0Bu/bLsuUQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

somewhere in the 2.4.21-xx series (currently running -rc1 here) seems
to be a VM regression, that results in quite hefty swap-outs. The box
is an Athlon-XP with 512MB RAM, running batched gcc jobs (distribution
builds taking three days and more...). But the box is used a normal
workstation, too. My normal desktop programs constantly need to get
swapped-in - quite annoying. This only start to happen after an uptime
of a day.

So the CPU:

vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) 4 Processor
stepping        : 2
cpu MHz         : 1460.481
cache size      : 256 KB

$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  527351808 519213056  8138752        0 88793088 328437760
Swap: 537214976 184963072 352251904
MemTotal:       514992 kB
MemFree:          7948 kB
MemShared:           0 kB
Buffers:         86712 kB
Cached:         252328 kB
SwapCached:      68412 kB
Active:         276828 kB
Inactive:       177468 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514992 kB
LowFree:          7948 kB
SwapTotal:      524624 kB
SwapFree:       343996 kB

$ uptime
 21:52:41 up 4 days, 23:55,  4 users,  load average: 2.14, 2.47, 2.32

$ cat /proc/version
Linux version 2.4.21-rc1 (root@jackson) (gcc version 3.2.2) #1 Mon Apr 28 00:36:17 CEST 2003

More data available on request.

- René

--  
René Rebe - Europe/Germany/Berlin
e-mail:   rene@rocklinux.org, rene.rebe@gmx.net
web:      http://www.rocklinux.org/people/rene http://gsmp.tfh-berlin.de/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
