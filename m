Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265158AbUFBWpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbUFBWpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 18:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUFBWpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 18:45:21 -0400
Received: from server2.netdiscount.de ([217.13.198.2]:45509 "EHLO
	server2.netdiscount.de") by vger.kernel.org with ESMTP
	id S265158AbUFBWpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:45:13 -0400
Date: Thu, 3 Jun 2004 00:45:01 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
Subject: nfsd oops in 2.6.7-rc1
Message-ID: <20040602224501.GA14994@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.7-rc1 on 4x opteron with very low nfs load, after this nfs stopped
working and didn't unload


Kernel BUG at nfsfh:276
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in: nfsd exportfs nls_iso8859_1 raw iptable_mangle
iptable_nat ip_conntrack iptable_filter ip_tables ip6table_filter
ip6_tables joydev st sr_mod floppy autofs usbserial parport_pc lp
parport thermal processor fan button battery ac ipv6 af_packet mptscsih
usbcore tg3 mptbase hw_random evdev binfmt_misc dm_mod
Pid: 14415, comm: nfsd Not tainted 2.6.7-rc1
RIP: 0010:[<ffffffffa016d76c>] <ffffffffa016d76c>{:nfsd:fh_compose+412}
RSP: 0018:00000100dcd69d88  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000100df412000 RCX: 00000100db71a000
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 00000100df412000
RBP: 00000100b6578db0 R08: 00000100dcd69c98 R09: 0000000000000000
R10: 00000100dcd69cf8 R11: 0000000000000048 R12: 0000000000800002
R13: 00000100bac5c168 R14: 00000100db71a000 R15: 00000100b5493990
FS:  0000002a9588d6e0(0000) GS:ffffffff80566080(0000) knlGS:000000000a1af280
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000f78338 CR3: 0000000000101000 CR4: 00000000000006e0
Process nfsd (pid: 14415, threadinfo 00000100dcd68000, task
00000100dae416b0)
Stack: 00000100dcd69dd8 00000100b5489978 00000100b5493990 00000100dfc320f8
       00000100b5493900 00000100db71a000 0000000000000007 0000010001e798ac
       0000010080ecd400 0000000000000000
Call Trace:<ffffffffa01716c4>{:nfsd:nfsd_lookup+1060}
<ffffffff803b80a4>{svc_udp_recvfrom+308}
       <ffffffffa016d1a4>{:nfsd:nfsd_proc_lookup+132}
<ffffffffa016b120>{:nfsd:nfsd_dispatch+256}
       <ffffffff803b6a23>{svc_process+947} <ffffffffa016b450>{:nfsd:nfsd+0}
       <ffffffffa016b695>{:nfsd:nfsd+581}
<ffffffff80134f8e>{schedule_tail+14}
       <ffffffff80111377>{child_rip+8} <ffffffffa016b450>{:nfsd:nfsd+0}
       <ffffffffa016b450>{:nfsd:nfsd+0} <ffffffff8011136f>{child_rip+0}

Code: 0f 0b 03 6e 18 a0 ff ff ff ff 14 01 f0 ff 45 00 48 89 ab 88
RIP <ffffffffa016d76c>{:nfsd:fh_compose+412} RSP <00000100dcd69d88>


Regards
Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
