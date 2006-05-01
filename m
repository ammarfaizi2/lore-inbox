Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWEAVVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWEAVVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWEAVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:21:38 -0400
Received: from dukecmmtao02.coxmail.com ([68.99.120.69]:31919 "EHLO
	dukecmmtao02.coxmail.com") by vger.kernel.org with ESMTP
	id S932266AbWEAVVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:21:37 -0400
Message-ID: <007b01c66d65$3b962d20$2801010a@Dolphin>
From: "Peter Van" <plst@ws.sbcoxmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Kernel Oops 2.6.15-1 FC4
Date: Mon, 1 May 2006 14:21:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running FC4 and had a Oops about two weeks ago.  Several people on this 
list suggested I upgrade to a newer kernel which I did.  The other day another 
Oops occured in what looks like the same file.   I've run  memtest for 24 hours 
without a problem.

I'd appreciate any suggestions on how to determine the cause or track this down?


Thanks Pete


uname -a  : Linux tan 2.6.15-1.1833_FC4smp #1 SMP
Software RAID 1

Apr 27 15:50:35 tan kernel: ------------[ cut here ]------------
Apr 27 15:50:35 tan kernel: kernel BUG at fs/jbd/transaction.c:270!
Apr 27 15:50:35 tan kernel: invalid operand: 0000 [#2]
Apr 27 15:50:35 tan kernel: SMP
Apr 27 15:50:35 tan kernel: last sysfs file: 
/devices/pci0000:00/0000:00:01.0/0000:01:00.0/modalias
Apr 27 15:50:35 tan kernel: Modules linked in: radeon drm parport_pc lp parport 
autofs4 nfs lockd nfs_acl rfcomm l2cap bluetooth sun
rpc ipv6 dm_mod video button battery skge ac ohci1394 ieee1394 uhci_hcd ehci_hcd 
hw_random i2c_i801 i2c_core snd_intel8x0 snd_ac97_c
odec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq 
snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer sn
d soundcore snd_page_alloc sk98lin floppy ext3 jbd raid1 ata_piix libata sd_mod 
scsi_mod
Apr 27 15:50:35 tan kernel: CPU:    0
Apr 27 15:50:35 tan kernel: EIP:    0060:[<f88a748e>]    Not tainted VLI
Apr 27 15:50:35 tan kernel: EFLAGS: 00010296   (2.6.15-1.1833_FC4smp)
Apr 27 15:50:35 tan kernel: EIP is at journal_start+0x51/0xbb [jbd]
Apr 27 15:50:35 tan kernel: eax: 00000073   ebx: d81b83b0   ecx: ffffffff   edx: 
00000246
Apr 27 15:50:35 tan kernel: esi: f71a9400   edi: f0577000   ebp: ea33dd04   esp: 
f0577a4c
Apr 27 15:50:35 tan kernel: ds: 007b   es: 007b   ss: 0068
Apr 27 15:50:35 tan kernel: Process oslo2 (pid: 5876, threadinfo=f0577000 
task=f7d8c000)
Apr 27 15:50:35 tan kernel: Stack: f88af15c f88ae722 f88aeb44 0000010e f88af1bc 
00000001 d81b83b0 ea33dd04
Apr 27 15:50:35 tan kernel:        f88e6fa0 2eb2bd02 44514ab8 00000001 00000040 
00858040 c018acc8 f0577aa8
Apr 27 15:50:35 tan kernel:        44514ab8 00000000 ea33dd04 00000040 00000001 
f794ee00 c0182cd8 44514ab8
Apr 27 15:50:35 tan kernel: Call Trace:
Apr 27 15:50:35 tan kernel:  [<f88e6fa0>] ext3_dirty_inode+0x27/0x82 [ext3] 
[<c018acc8>] __mark_inode_dirty+0x28/0x191
Apr 27 15:50:35 tan kernel:  [<c0182cd8>] inode_update_time+0x2d/0x99 
[<c014c576>] __generic_file_aio_write_nolock+0x269/0x4d9
Apr 27 15:50:35 tan kernel:  [<c014ca28>] generic_file_aio_write+0x72/0xe0 
[<f88e21fe>] ext3_file_write+0x24/0x96 [ext3]
Apr 27 15:50:35 tan kernel:  [<c01698f5>] do_sync_write+0xbb/0x116 
[<c012a0b7>] getnstimeofday+0xd/0x2f
Apr 27 15:50:35 tan kernel:  [<c0139196>] autoremove_wake_function+0x0/0x37 
[<c0143a79>] do_acct_process+0x404/0x427
Apr 27 15:50:35 tan kernel:  [<c0143ad4>] acct_process+0x38/0x50 
[<c0127e57>] do_exit+0x31c/0x400
Apr 27 15:50:35 tan kernel:  [<c01053fc>] do_divide_error+0x0/0xa8 
[<c032ccf9>] do_page_fault+0x209/0x6f0
Apr 27 15:50:35 tan kernel:  [<f88e4678>] ext3_prepare_write+0x0/0x132 [ext3] 
[<c032caf0>] do_page_fault+0x0/0x6f0
:
Apr 27 15:50:35 tan kernel:  [<c0104bd3>] error_code+0x4f/0x54     [<f88e4678>] 
ext3_prepare_write+0x0/0x132 [ext3]
Apr 27 15:50:35 tan kernel:  [<f88e46c1>] ext3_prepare_write+0x49/0x132 [ext3] 
[<f88e4678>] ext3_prepare_write+0x0/0x132 [ext3]
Apr 27 15:50:35 tan kernel:  [<c014bf58>] 
generic_file_buffered_write+0x2a0/0x655     [<c012a04b>] 
current_fs_time+0x5a/0x75
Apr 27 15:50:35 tan kernel:  [<c0182cd8>] inode_update_time+0x2d/0x99 
[<c014c5b0>] __generic_file_aio_write_nolock+0x2a3/0x4d9
Apr 27 15:50:35 tan kernel:  [<c014ca28>] generic_file_aio_write+0x72/0xe0 
[<c01203cd>] scheduler_tick+0x150/0x371
Apr 27 15:50:35 tan kernel:  [<f88e21fe>] ext3_file_write+0x24/0x96 [ext3] 
[<c01698f5>] do_sync_write+0xbb/0x116
Apr 27 15:50:35 tan kernel:  [<c011fc27>] load_balance+0x4f/0x1e6 
[<c0139196>] autoremove_wake_function+0x0/0x37
Apr 27 15:50:35 tan kernel:  [<c016983a>] do_sync_write+0x0/0x116 
[<c01699f2>] vfs_write+0xa2/0x15a
Apr 27 15:50:35 tan kernel:  [<c0169b55>] sys_write+0x41/0x6a     [<c0104035>] 
syscall_call+0x7/0xb
Apr 27 15:50:35 tan kernel:  <1>Fixing recursive fault but reboot is needed!



