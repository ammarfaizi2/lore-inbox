Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTAKOLS>; Sat, 11 Jan 2003 09:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTAKOLS>; Sat, 11 Jan 2003 09:11:18 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:29201 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S267222AbTAKOLR>;
	Sat, 11 Jan 2003 09:11:17 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.55, APM] running "apm -s" doesn't sleep
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Sat, 11 Jan 2003 14:53:43 +0100
Message-ID: <87bs2nssgo.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On my Thinkpad 600:

Jan 10 21:26:46 gswi1164 kernel: bad: scheduling while atomic!
Jan 10 21:26:46 gswi1164 kernel: Call Trace:
Jan 10 21:26:46 gswi1164 kernel:  [schedule+61/724] scheduling_functions_start_here+0x3d/0x2d4
Jan 10 21:26:46 gswi1164 kernel:  [schedule_timeout+122/160] process_timeout+0x7a/0xa0
Jan 10 21:26:46 gswi1164 kernel:  [process_timeout+0/16] sys_getegid+0x0/0x10
Jan 10 21:26:46 gswi1164 kernel:  [<c6ab31d3>] cs_sleep+0x1f/0x3954ce4c [pcmcia_core]
Jan 10 21:26:46 gswi1164 kernel:  [<c6ab355b>] do_shutdown+0x53/0x3954caf8 [pcmcia_core]
Jan 10 21:26:46 gswi1164 kernel:  [<c6ab5547>] pcmcia_eject_card+0x5b/0x3954ab14 [pcmcia_core]
Jan 10 21:26:46 gswi1164 kernel:  [<c6a2afca>] ds_ioctl+0x416/0x395d544c [ds]
Jan 10 21:26:46 gswi1164 kernel:  [do_rw_disk+1174/1872] idedisk_start_tag+0x496/0x750
Jan 10 21:26:46 gswi1164 kernel:  [start_request+154/328] execute_drive_cmd+0x9a/0x148
Jan 10 21:26:46 gswi1164 kernel:  [start_request+243/328] execute_drive_cmd+0xf3/0x148
Jan 10 21:26:46 gswi1164 kernel:  [journal_cancel_revoke+257/376] journal_revoke+0x101/0x178
Jan 10 21:26:46 gswi1164 kernel:  [ext3_get_block_handle+190/784] ext3_splice_branch+0xbe/0x310
Jan 10 21:26:46 gswi1164 kernel:  [journal_cancel_revoke+257/376] journal_revoke+0x101/0x178
Jan 10 21:26:46 gswi1164 last message repeated 2 times
Jan 10 21:26:46 gswi1164 kernel:  [do_get_write_access+1295/1328] jbd_unexpected_dirty_buffer+0x50f/0x530
Jan 10 21:26:46 gswi1164 kernel:  [find_get_page+31/72] __lock_page+0x1f/0x48
Jan 10 21:26:46 gswi1164 kernel:  [filemap_nopage+285/684] page_cache_read+0x11d/0x2ac
Jan 10 21:26:46 gswi1164 kernel:  [pte_chain_alloc+27/132] __pte_chain_free+0x1b/0x84
Jan 10 21:26:46 gswi1164 kernel:  [do_no_page+653/668] do_anonymous_page+0x28d/0x29c
Jan 10 21:26:46 gswi1164 kernel:  [handle_mm_fault+107/256] do_no_page+0x6b/0x100
Jan 10 21:26:46 gswi1164 kernel:  [do_page_fault+331/1054] bust_spinlocks+0x14b/0x41e
Jan 10 21:26:46 gswi1164 kernel:  [do_page_fault+0/1054] bust_spinlocks+0x0/0x41e
Jan 10 21:26:46 gswi1164 kernel:  [kmem_cache_free+396/472] kmalloc+0x18c/0x1d8
Jan 10 21:26:46 gswi1164 kernel:  [sys_unlink+220/284] vfs_unlink+0xdc/0x11c
Jan 10 21:26:46 gswi1164 kernel:  [capable+29/56] mod_unreg_security+0x1d/0x38
Jan 10 21:26:46 gswi1164 kernel:  [sys_ioctl+543/624] file_ioctl+0x21f/0x270
Jan 10 21:26:46 gswi1164 kernel:  [syscall_call+7/11] system_call+0x7/0xb
Jan 10 21:26:46 gswi1164 kernel:
Jan 10 22:27:08 gswi1164 kernel: uhci-hcd 00:07.2: suspend to state 3
Jan 10 22:27:08 gswi1164 kernel: drivers/usb/host/uhci-hcd.c: 8400: suspend_hc
Jan 10 22:27:08 gswi1164 kernel: apm: suspend: Unable to enter requested state
Jan 10 22:27:08 gswi1164 kernel: uhci-hcd 00:07.2: resume

-- 
#include <~/.signature>: permission denied
