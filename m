Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbTJJLR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 07:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTJJLR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 07:17:26 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:10403 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S262046AbTJJLRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 07:17:24 -0400
Subject: [2.6.0-test7] cpufreq longhaul trouble
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1065784536.2071.3.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Fri, 10 Oct 2003 13:15:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that longhaul support in 2.6.0-test7 is still not working
properly...:-(. 


longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v2 supported.
longhaul: Bogus values Min:0.000 Max:0.000. Voltage scaling disabled.
longhaul: MinMult=5.0x MaxMult=6.0x
longhaul: FSB: 0MHz Lowestspeed=0MHz Highestspeed=0MHz
------------[ cut here ]------------
kernel BUG at drivers/cpufreq/cpufreq_userspace.c:502!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c022b363>]    Not tainted
EFLAGS: 00010246
EIP is at cpufreq_governor_userspace+0xb3/0x1b0
eax: 00000000   ebx: 00000001   ecx: c13410a0   edx: 00000000
esi: cf53ae40   edi: 00000001   ebp: 00000000   esp: ccd63e64
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1898, threadinfo=ccd62000 task=cd3a4d80)
Stack: 00000001 cf53ae40 00000001 cf53ae40 c022a8b8 cf53ae40 00000001
00000000
       00000000 ccd63ee4 cf53ae40 c022ac1e cf53ae40 00000001 cf53ae64
ccd63ee4
       cf53ae40 cf53ae84 c022acb9 cf53ae40 ccd63ee4 cf53ae40 00000000
ccd62000
Call Trace:
 [<c022a8b8>] __cpufreq_governor+0x68/0x120
 [<c022ac1e>] __cpufreq_set_policy+0xde/0x140
 [<c022acb9>] cpufreq_set_policy+0x39/0x70
 [<c022a405>] cpufreq_add_dev+0x185/0x2a0
 [<c014d89c>] unmap_vm_area+0x2c/0x80
 [<c01d9253>] sysdev_driver_register+0x93/0x100
 [<c022af81>] cpufreq_register_driver+0x91/0xa0
 [<d082e4d4>] longhaul_init+0x54/0x56 [longhaul]
 [<c01366bd>] sys_init_module+0x10d/0x230
 [<c010b247>] syscall_call+0x7/0xb

Code: 0f 0b f6 01 80 7c 2a c0 eb 82 0f 0b f4 01 80 7c 2a c0 e9 6e

If more more details are needed, I'm happy to supply.

Cheers,

Jurgen

