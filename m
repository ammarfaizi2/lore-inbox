Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262441AbSJESfW>; Sat, 5 Oct 2002 14:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262444AbSJESfW>; Sat, 5 Oct 2002 14:35:22 -0400
Received: from mail.broadpark.no ([217.13.4.2]:34485 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S262441AbSJESfU>;
	Sat, 5 Oct 2002 14:35:20 -0400
Message-ID: <3D9F4A8A.190A6B5F@broadpark.no>
Date: Sat, 05 Oct 2002 22:24:42 +0200
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.40bk4 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Some backtraces (2.5.40-bk4 smp+preempt)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

logged by dmesg during boot:
calibrating APIC timer ...
..... CPU clock speed is 501.0081 MHz.
..... host bus clock speed is 100.0216 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
bad: scheduling while atomic!
Call Trace:
 [<c0117351>] schedule+0x3d/0x4f4
 [<c0117bfd>] wait_for_completion+0x111/0x1c4
 [<c011784c>] default_wake_function+0x0/0x34
 [<c011784c>] default_wake_function+0x0/0x34
 [<c0119563>] set_cpus_allowed+0x217/0x240
 [<c01195dc>] migration_thread+0x50/0x53c
 [<c011958c>] migration_thread+0x0/0x53c
 [<c0105591>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace: [<c0117351>] schedule+0x3d/0x4f4
 [<c0117bfd>] wait_for_completion+0x111/0x1c4
 [<c011784c>] default_wake_function+0x0/0x34
 [<c011784c>] default_wake_function+0x0/0x34
 [<c0119563>] set_cpus_allowed+0x217/0x240
 [<c0120c45>] ksoftirqd+0x51/0xe0
 [<c0120bf4>] ksoftirqd+0x0/0xe0
 [<c0105591>] kernel_thread_helper+0x5/0xc

CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
bad: scheduling while atomic!
Call Trace:
 [<c0117351>] schedule+0x3d/0x4f4
 [<c0117bfd>] wait_for_completion+0x111/0x1c4
 [<c011784c>] default_wake_function+0x0/0x34
 [<c011784c>] default_wake_function+0x0/0x34
 [<c0119563>] set_cpus_allowed+0x217/0x240
 [<c012a7b6>] worker_thread+0x9e/0x4ac
 [<c012a718>] worker_thread+0x0/0x4ac
 [<c0107521>] ret_from_fork+0x5/0x14
 [<c011784c>] default_wake_function+0x0/0x34
 [<c011784c>] default_wake_function+0x0/0x34
 [<c0105591>] kernel_thread_helper+0x5/0xc

mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
.
.
.
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 178 entries (12 bytes)
biovec pool[1]:   4 bvecs: 178 entries (48 bytes)
biovec pool[2]:  16 bvecs: 178 entries (192 bytes)
biovec pool[3]:  64 bvecs:  89 entries (768 bytes)
biovec pool[4]: 128 bvecs:  44 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  22 entries (3072 bytes)
bad: scheduling while atomic!
Call Trace:
 [<c0117351>] schedule+0x3d/0x4f4
 [<c0117bfd>] wait_for_completion+0x111/0x1c4
 [<c011784c>] default_wake_function+0x0/0x34
 [<c011784c>] default_wake_function+0x0/0x34
 [<c0119563>] set_cpus_allowed+0x217/0x240
 [<c012a7b6>] worker_thread+0x9e/0x4ac
 [<c012a718>] worker_thread+0x0/0x4ac
 [<c0107521>] ret_from_fork+0x5/0x14
 [<c011784c>] default_wake_function+0x0/0x34
 [<c011784c>] default_wake_function+0x0/0x34
 [<c0105591>] kernel_thread_helper+0x5/0xc

aio_setup: sizeof(struct page) = 40

sda: synchronizing cache...OK
MTRR: setting reg 1
MTRR: setting reg 1
md: md0: sync done.
RAID1 conf printout:
 --- wd:2 rd:2
 disk 0, wo:0, o:1, dev:scsi/host0/bus0/target0/lun0/part2
 disk 1, wo:0, o:1, dev:scsi/host0/bus0/target1/lun0/part1
md: updating md0 RAID superblock on device
md: scsi/host0/bus0/target1/lun0/part1 [events: 00000251]<6>(write)
scsi/host0/b
us0/target1/lun0/part1's sb offset: 98240
md: scsi/host0/bus0/target0/lun0/part2 [events: 00000251]<6>(write)
scsi/host0/b
us0/target0/lun0/part2's sb offset: 98240
Debug: sleeping function called from illegal context at
/usr/src/linux/include/a
sm/semaphore.h:119
Call Trace:
 [<c0119b84>] __might_sleep+0x54/0x58
 [<c02ac327>] snd_trident_alloc_pages+0x4b/0xdc
 [<c02a7969>] snd_trident_playback_hw_params+0xc5/0x190
 [<c0280d12>] snd_pcm_hw_params+0xca/0x294
 [<c0280f47>] snd_pcm_hw_params_user+0x6b/0xb4
 [<c0284dc8>] snd_pcm_common_ioctl1+0x15c/0x2bc
 [<c0285346>] snd_pcm_playback_ioctl1+0x41e/0x42c
 [<c02856ef>] snd_pcm_kernel_playback_ioctl+0x27/0x30
 [<c028574b>] snd_pcm_kernel_ioctl+0x23/0x40
 [<c0277cf9>] snd_pcm_oss_change_params+0x429/0x66c
 [<c02476d6>] sym_queue_scsiio+0x1fa/0x204
 [<c0243ddf>] sym_start_next_ccbs+0xd7/0x10c
 [<c0277f6e>] snd_pcm_oss_get_active_substream+0x32/0x50
 [<c02789cc>] snd_pcm_oss_get_block_size+0x10/0x28
 [<c0279d56>] snd_pcm_oss_ioctl+0x38a/0x768
 [<c015b2bb>] sys_ioctl+0x27f/0x2fb
 [<c01075c3>] syscall_call+0x7/0xb
