Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTIKLnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 07:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbTIKLnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 07:43:06 -0400
Received: from home.wiggy.net ([213.84.101.140]:15232 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261254AbTIKLm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 07:42:57 -0400
Date: Thu, 11 Sep 2003 13:42:27 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: oops in inet_bind/tcp_v4_get_port
Message-ID: <20030911114212.GA1888@wiggy.net>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just had a kernel oops while restarting exim4. A hand-copied oops
report is below. This is using kernel 2.6.0-test3 on a UP box without
preempt after about a month of uptime. 

Wichert.

*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c029cde6>]    Not tainted
EFLAGS: 00010246
EIP is at tcp_v4_get_port+0x296/0x2b0
eax: 00000000  ebx: dec3d740  ecx: c18ed860   edx: c18ed870
esi: 00000019  edi: 00000000  ebp: dfcc0064   esp: ddb07e70
ds: 007b   es: 007b   ss: 0068
Process exim4 (pid: 14228, threadinfo=ddb600 task=ddb1b300)
Stack: 00000000 00000000 00000000 00000000 c18ed860 00000000 00000000 00000001
       ddc8f508 00000000 00000246 00000001 ddc8f3e0 ffffffea ddc8f508 00000019
       c02adbac ddc8f3e0 00000019 ddb07ee8 00000002 ddaa99a0 ddb07ee8 00000010
Call Trace:
 [<c02adbac>] inet_bind+0x17c/0x230
 [<c025f24b>] sys_bind+0x7b/0xb0
 [<c011551c>] do_page_fault+0x12c/0x469
 [<c025f938>] sys_setsockopt+0x78/0xc0
 [<c026001b>] sys_socketcall+0xbb/0x2a0
 [>c010901f>] syscall_call+0x7/0xb

Code: 0f b6 40 49 24 20 84 c0 75 9c eb 8a 8d b4 26 00 00 00 00 8d
  <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

