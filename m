Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVANJRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVANJRc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 04:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVANJRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 04:17:31 -0500
Received: from [61.152.241.141] ([61.152.241.141]:55770 "EHLO
	adf141.allyes.com") by vger.kernel.org with ESMTP id S261824AbVANJR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 04:17:27 -0500
Message-Id: <200501140901.j0E91Lk07957@adf141.allyes.com>
Date: Fri, 14 Jan 2005 17:17:13 +0800
From: "jike" <jike@allyes.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Linux kernel 2.4.20-18.7smp bug 
X-mailer: Foxmail 5.0 beta2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all

	I use the RedHat Linux 7.3 , kernel version is 2.4.20-18.7smp. Today, i find one bug info in /var/log/message, the bug info as following:
  
Jan 13 11:00:02 zjip142 kernel: SCSI disk error : host 0 channel 0 id 0 lun 2 return code = 10000
Jan 13 11:00:02 zjip142 kernel:  I/O error: dev 08:01, sector 26376
Jan 13 11:02:47 zjip142 kernel: Assertion failure in do_get_write_access() at transaction.c:742: "(((jh2bh(jh))->b_state & (1UL << BH_Uptodate)) != 0)"
Jan 13 11:02:47 zjip142 kernel: ------------[ cut here ]------------
Jan 13 11:02:47 zjip142 kernel: kernel BUG at transaction.c:742!
Jan 13 11:02:47 zjip142 kernel: invalid operand: 0000
Jan 13 11:02:47 zjip142 kernel: lpfcdd autofs tg3 usb-ohci usbcore ext3 jbd cciss sd_mod scsi_mod
Jan 13 11:02:47 zjip142 kernel: CPU:    2
Jan 13 11:02:47 zjip142 kernel: EIP:    0010:[<f883fc95>]    Tainted: P
Jan 13 11:02:47 zjip142 kernel: EFLAGS: 00010286
Jan 13 11:02:47 zjip142 kernel:
Jan 13 11:02:47 zjip142 kernel: EIP is at do_get_write_access [jbd] 0x485 (2.4.20-18.7smp)
Jan 13 11:02:47 zjip142 kernel: eax: 0000007b   ebx: f6815e94   ecx: 00000086   edx: 00000001
Jan 13 11:02:47 zjip142 kernel: esi: f4414520   edi: f6815e00   ebp: f318ef00   esp: c3297980
Jan 13 11:02:47 zjip142 kernel: ds: 0018   es: 0018   ss: 0018
Jan 13 11:02:47 zjip142 kernel: Process TrendOne (pid: 11110, stackpage=c3297000)
Jan 13 11:02:47 zjip142 kernel: Stack: f8846480 f88484ae f8848410 000002e6 f8846720 00000001 00000000 00000000
Jan 13 11:02:47 zjip142 kernel:        f123cc80 e901fd80 00000000 f6815e00 00000000 f543b480 e75d7d00 e75d7d00
Jan 13 11:02:47 zjip142 kernel:        f88539f9 f543b480 00000000 f8840fbf f318edb0 f543b480 f7764c00 f4414520
Jan 13 11:02:47 zjip142 kernel: Call Trace:   [<f8846480>] .rodata.str1.32 [jbd] 0xe0 (0xc3297980))
Jan 13 11:02:47 zjip142 kernel: [<f88484ae>] .rodata.str1.1 [jbd] 0xae (0xc3297984))
Jan 13 11:02:47 zjip142 kernel: [<f8848410>] .rodata.str1.1 [jbd] 0x10 (0xc3297988))
Jan 13 11:02:47 zjip142 kernel: [<f8846720>] .rodata.str1.32 [jbd] 0x380 (0xc3297990))
Jan 13 11:02:47 zjip142 kernel: [<f88539f9>] ext3_dirty_inode [ext3] 0xa9 (0xc32979c0))
Jan 13 11:02:47 zjip142 kernel: [<f8840fbf>] __journal_file_buffer [jbd] 0x10f (0xc32979cc))
Jan 13 11:02:47 zjip142 kernel: [<f883ffc1>] journal_get_undo_access_Rsmp_4d348160 [jbd] 0x41 (0xc32979e4))
Jan 13 11:02:47 zjip142 kernel: [<f884e0e7>] ext3_new_block [ext3] 0x447 (0xc3297a08))
Jan 13 11:02:47 zjip142 kernel: [<f883fd4a>] do_get_write_access [jbd] 0x53a (0xc3297a40))
Jan 13 11:02:47 zjip142 kernel: [<f88533f9>] ext3_do_update_inode [ext3] 0x2f9 (0xc3297a5c))


i have searched this info on google, but got nothing. how to patch this bug,I really appreciate your help. thank you!

