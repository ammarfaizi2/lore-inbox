Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUJAPm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUJAPm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUJAPm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:42:59 -0400
Received: from [142.176.159.6] ([142.176.159.6]:59869 "EHLO smtp.amirix.com")
	by vger.kernel.org with ESMTP id S264503AbUJAPkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:40:52 -0400
Message-ID: <415D7A73.6060205@amirix.com>
Date: Fri, 01 Oct 2004 12:40:35 -0300
From: Frank Smith <frank.smith@amirix.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Frank Smith <frank.smith@amirix.com>
Subject: __d_lookup in 2.6.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Are there any known issues with fs/dcache in kernel 2.6.6 that
would cause oopses like the following in __d_lookup to happen
occasionally?  I've done lots of googling on this, and it appears
that there is a lot of flux in this code, so I'm wondering how
solid fs/dcache is in 2.6.6.

This is on a 74xx PPC board, using an NFS root filesystem.

-Frank.

---------
Oops: kernel access of bad area, sig: 11 [#2]
PREEMPT
NIP: C007FD68 LR: C0074694 SP: CE4E7E10 REGS: ce4e7d60 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 2CC7FFFE, DSISR: 40000000
TASK = cfb92740[494] 'split-include' THREAD: ce4e6000Last syscall: 5
GPR00: 00001008 CE4E7E10 CFB92740 CDE8B4CC CE4E7ED8 00000000 00000004 CE4E6000
GPR08: CFF80000 C0290000 00000001 000132F4 24000428
NIP [c007fd68] __d_lookup+0x80/0x1c8
LR [c0074694] __lookup_hash+0x88/0x174
Call trace:
  [c0074694] __lookup_hash+0x88/0x174
  [c0074f7c] open_namei+0x160/0x4b0
  [c0061044] filp_open+0x3c/0x84
  [c0061438] sys_open+0x6c/0xbc
  [c0006740] ret_from_syscall+0x0/0x44

