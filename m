Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTEEP7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 11:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTEEP7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 11:59:08 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:10188 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262444AbTEEP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 11:59:07 -0400
Subject: 2.5.69-mm1 OOPS: modprobe usbcore
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1052151088.1052.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 05 May 2003 18:11:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*pde = 00102027
*pte = 00324000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0110a5d>]    Not tainted VLI
EFLAGS: 00010202
EIP is at apply_alternatives+0xc1/0xf4
eax: 00000001   ebx: e084b5f4   ecx: 00000000   edx: 00000001
esi: c0324b1f   edi: e0838606   ebp: df9f3ee4   esp: df9f3ed0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 62, threadinfo=df9f2000 task=dfdb8e00)
Stack: c02c3b40 00000003 e082b2d4 c029a861 e082b021 df9f3f04 c0118ab8
e084b5f4
       e084b68f e082af7d e0816000 e0851e80 00000500 df9f3f8c c013de18
e0816000
       e082b0a4 e0851e80 0000001b e0851e80 4001e004 c163619c 00000000
00000528
Call Trace:
[<c0118ab8>] module_finalize+0x7f/0x8b
[<c013de18>] load_module+0x61c/0x821
[<c013e0b1>] sys_init_module+0x94/0x340
[<c0109e01>] sysenter_past_esp+0x52/0x71

Code: 85 d2 7e 31 83 fa 09 b8 08 00 00 00 8b 4d ec 0f 4c c2 8b 7d f0 8b
34 81 03
3b 89 c1 c1 e9 02 f3 a5 a8 02 74 02 66 a5 a8 01 74 01 <a4> a9 c2 01 45
f0 85 d2
7f cf 83 c3 0c 3b 5d 0c 72 82 83 c4 08

This error is reproducble 100% of the time when trying to boot Red Hat
Linux 9 with a 2.5.69-mm1 kernel. Config attached.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

