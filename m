Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbTCIIjQ>; Sun, 9 Mar 2003 03:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbTCIIjQ>; Sun, 9 Mar 2003 03:39:16 -0500
Received: from uidc2-110.inav.uiowa.net ([64.6.86.51]:14976 "EHLO
	digitasaru.net") by vger.kernel.org with ESMTP id <S262478AbTCIIjP>;
	Sun, 9 Mar 2003 03:39:15 -0500
Date: Sun, 9 Mar 2003 02:49:49 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.64-bk3: aironet driver problem
Message-ID: <20030309084945.GA539@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hope I didn't miss this on the list somewhere.  While booting, I get:

Mar  9 02:32:43 paulus kernel: cs: IO port probe 0x1000-0x17ff: clean.
Mar  9 02:32:43 paulus kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Mar  9 02:32:43 paulus kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Mar  9 02:32:43 paulus kernel: eth0: NE2000 Compatible: io 0x300, irq 3, hw_addr 00:C0:F0:1C:12:34
Mar  9 02:32:43 paulus kernel: airo: Doing fast bap_reads
Mar  9 02:32:43 paulus kernel: airo: MAC enabled eth1 0:7:e:b8:d6:7d
Mar  9 02:32:43 paulus kernel: eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 4, io 0x0100-0x013f
Mar  9 02:32:43 paulus kernel: bad: scheduling while atomic!
Mar  9 02:32:43 paulus kernel: Call Trace:
Mar  9 02:32:43 paulus kernel: [<c011a32a>] schedule+0x20a/0x220
Mar  9 02:32:43 paulus kernel: [<c0219c93>] issuecommand+0x53/0x80
Mar  9 02:32:43 paulus kernel: [<c021a175>] PC4500_accessrid+0x35/0x80
Mar  9 02:32:43 paulus kernel: [<c021a220>] PC4500_readrid+0x60/0x120
Mar  9 02:32:43 paulus kernel: [<c0217b9a>] readStatsRid+0x1a/0x40
Mar  9 02:32:43 paulus kernel: [<c0218162>] airo_get_stats+0x22/0xc0
Mar  9 02:32:43 paulus kernel: [<c01383ca>] __do_page_cache_readahead+0x6a/0x140
Mar  9 02:32:43 paulus kernel: [<c0132d9e>] find_get_page+0x1e/0x60
Mar  9 02:32:43 paulus kernel: [<c0139451>] kmem_cache_alloc+0x51/0x60
Mar  9 02:32:43 paulus kernel: [<c011a0f8>] scheduler_tick+0x2d8/0x2e0
Mar  9 02:32:43 paulus kernel: [<c012534b>] update_process_times+0x2b/0x40
Mar  9 02:32:43 paulus kernel: [<c012520d>] update_wall_time+0xd/0x40
Mar  9 02:32:43 paulus kernel: [<c01254b8>] do_timer+0xd8/0xe0
Mar  9 02:32:43 paulus kernel: [<c010f992>] do_timer_interrupt+0xd2/0x100
Mar  9 02:32:43 paulus kernel: [<c01c9a2d>] vsnprintf+0x1ed/0x420
Mar  9 02:32:43 paulus kernel: [<c01680b2>] seq_printf+0x32/0x60
Mar  9 02:32:43 paulus kernel: [<c02a272e>] dev_seq_printf_stats+0x6e/0xa0
Mar  9 02:32:43 paulus kernel: [<c02a274c>] dev_seq_printf_stats+0x8c/0xa0
Mar  9 02:32:43 paulus kernel: [<c02a2775>] dev_seq_show+0x15/0x40
Mar  9 02:32:43 paulus kernel: [<c0167b76>] seq_read+0x1b6/0x2e0
Mar  9 02:32:43 paulus kernel: [<c014bcb8>] vfs_read+0x98/0xe0
Mar  9 02:32:43 paulus kernel: [<c014bec8>] sys_read+0x28/0x40
Mar  9 02:32:43 paulus kernel: [<c0109607>] syscall_call+0x7/0xb
Mar  9 02:32:43 paulus kernel: 
Mar  9 02:32:43 paulus kernel: bad: scheduling while atomic!
Mar  9 02:32:43 paulus kernel: Call Trace:
Mar  9 02:32:43 paulus kernel: [<c011a32a>] schedule+0x20a/0x220
Mar  9 02:32:43 paulus kernel: [<c0219c93>] issuecommand+0x53/0x80
Mar  9 02:32:43 paulus kernel: [<c021a175>] PC4500_accessrid+0x35/0x80
Mar  9 02:32:43 paulus kernel: [<c021a220>] PC4500_readrid+0x60/0x120
Mar  9 02:32:43 paulus kernel: [<c0217b9a>] readStatsRid+0x1a/0x40
Mar  9 02:32:43 paulus kernel: [<c0218162>] airo_get_stats+0x22/0xc0
Mar  9 02:32:43 paulus kernel: [<c01c9a2d>] vsnprintf+0x1ed/0x420
Mar  9 02:32:43 paulus kernel: [<c01680b2>] seq_printf+0x32/0x60
Mar  9 02:32:43 paulus kernel: [<c02a272e>] dev_seq_printf_stats+0x6e/0xa0
Mar  9 02:32:43 paulus kernel: [<c02a274c>] dev_seq_printf_stats+0x8c/0xa0
Mar  9 02:32:43 paulus kernel: [<c02a2775>] dev_seq_show+0x15/0x40
Mar  9 02:32:43 paulus kernel: [<c0167b76>] seq_read+0x1b6/0x2e0
Mar  9 02:32:43 paulus kernel: [<c014bcb8>] vfs_read+0x98/0xe0
Mar  9 02:32:43 paulus kernel: [<c014bec8>] sys_read+0x28/0x40
Mar  9 02:32:43 paulus kernel: [<c0109607>] syscall_call+0x7/0xb
Mar  9 02:32:43 paulus kernel: 

Upon getting to a prompt, I ran ifconfig, and it dumped something similar
  (didn't get it down, and I couldn't sync anymore), and it locked up hard.

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
" I'm all for using the best tool for the job, but what happens when the
 restrictions that go along with that tool take away your rights? I believe
 it then stops being the best tool for the job."  --randy@digitalrights.org
