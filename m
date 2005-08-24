Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVHXQCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVHXQCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVHXQCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:02:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6815 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751093AbVHXQCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:02:10 -0400
Subject: CFQ + 2.6.13-rc4-RT-V0.7.52-02 = BUG: scheduling with irqs disabled
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 12:02:08 -0400
Message-Id: <1124899329.3855.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just found this in dmesg.

BUG: scheduling with irqs disabled: libc6.postinst/0x20000000/13229
caller is ___down_mutex+0xe9/0x1a0
 [<c029c1f9>] schedule+0x59/0xf0 (8)
 [<c029ced9>] ___down_mutex+0xe9/0x1a0 (28)
 [<c0221832>] cfq_exit_single_io_context+0x22/0xa0 (84)
 [<c02218ea>] cfq_exit_io_context+0x3a/0x50 (16)
 [<c021db84>] exit_io_context+0x64/0x70 (16)
 [<c011efda>] do_exit+0x5a/0x3e0 (20)
 [<c011f3ca>] do_group_exit+0x2a/0xb0 (24)
 [<c0103039>] syscall_call+0x7/0xb (20)

Lee

