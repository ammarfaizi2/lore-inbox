Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUCCKod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUCCKoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:44:32 -0500
Received: from [216.157.225.68] ([216.157.225.68]:24219 "EHLO
	lnxsrv0006.server01.newbreak.com") by vger.kernel.org with ESMTP
	id S262429AbUCCKoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:44:20 -0500
Subject: Bug report
From: Manivannan Shanmugam <manivannan@newbreak.com>
Reply-To: manivannan@newbreak.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: NewBreak India Pvt Ltd
Message-Id: <1078310837.3192.3.camel@linux0014>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 03 Mar 2004 16:17:18 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Please find here the bug report and inform us what this is and how can
we avoid this in future. We are facing difficulties with this.

Thanks.
S.Manivannan



_________________________________________________________________________________

kernel BUG at filemap.c:892!
invalid operand: 0000
nfs lockd sunrpc autofs 8139too mii ext3 jbd
CPU:    1
EIP:    0010:[unlock_page+70/112]    Not tainted
EIP:    0010:[<c0130506>]    Not tainted
EFLAGS: 00010246

EIP is at unlock_page [kernel] 0x46 (2.4.20-13.7smp)
eax: c1bbe278   ebx: c030bca0   ecx: 0000001c   edx: 00000000
esi: c1dffd54   edi: 00000000   ebp: f7402f80   esp: f76f3ef0
 ds: 0018   es: 0018   ss: 0018
Process rpciod (pid: 969, stackpage=f76f3000)
Stack: 00001000 c1bbe278 f88ec7ae f76f2000 f7402f80 f75a0380 00000046
00000000
       f759c000 f759c050 f75a7a0c 00000000 f75a0380 f88f2300 f88f2332
f736ba88
       f75a0430 d7a19774 f75a0380 f736ba74 00000001 f75a0380 f75a0424
f75a0380
Call Trace:   [<f88ec7ae>] nfs_readpage_result [nfs] 0x20e (0xf76f3ef8))
[<f88f2300>] nfs3_xdr_readres [nfs] 0x0 (0xf76f3f24))
[<f88f2332>] nfs3_xdr_readres [nfs] 0x32 (0xf76f3f28))
[<f88f2300>] nfs3_xdr_readres [nfs] 0x0 (0xf76f3f50))
[<f88bff73>] call_decode [sunrpc] 0x133 (0xf76f3f58))
[<f88c357d>] __rpc_execute [sunrpc] 0x27d (0xf76f3f78))
[do_softirq+107/208] do_softirq [kernel] 0x6b (0xf76f3f90))
[<c012107b>] do_softirq [kernel] 0x6b (0xf76f3f90))
[<f88c3742>] __rpc_schedule [sunrpc] 0xd2 (0xf76f3fb4))
[<f88c4069>] rpciod [sunrpc] 0xe9 (0xf76f3fc8))
[<f88d2128>] rpciod_killer [sunrpc] 0x0 (0xf76f3fcc))
[arch_kernel_thread+38/48] arch_kernel_thread [kernel] 0x26
(0xf76f3ff0))
[<c0107266>] arch_kernel_thread [kernel] 0x26 (0xf76f3ff0))
[<f88d2128>] rpciod_killer [sunrpc] 0x0 (0xf76f3ff4))
[<f88c3f80>] rpciod [sunrpc] 0x0 (0xf76f3ff8))


Code: 0f 0b 7c 03 50 53 25 c0 8d 46 04 39 46 04 74 10 5b 89 f0 31
	
_________________________________________________________________________________

