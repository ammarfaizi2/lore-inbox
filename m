Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289776AbSA2Ra5>; Tue, 29 Jan 2002 12:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289783AbSA2Raj>; Tue, 29 Jan 2002 12:30:39 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:47630 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S289779AbSA2Ra0>;
	Tue, 29 Jan 2002 12:30:26 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15446.56358.694775.675717@abasin.nj.nec.com>
Date: Tue, 29 Jan 2002 12:30:14 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 Oops on raidstart
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My vanilla 2.4.17 kernel was oopsing during boot, even into single
user mode.  As I have been having raid issues recently I suspected the
RAID first.  So, I booted from a rescue disk, removed mounted raid
partitions from /etc/fstab (all of which are reiserfs), and moved my
raidtab file out of the way.

During normal reboot, no oops.  I copied my raidtab file back and
issued the raidstart command on md0.  A rebuild starts on my md0 and a
few minutes later I got the included oops.  This is a RAID5 partition
that has given me no problems until now.

Oops: 0002
CPU:    1
EIP:    0010:[<c0111f34>]    Not tainted
EFLAGS: 00010086
eax: ffffd000   ebx: c024ba78   ecx: 00000024   edx: 00001000
esi: ffffe010   edi: ffffe000   ebp: c028dcb0   esp: c181deb8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c18d000)
Stack: 00000002 00000002 c017e26c c01120d3 0000000a 00000140 c0108681 0000000a
       c028de14 c1848e80 c017f6d2 0000000a c1848e80 c017f5f0 00000000 c0263f00
       00000282 c011e5d6 c1848e80 00000000 00000020 00000000 c026ef00 00000086
Call Trace: [<c017e26c>] [<c01120d3>] [<c0108681>] [<c017f6d2>] [<c017f5f0>]
   [<c011e5f6>] [<c011ad9e>] [<c011ac7d>] [<c011aa1f>] [<c010883d>] [<c01053c0>]
   [<c01053c0>] [<c010a818>] [<c01053c0>] [<c01053c0>] [<c01053ec>] [<c0105452>]
   [<c0116e2e>] [<c0116d3f>]

Code: 89 08 89 f0 29 d0 8b 13 8b 08 42 c1 e2 0c 89 f0 29 d0 81 c9
 <0>Kernel panic: Aiee, killing interrupted handler!
In interrupt handler - no syncing
