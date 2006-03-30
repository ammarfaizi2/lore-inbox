Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWC3Tix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWC3Tix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWC3Tix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:38:53 -0500
Received: from dukecmmtao02.coxmail.com ([68.99.120.69]:22692 "EHLO
	dukecmmtao02.coxmail.com") by vger.kernel.org with ESMTP
	id S1750788AbWC3Tiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:38:52 -0500
Message-ID: <009b01c65431$939c9100$2801010a@Dolphin>
From: "Peter Van" <plst@ws.sbcoxmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: How to debug an Oops on  FC4 2.6 Kernel
Date: Thu, 30 Mar 2006 11:38:52 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My computer hung af few day ago for no apparent  reason requiring a reboot and 
clear.
/var/log/messages has an  Oops log but I don't know how to use the Oops log to 
determine the cause of the problem.  According to some posts,  ksymoops can't be 
used
on a 2.6 kernel.

When I run kysmoops I get:

  Error (regular_file): read_ksyms stat /proc/ksyms failed
  No modules in ksyms, skipping objects
  No ksyms, skipping lsmod
  Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
  Warning (merge_maps): no symbols in merged map

As the message says, the file /proc/ksyms does not exist on my computer.

Can someone please advise me on how to process or reference any documentation?


Here is the Oops output and the output of several other commands.

Thank You
Peter Van



Mar 24 23:04:36 tan kernel: ------------[ cut here ]------------
Mar 24 23:04:36 tan kernel: kernel BUG at fs/jbd/transaction.c:271!
Mar 24 23:04:36 tan kernel: invalid operand: 0000 [#2]
Mar 24 23:04:36 tan kernel: SMP
Mar 24 23:04:36 tan kernel: Modules linked in: nfs lockd loop radeon drm 
parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc
 md5 ipv6 dm_mod video button battery ac ohci1394 ieee1394 uhci_hcd ehci_hcd 
shpchp hw_random i2c_i801 i2c_core snd_intel8x0 snd_ac9
7_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcor
e snd_page_alloc sk98lin floppy ext3 jbd raid1 ata_piix libata sd_mod scsi_mod
Mar 24 23:04:36 tan kernel: CPU:    1
Mar 24 23:04:36 tan kernel: EIP:    0060:[<f88a1461>]    Not tainted VLI
Mar 24 23:04:36 tan kernel: EFLAGS: 00010296   (2.6.11-1.1369_FC4smp)
Mar 24 23:04:36 tan kernel: EIP is at journal_start+0x51/0xbb [jbd]
Mar 24 23:04:36 tan kernel: eax: 00000073   ebx: e2ec61a0   ecx: c035ea4c   edx: 
00000296
Mar 24 23:04:36 tan kernel: esi: f7810e00   edi: f7d74000   ebp: 000007c0   esp: 
f7d74a88
Mar 24 23:04:36 tan kernel: ds: 007b   es: 007b   ss: 0068
Mar 24 23:04:36 tan kernel: Process kswapd0 (pid: 161, threadinfo=f7d74000 
task=f7d67550)
Mar 24 23:04:36 tan kernel: Stack: f88a8608 f88aeba2 f88a9667 0000010f f88a8668 
f88de6d1 c9ea88dc c101b220
Mar 24 23:04:36 tan kernel:        f88de703 00000000 c9ea89a4 c9ea8994 0000000e 
c0144f35 00000000 f88de6d1
Mar 24 23:04:36 tan kernel:        c101b220 000004b9 c9ea8994 c0146baf 00000800 
00000001 f7d74c34 00000001
Mar 24 23:04:36 tan kernel: Call Trace:
Mar 24 23:04:36 tan kernel:  [<f88de6d1>] ext3_prepare_write+0x0/0x132 [ext3]
Mar 24 23:04:36 tan kernel:  [<f88de703>] ext3_prepare_write+0x32/0x132 [ext3]
Mar 24 23:04:36 tan kernel:  [<c0144f35>] find_lock_page+0x8c/0xa4
Mar 24 23:04:36 tan kernel:  [<f88de6d1>] ext3_prepare_write+0x0/0x132 [ext3]
Mar 24 23:04:36 tan kernel:  [<c0146baf>] 
generic_file_buffered_write+0x27d/0x60c
Mar 24 23:04:36 tan kernel:  [<c01d5b6c>] vsnprintf+0x32e/0x5f6
Mar 24 23:04:36 tan kernel:  [<c01264ba>] current_fs_time+0x5a/0x75
Mar 24 23:04:36 tan kernel:  [<c017a238>] inode_update_time+0x2d/0x99
Mar 24 23:04:36 tan kernel:  [<c01471f0>] 
__generic_file_aio_write_nolock+0x2b2/0x4fa
Mar 24 23:04:36 tan kernel:  [<c024b829>] cfq_merge+0x0/0xcd
Mar 24 23:04:36 tan kernel:  [<c014767f>] generic_file_aio_write+0x6f/0xda
Mar 24 23:04:36 tan kernel:  [<f88dc266>] ext3_file_write+0x24/0x96 [ext3]
Mar 24 23:04:36 tan kernel:  [<c0161eeb>] do_sync_write+0x9e/0xec
Mar 24 23:04:36 tan kernel:  [<c0126526>] getnstimeofday+0xd/0x2f
Mar 24 23:04:36 tan kernel:  [<c0134b3b>] autoremove_wake_function+0x0/0x37
Mar 24 23:04:36 tan kernel:  [<c013ec84>] do_acct_process+0x403/0x426
Mar 24 23:04:36 tan kernel:  [<c0121d6b>] vprintk+0x1f5/0x2a9

uname -a :
Linux tan 2.6.15-1.1833_FC4smp #1 SMP Wed Mar 1 23:56:51 EST 2006 i686


cat /proc/version:

Linux version 2.6.15-1.1833_FC4smp (bhcompile@hs20-bc1-1.build.redhat.com) (gcc 
version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 SMP Wed Mar 1 23:56:51 EST 2006


