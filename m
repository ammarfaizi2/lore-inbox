Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315530AbSENJAu>; Tue, 14 May 2002 05:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315535AbSENJAt>; Tue, 14 May 2002 05:00:49 -0400
Received: from twtpems2.wistron.com.tw ([210.63.109.157]:2323 "EHLO
	twtpems2.wistron.mailsweeper") by vger.kernel.org with ESMTP
	id <S315536AbSENJAs>; Tue, 14 May 2002 05:00:48 -0400
X-Lotus-FromDomain: WISTRON
From: jerry_ch_lee@wistron.com.tw
To: linux-kernel@vger.kernel.org
Message-ID: <48256BB9.0031F2ED.00@TWTPEDS1.WISTRON.COM.TW>
Date: Tue, 14 May 2002 17:02:25 +0800
Subject: ide revalidate problem
Mime-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello:

When I try to add IDE in /proc, it did the following thing:
ide_register_hw -> ide_revalidate -> grok_partitions -> msdos_partition ->
read_dev_sector -> sync_page -> __run_task_queue

When it tried to do f(data) in kernel/softirq.c in __run_task_queue,
error happens:
Unable to handle NULL pointer dereference at address 0x0000000
...

It's in the tq_struct, but what situation will cause this?

Thanks,

Jerry


