Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVH3Eqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVH3Eqi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVH3Eqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:46:37 -0400
Received: from mail2.mx.voyager.net ([216.93.66.206]:32526 "EHLO
	mail2.mx.voyager.net") by vger.kernel.org with ESMTP
	id S932124AbVH3Eqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:46:37 -0400
Message-ID: <4313E4ED.BED1BFE6@megsinet.net>
Date: Mon, 29 Aug 2005 23:47:41 -0500
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.13 kernel OOPS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is this a known problem?

Thanks,
Martin


cat /proc/sys/net/ipv4/conf/lo/rp_filter

 <1>Unable to handle kernel paging request at virtual address 419a91d8
 printing eip:
c0116644
*pde = 00000000
Oops: 0000 [#6]
Modules linked in:
CPU:    0
EIP:    0060:[<c0116644>]    Not tainted VLI
EFLAGS: 00010246   (2.6.13)
EIP is at do_proc_dointvec_conv+0x14/0x40
eax: c1b40f28   ebx: 00000000   ecx: 419a91d8   edx: c1b40f24
esi: 00001000   edi: 00000001   ebp: 0804d008   esp: c1b40eec
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 503, threadinfo=c1b40000 task=c22245d0)
Stack: c0116731 00000000 00000000 00000000 419a91d8 00000001 00000000 c1b40fbc
       c22245d0 c1b656a4 00000000 00000000 00030002 c1b40f0b c2242b84 c1b656a4
       c1e12420 0804d008 00000000 c12910e0 c01169a5 0804d008 c1b40f64 c1b40fa4
Call Trace:
 [<c0116731>] do_proc_dointvec+0xc1/0x320
 [<c01169a5>] proc_dointvec+0x15/0x20
 [<c0116630>] do_proc_dointvec_conv+0x0/0x40
 [<c011637e>] do_rw_proc+0x6e/0x80
 [<c01163b0>] proc_readsys+0x0/0x20
 [<c01163c0>] proc_readsys+0x10/0x20
 [<c014415e>] vfs_read+0x7e/0x140
 [<c01444ac>] sys_read+0x3c/0x70
 [<c0102539>] syscall_call+0x7/0xb
Code: 00 00 83 c4 0c 89 c8 5b 5e 5f 5d c3 8d 74 26 00 8d bc 27 00 00 00 00 83 7c 24 04 00 74 0d 8b 00 85 c0 75 18 8b 02 89 01 31 c0 c3 <8b> 09 85 c9 78 16 c7 00 00 00 00 00 31 c0 89 0a c3 8b 02 f7 d8


bash-2.05$ /bld/linux-2.6.13/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux shadow 2.6.12 #1 SMP Sat Jun 18 09:36:33 CDT 2005 i686 unknown unknown GNU/Linux

Gnu C                  4.0.0
Gnu make               3.80
binutils               2.15
util-linux             2.12q
mount                  2.12q
module-init-tools      3.0-pre2
e2fsprogs              1.35
reiserfsprogs          reiserfsck:
reiser4progs           fsck.reiser4:
pcmcia-cs              3.2.8
nfs-utils              0.1.5
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      6.0.4
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   048
Modules Loaded
bash-2.05$
