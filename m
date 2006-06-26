Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWFZQ7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWFZQ7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWFZQ6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:58:55 -0400
Received: from narn.hozed.org ([209.234.73.39]:31616 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S1750925AbWFZQ6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:58:48 -0400
Date: Mon, 26 Jun 2006 11:58:47 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Subject: kAFS crash
Message-ID: <20060626165843.GA5860@narn.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, so much for me thinking the kernel afs client would be more stable
than openafs ;)

This is on the debian 2.6.15-1-powerpc-smp kernel package.

Oops: kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=4
NIP: C0237A34 LR: D9268248 SP: D5679F50 REGS: d5679ea0 TRAP: 0300   Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000070, DSISR: 04000000
TASK = c5269230[10217] 'kafscmd' THREAD: d5678000
Last syscall: -1  CPU: 1
GPR00: 00000001 D5679F50 C5269230 00000070 00009032 00000000 0000B817 00000000
GPR08: D5679FD4 00000000 D5686140 C0237A20 EC51E6F5 1002A544 00000000 100243F0
GPR16: 100243D0 00000000 00000000 100243C0 00000000 10020000 00000000 C0310000
GPR24: C1BCDDD0 00000070 C924A000 00000000 D927A0A8 D5679F58 D9280000 00000000
NIP [c0237a34] __lock_text_start+0x14/0x30
LR [d9268248] SRXAFSCM_InitCallBackState+0x2c/0x130 [kafs]
Call trace:
 [d926992c] _SRXAFSCM_InitCallBackState+0x90/0x150 [kafs]
 [d92690d4] kafscmd+0x170/0x190 [kafs]
 [c0007818] kernel_thread+0x44/0x60

