Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUIMVvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUIMVvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268992AbUIMVvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:51:47 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:5817 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268086AbUIMVvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:51:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: 2.6.9-rc1-mm5: double fault on resume on Athlon64 w/ NForce 3
Date: Mon, 13 Sep 2004 23:57:13 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409132357.13582.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

JFYI, I get a double fault on resume on an Athlon64-based box:

Relocating 
pagedir .....................................................................................................................|
Reading image data (44091 pages): 100% 44091 done.
Stopping tasks: ===|
Freeing memory... done (0 pages freed)
PM: Restoring saved image.
<0>double fault: 0000 [1]
CPU 0
Modules linked in: ohci_hcd usbserial parport_pc lp parport joydev sg sd_mod 
sr_mod scsi_mod cpufreq_userspace powernow_k8 thermal proced
Pid: 18616, comm: hibernate.sh Not tainted 2.6.9-rc1-mm5
RIP: 0010:[<ffffffff80124aa7>] <ffffffff80124aa7>{do_page_fault+55}
RSP: 0000:000001001fdfff48  EFLAGS: 00010016
RAX: ffffffff80124a70 RBX: 0000000000000001 RCX: 000ffffffffff000
RDX: 000000001fce5000 RSI: 0000000000000000 RDI: 000001001fe00068
RBP: 0000000080111213 R08: 0000000000000000 R09: 000001001fe27e54
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000001001f999148 R14: 000001001f8b92b0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff80551b40(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 0000000080050033
CR2: 000001001fdfff38 CR3: 0000000000101000 CR4: 00000000000006e0
Process hibernate.sh (pid: 18616, threadinfo 000001000aad8000, task 
000001001f8b92b0)

(that's all I get, unfortunately).  It does not occur every time, but fairly 
often (every 3-4 suspends or so).

The .config is available at: 
http://www.sisk.pl/kernel/040913/2.6.9-rc1-mm5.config

The output of dmesg is available at: 
http://www.sisk.pl/kernel/040913/2.6.9-rc1-mm5-dmesg.log

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
