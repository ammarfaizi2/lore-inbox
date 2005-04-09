Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVDIOmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVDIOmc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 10:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVDIOmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 10:42:31 -0400
Received: from taco.zianet.com ([216.234.192.159]:17423 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261347AbVDIOm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 10:42:27 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.12-rc2 oops PREEMPT DEBUG_PAGEALLOC sysenter_past_esp+0x3/0x75
Date: Sat, 9 Apr 2005 08:38:56 -0600
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200504090838.56671.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got around to booting 2.6.12-rc2 here at home last night, and got several (12) oops.
Here is a typical one.  They all have the same trace, but occured on differing processes.

[18008.409586]  <1>Unable to handle kernel paging request at virtual address c2166000
[24538.187178]  printing eip:
[24538.187188] c0102b5c
[24538.187195] *pde = 00007067
[24538.187203] *pte = 02166000
[24538.187214] Oops: 0000 [#4]
[24538.187220] PREEMPT DEBUG_PAGEALLOC
[24538.187239] CPU:    0
[24538.187244] EIP:    0060:[<c0102b5c>]    Not tainted VLI
[24538.187251] EFLAGS: 00010046   (2.6.12-rc2)
[24538.187274] EIP is at restore_all+0x4/0x18
[24538.187286] eax: 00000282   ebx: 00000006   ecx: 00000000   edx: 00000001
[24538.187302] esi: 081530d8   edi: 0817f428   ebp: c2164000   esp: c2165fc8
[24538.187315] ds: 007b   es: 007b   ss: 0068
[24538.187328] Process kppp (pid: 7305, threadinfo=c2164000 task=cb69db10)
[24538.187338] Stack: 00000006 0000541b bfb6d950 081530d8 0817f428 bfb6d928 00000036 c010007b
[24538.187366]        0000007b ffffff00 c0102a9a 00000060 00000282 0000007b
[24538.187387] Call Trace:
[24538.187396]  [<c0102a9a>] sysenter_past_esp+0x3/0x75

Prior to that, I'd been running 2.6.12-rc1 without these problems.

Apologies in advance if I don't respond for additional information right
away.  I'll be away from the computer for a while today.

Anticipating one question:

[steven@spc testing-2.6]$ grep PREEMPT .config
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
# CONFIG_DEBUG_PREEMPT is not set

Steven
