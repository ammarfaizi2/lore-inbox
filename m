Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTFTIyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 04:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTFTIyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 04:54:25 -0400
Received: from attila.bofh.it ([213.92.8.2]:29642 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S262470AbTFTIyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 04:54:24 -0400
Date: Fri, 20 Jun 2003 10:46:57 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: 2.5.72 Badness in local_bh_enable at kernel/softirq.c:109
Message-ID: <20030620084657.GA536@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This appears to be reproducible and happened when trying to run the
PPPoE daemon on a non-existent ethernet interface.

kernel: Badness in local_bh_enable at kernel/softirq.c:109
kernel: Call Trace:
kernel:  [<c011c6cc>] local_bh_enable+0x6c/0x70
kernel:  [<e0867b71>] ppp_async_push+0x91/0x160 [ppp_async]
kernel:  [<e08674dd>] ppp_asynctty_wakeup+0x2d/0x60 [ppp_async]
kernel:  [<c01ee164>] pty_unthrottle+0x54/0x60
kernel:  [<c01eaffb>] check_unthrottle+0x3b/0x40
kernel:  [<c01eb074>] n_tty_flush_buffer+0x14/0x60
kernel:  [<c01ee4df>] pty_flush_buffer+0x5f/0x70
kernel:  [<c01e7f09>] do_tty_hangup+0x319/0x370
kernel:  [<c01e9144>] release_dev+0x5a4/0x5e0
kernel:  [<c01382fe>] zap_pmd_range+0x4e/0x70
kernel:  [<c0138361>] unmap_page_range+0x41/0x70
kernel:  [<c01e94c1>] tty_release+0x11/0x20
kernel:  [<c01466a1>] __fput+0xe1/0xf0
kernel:  [<c0144feb>] filp_close+0x4b/0x80
kernel:  [<c011a4e7>] put_files_struct+0x67/0xd0
kernel:  [<c011af39>] do_exit+0xf9/0x320
kernel:  [<c011b204>] do_group_exit+0x34/0x80
kernel:  [<c0109003>] syscall_call+0x7/0xb


-- 
ciao, |
Marco | [1639 pazSgKbgibZDU]
