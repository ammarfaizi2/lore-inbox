Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWEIA4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWEIA4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 20:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWEIA4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 20:56:50 -0400
Received: from smtp2.Stanford.EDU ([171.67.20.25]:5513 "EHLO
	smtp2.stanford.edu") by vger.kernel.org with ESMTP id S1751060AbWEIA4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 20:56:50 -0400
Subject: 2.6.16-rt17, hang with skge network driver
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Mon, 08 May 2006 17:56:48 -0700
Message-Id: <1147136208.5758.3.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, I've seen a few hangs with 2.6.16-rt17 - my feeling was that
they had to do with high network load - and this time something was left
behind after the reboot (I have to set up a serial console, it is not
happening very frequently). Most probably this does not say much but
here it goes anyway:

May  8 17:46:14 cmn3 kernel: softirq-net-tx//16[CPU#1]: BUG in
dma_map_single at include/asm/dma-mapping.h:26
May  8 17:46:14 cmn3 kernel:  [<c0123b95>] __WARN_ON+0x42/0x55 (8)
May  8 17:46:14 cmn3 kernel:  [<c01282d3>] ksoftirqd+0x0/0x188 (44)
May  8 17:46:14 cmn3 kernel:  [<f88ec916>] skge_xmit_frame+0xe9/0x2bc
[skge] (4)
May  8 17:46:14 cmn3 kernel:  [<c01282d3>] ksoftirqd+0x0/0x188 (56)
May  8 17:46:14 cmn3 kernel:  [<c02ad1f4>] qdisc_restart+0x92/0x1f0 (4)
May  8 17:46:14 cmn3 kernel:  [<c01282d3>] ksoftirqd+0x0/0x188 (20)
May  8 17:46:14 cmn3 kernel:  [<c029f357>] net_tx_action+0x9a/0xb3 (4)
May  8 17:46:14 cmn3 kernel:  [<c01283ac>] ksoftirqd+0xd9/0x188 (16)
May  8 17:46:14 cmn3 kernel:  [<c0134495>] kthread+0x9d/0xcc (20)
May  8 17:46:14 cmn3 kernel:  [<c01343f8>] kthread+0x0/0xcc (12)
May  8 17:46:14 cmn3 kernel:  [<c0102005>] kernel_thread_helper+0x5/0xb
(16)
May  8 17:48:33 cmn3 syslogd 1.4.1: restart.

-- Fernando


