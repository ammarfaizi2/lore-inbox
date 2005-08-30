Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVH3Iar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVH3Iar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVH3Iaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:30:46 -0400
Received: from aun.it.uu.se ([130.238.12.36]:3837 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751235AbVH3Iap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:30:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17172.6447.51367.822977@alkaid.it.uu.se>
Date: Tue, 30 Aug 2005 10:30:39 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 kernel OOPS
In-Reply-To: <4313E4ED.BED1BFE6@megsinet.net>
References: <4313E4ED.BED1BFE6@megsinet.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M.H.VanLeeuwen writes:
 > Hi,
 > 
 > Is this a known problem?
 > 
 > Thanks,
 > Martin
 > 
 > 
 > cat /proc/sys/net/ipv4/conf/lo/rp_filter
 > 
 >  <1>Unable to handle kernel paging request at virtual address 419a91d8
 >  printing eip:
 > c0116644
 > *pde = 00000000
 > Oops: 0000 [#6]
 > Modules linked in:
 > CPU:    0
 > EIP:    0060:[<c0116644>]    Not tainted VLI
 > EFLAGS: 00010246   (2.6.13)
 > EIP is at do_proc_dointvec_conv+0x14/0x40
 > eax: c1b40f28   ebx: 00000000   ecx: 419a91d8   edx: c1b40f24
 > esi: 00001000   edi: 00000001   ebp: 0804d008   esp: c1b40eec
 > ds: 007b   es: 007b   ss: 0068
 > Process cat (pid: 503, threadinfo=c1b40000 task=c22245d0)
 > Stack: c0116731 00000000 00000000 00000000 419a91d8 00000001 00000000 c1b40fbc
 >        c22245d0 c1b656a4 00000000 00000000 00030002 c1b40f0b c2242b84 c1b656a4
 >        c1e12420 0804d008 00000000 c12910e0 c01169a5 0804d008 c1b40f64 c1b40fa4
 > Call Trace:
 >  [<c0116731>] do_proc_dointvec+0xc1/0x320
 >  [<c01169a5>] proc_dointvec+0x15/0x20
 >  [<c0116630>] do_proc_dointvec_conv+0x0/0x40
 >  [<c011637e>] do_rw_proc+0x6e/0x80
 >  [<c01163b0>] proc_readsys+0x0/0x20
 >  [<c01163c0>] proc_readsys+0x10/0x20
 >  [<c014415e>] vfs_read+0x7e/0x140
 >  [<c01444ac>] sys_read+0x3c/0x70
 >  [<c0102539>] syscall_call+0x7/0xb
 > Code: 00 00 83 c4 0c 89 c8 5b 5e 5f 5d c3 8d 74 26 00 8d bc 27 00 00 00 00 83 7c 24 04 00 74 0d 8b 00 85 c0 75 18 8b 02 89 01 31 c0 c3 <8b> 09 85 c9 78 16 c7 00 00 00 00 00 31 c0 89 0a c3 8b 02 f7 d8
 > 
 > 
 > bash-2.05$ /bld/linux-2.6.13/scripts/ver_linux
 > If some fields are empty or look unusual you may have an old version.
 > Compare to the current minimal requirements in Documentation/Changes.
 > 
 > Linux shadow 2.6.12 #1 SMP Sat Jun 18 09:36:33 CDT 2005 i686 unknown unknown GNU/Linux
 > 
 > Gnu C                  4.0.0

Sure looks a lot like the old gcc-4.0.0 miscompilation bug.
Change to gcc-4.0.1 or gcc-3.4.4.
