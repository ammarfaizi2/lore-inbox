Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVEPVMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVEPVMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVEPVJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:09:53 -0400
Received: from dvhart.com ([64.146.134.43]:58017 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261881AbVEPVEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:04:44 -0400
Date: Mon, 16 May 2005 14:04:41 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc4-mm2 boot failure
Message-ID: <735450000.1116277481@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PPC64 NUMA box. Maybe this is the same NUMA slab problem you were 
hitting before ...

Oops: Exception in kernel mode, sig: 5 [#1]^M
SMP NR_CPUS=32 NUMA PSERIES LPAR ^M
Modules linked in:^M
NIP: C000000000099624 XER: 00000000 LR: C00000000009A014 CTR: C00000000028C0D4^M
REGS: c00000000057ba10 TRAP: 0700   Not tainted  (2.6.12-rc4-mm2-autokern1)^M
MSR: 8000000000029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 24004022^M
DAR: 8000000000009032 DSISR: c0000000006c82bf^M
TASK: c0000000005e2100[0] 'swapper' THREAD: c000000000578000 CPU: 0^M
GPR00: 0000000000000001 C00000000057BC90 C0000000006C0568 C00000077FFD2590 ^M
GPR04: 0000000000000000 FFFFFFFFFFFFFFFF C0000000006C83D0 C0000000005E3A24 ^M
GPR08: C0000000005E3A18 0000000000000000 C0000000006C83C8 C0000000006C82E8 ^M
GPR12: 000000000000000A C0000000005CD000 0000000000000000 0000000000000000 ^M
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 ^M
GPR20: 0000000000230000 0000000003A10000 0000000000000060 0000000003F143C8 ^M
GPR24: C0000000005CD000 C0000000006BE208 C000000000577D68 0000000000008000 ^M
GPR28: 0000000000000000 00000000000080D0 C0000000005E2100 0000000000000001 ^M
NIP [c000000000099624] .interleave_nodes+0x38/0xd0^M
LR [c00000000009a014] .alloc_pages_current+0x100/0x134^M
Call Trace:^M
[c00000000057bc90] [000000000000001d] 0x1d (unreliable)^M
[c00000000057bd20] [c00000000009a014] .alloc_pages_current+0x100/0x134^M
[c00000000057bdc0] [c00000000007abd4] .get_zeroed_page+0x28/0x90^M
[c00000000057be40] [c0000000004e2e68] .pidmap_init+0x24/0xa0^M
[c00000000057bed0] [c0000000004c7734] .start_kernel+0x21c/0x30c^M
[c00000000057bf90] [c00000000000c010] .__setup_cpu_power3+0x0/0x4^M
Instruction dump:^M
fba1ffe8 fbc1fff0 f8010010 f821ff71 60000000 ebcd0160 a93e0788 793f0020 ^M
7fe9fe70 7d20fa78 7c004850 54000ffe <0b000000> 3ba30010 38bf0001 38800001 ^M
 <0>Kernel panic - not syncing: Attempted to kill the idle task!^M

