Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWGaOsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWGaOsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWGaOsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:48:13 -0400
Received: from web57012.mail.re3.yahoo.com ([66.196.97.116]:11666 "HELO
	web57012.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1751021AbWGaOsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:48:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rocketmail.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=DoZxwpYlH8mCw0qM2B3jHqdG9wCRLNO4WbVjE6jHQ1jGIK66Tuc6si4SvLfcSYqs6mMnJKyRAL+xbE00NmhqhyyaE6WtE8OXavqS2vPnImv7YAMQAFtJRz/qjk5Kpej8y/Op2tLPgiwE1bfZiugGf26JYeGYOAWgve6Fs7DR25s=  ;
Message-ID: <20060731144810.91843.qmail@web57012.mail.re3.yahoo.com>
Date: Mon, 31 Jul 2006 07:48:10 -0700 (PDT)
From: Stephen Lynch <Stephen_Lynch@rocketmail.com>
Reply-To: Stephen Lynch <Stephen_Lynch@rocketmail.com>
Subject: BUG: unable to handle kernel paging request at virtual address
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've had the two crashes below in the past couple of weeks. On one occasion it was while I was copying large amounts of files from one drive to another when it happened, which lead me to believe it is related to my hdd. I have ran the manufacturer's diagnostic utils on it and it came back clean, but im not sure whether to trust it or not. Can anybody tell me what they reckon is causing the issue.

Thanks,
Stephen


Jul 13 13:14:53 dublin kernel: BUG: unable to handle kernel paging request at virtual address 00080000
Jul 13 13:14:53 dublin kernel:  printing eip:
Jul 13 13:14:53 dublin kernel: f882fbaf
Jul 13 13:14:53 dublin kernel: *pde = 376cd001
Jul 13 13:14:53 dublin kernel: Oops: 0000 [#1]
Jul 13 13:14:53 dublin kernel: SMP
Jul 13 13:14:53 dublin kernel: last sysfs file: /block/hda/removable
Jul 13 13:14:53 dublin kernel: Modules linked in: autofs4 hidp rfcomm l2cap bluetooth sunrpc ipv6 ip_conntrack_netbios_ns ipt_MASQUERADE iptable_nat ip_nat iptable_mangle ipt_LO
G xt_tcpudp xt_state ip_conntrack nfnetlink xt_multiport iptable_filter ip_tables x_tables dm_mirror dm_mod lp parport_pc parport st snd_intel8x0 snd_ac97_codec snd_ac97_bus snd
_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq aic7xxx snd_seq_device natsemi sg snd_pcm_oss snd_mixer_oss snd_pcm uhci_hcd hw_random scsi_transport_spi i82875p_edac edac_mc
e1000 ehci_hcd i6300esb i2c_i801 i2c_core snd_timer snd soundcore snd_page_alloc ext3 jbd sata_promise ata_piix libata sd_mod scsi_mod
Jul 13 13:14:53 dublin kernel: CPU:    1
Jul 13 13:14:53 dublin kernel: EIP:    0060:[<f882fbaf>]    Not tainted VLI
Jul 13 13:14:53 dublin kernel: EFLAGS: 00010206   (2.6.17-1.2145_FC5smp #1)
Jul 13 13:14:53 dublin kernel: EIP is at __journal_remove_checkpoint+0xe/0x74 [jbd]
Jul 13 13:14:53 dublin kernel: eax: ca2dfc00   ebx: ca2dfc00   ecx: 00080000   edx: 00000001
Jul 13 13:14:53 dublin kernel: esi: ca2dfc00   edi: c15ea678   ebp: ca2dfc00   esp: f7f4ae10
Jul 13 13:14:53 dublin kernel: ds: 007b   es: 007b   ss: 0068
Jul 13 13:14:53 dublin kernel: Process kswapd0 (pid: 109, threadinfo=f7f4a000 task=f7efb930)
Jul 13 13:14:53 dublin kernel: Stack: c7611414 c7611414 ca2dfc00 f882e0dd c14e6ee8 00000246 010113e0 c14e6ee8
Jul 13 13:14:53 dublin kernel:        efe329e4 f74c1a00 c7611414 f88c5864 000000d0 c06d9d00 00000001 c046cc93
Jul 13 13:16:10 dublin kernel:        c15ea678 efe329e4 c04553f9 f7f4af48 00000082 00000019 00000002 f7f4af8c
Jul 13 13:19:38 dublin kernel: Call Trace:
Jul 13 13:20:09 dublin kernel:  <f882e0dd> journal_try_to_free_buffers+0xe5/0x14a [jbd]  <f88c5864> ext3_releasepage+0x0/0x7b [ext3]
Jul 13 13:20:25 dublin kernel:  <c046cc93> try_to_release_page+0x34/0x46  <c04553f9> shrink_zone+0x9ba/0xe36
Jul 13 13:20:25 dublin kernel:  <c049796e> mb_cache_shrink_fn+0x56/0xff  <c04546bc> shrink_slab+0x62/0x14a
Jul 13 13:20:40 dublin kernel:  <c0455a6c> balance_pgdat+0x1f7/0x320  <c0455d2d> kswapd+0xdf/0xe1
Jul 13 13:20:56 dublin kernel:  <c04363a8> autoremove_wake_function+0x0/0x35  <c0455c4e> kswapd+0x0/0xe1
Jul 13 13:20:56 dublin kernel:  <c0402005> kernel_thread_helper+0x5/0xb
Jul 13 13:21:12 dublin kernel: Code: cb 3b 83 f8 e8 35 5f bf c7 0f 0b 79 02 94 3b 83 f8 83 c4 14 89 d8 5b 5e e9 6c 75 c3 c7 56 53 89 c3 83 ec 04 8b 48 28 85 c9 74 62 <8b> 31 8b
53 30 c7 40 28 00 00 00 00 8b 40 2c 89 50 30 8b 53 30
Jul 13 13:21:12 dublin kernel: EIP: [<f882fbaf>] __journal_remove_checkpoint+0xe/0x74 [jbd] SS:ESP 0068:f7f4ae10
Jul 13 13:21:27 dublin kernel:  <3>BUG: soft lockup detected on CPU#0!
Jul 13 13:21:43 dublin kernel:  <c044a9b6> softlockup_tick+0xad/0xc4  <c042d874> update_process_times+0x39/0x5c
Jul 13 13:21:58 dublin kernel:  <c0418af3> smp_apic_timer_interrupt+0x5a/0x63  <c040490f> apic_timer_interrupt+0x1f/0x24
Jul 13 13:22:29 dublin kernel:  <c04eaa43> _raw_spin_lock+0x60/0xe1  <f8831147> journal_add_journal_head+0x20/0x148 [jbd]
Jul 13 13:22:45 dublin kernel:  <c046e0c1> __block_prepare_write+0x1dc/0x457  <f882da0d> journal_dirty_data+0x4f/0x1eb [jbd]
Jul 13 13:23:00 dublin kernel:  <f88c3cd0> ext3_journal_dirty_data+0xf/0x32 [ext3]  <f882d1d4> journal_start+0xba/0xe5 [jbd]
Jul 13 13:23:16 dublin kernel:  <f88c317b> walk_page_buffers+0x4b/0x64 [ext3]  <f88c5a65> ext3_ordered_commit_write+0x5d/0xda [ext3]
Jul 13 13:23:16 dublin kernel:  <f88c3cc1> ext3_journal_dirty_data+0x0/0x32 [ext3]  <c044e144> generic_file_buffered_write+0x3b2/0x5c5
Jul 13 13:23:31 dublin kernel:  <c0429a76> current_fs_time+0x4f/0x59  <c044e73c> __generic_file_aio_write_nolock+0x3e5/0x42f
Jul 13 13:23:47 dublin kernel:  <c044e7e3> generic_file_aio_write+0x5d/0xbb  <f88c2004> ext3_file_write+0x24/0x92 [ext3]
Jul 13 13:24:03 dublin kernel:  <c046b2da> do_sync_write+0xc3/0xfd  <c04363a8> autoremove_wake_function+0x0/0x35
Jul 13 13:24:03 dublin kernel:  <c046b217> do_sync_write+0x0/0xfd  <c046bbc0> vfs_write+0xa8/0x150
Jul 13 13:24:18 dublin kernel:  <c046c1d9> sys_write+0x41/0x67  <c0403e3f> syscall_call+0x7/0xb
Jul 13 13:24:34 dublin kernel: BUG: spinlock lockup on CPU#0, mc/19488, f74c1b54 (Not tainted)
Jul 13 13:24:34 dublin kernel:  <c04eaaa9> _raw_spin_lock+0xc6/0xe1  <f882da0d> journal_dirty_data+0x4f/0x1eb [jbd]
Jul 13 13:24:49 dublin kernel:  <f88c3cd0> ext3_journal_dirty_data+0xf/0x32 [ext3]  <f882d1d4> journal_start+0xba/0xe5 [jbd]
Jul 13 13:24:49 dublin kernel:  <f88c317b> walk_page_buffers+0x4b/0x64 [ext3]  <f88c5a65> ext3_ordered_commit_write+0x5d/0xda [ext3]
Jul 13 13:25:05 dublin kernel:  <f88c3cc1> ext3_journal_dirty_data+0x0/0x32 [ext3]  <c044e144> generic_file_buffered_write+0x3b2/0x5c5
Jul 13 13:25:05 dublin kernel:  <c0429a76> current_fs_time+0x4f/0x59  <c044e73c> __generic_file_aio_write_nolock+0x3e5/0x42f
Jul 13 13:25:20 dublin kernel:  <c044e7e3> generic_file_aio_write+0x5d/0xbb  <f88c2004> ext3_file_write+0x24/0x92 [ext3]
Jul 13 13:25:20 dublin kernel:  <c046b2da> do_sync_write+0xc3/0xfd  <c04363a8> autoremove_wake_function+0x0/0x35
Jul 13 13:25:36 dublin kernel:  <c046b217> do_sync_write+0x0/0xfd  <c046bbc0> vfs_write+0xa8/0x150
Jul 13 13:25:51 dublin kernel:  <c046c1d9> sys_write+0x41/0x67  <c0403e3f> syscall_call+0x7/0xb
Jul 13 14:08:21 dublin syslogd 1.4.1: restart.
Jul 13 14:08:21 dublin kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul 13 14:08:21 dublin kernel: Linux version 2.6.17-1.2145_FC5smp (brewbuilder@hs20-bc2-2.build.redhat.com) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 SMP Sat Jul 1 13:19
:14 EDT 2006



Jul 22 03:48:54 dublin kernel: BUG: unable to handle kernel paging request at virtual address 00080000
Jul 22 03:48:54 dublin kernel:  printing eip:
Jul 22 03:48:54 dublin kernel: f882fbaf
Jul 22 03:48:54 dublin kernel: *pde = 375fa001
Jul 22 03:48:54 dublin kernel: Oops: 0000 [#1]
Jul 22 03:48:54 dublin kernel: SMP
Jul 22 03:48:54 dublin kernel: last sysfs file: /block/hda/removable
Jul 22 03:48:54 dublin kernel: Modules linked in: autofs4 hidp rfcomm l2cap bluetooth sunrpc ipv6 ip_conntrack_netbios_ns ipt_MASQUERADE iptable_nat ip_nat iptable_mangle ipt_LO
G xt_tcpudp xt_state ip_conntrack nfnetlink xt_multiport iptable_filter ip_tables x_tables dm_mirror dm_mod lp parport_pc parport st snd_intel8x0 snd_ac97_codec snd_ac97_bus snd
_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq natsemi aic7xxx scsi_transport_spi hw_random snd_seq_device sg e1000 snd_pcm_oss snd_mixer_oss uhci_hcd i82875p_edac edac_mc eh
ci_hcd snd_pcm snd_timer snd i6300esb soundcore snd_page_alloc i2c_i801 i2c_core ext3 jbd sata_promise ata_piix libata sd_mod scsi_mod
Jul 22 03:48:54 dublin kernel: CPU:    1
Jul 22 03:48:54 dublin kernel: EIP:    0060:[<f882fbaf>]    Not tainted VLI
Jul 22 03:48:54 dublin kernel: EFLAGS: 00010206   (2.6.17-1.2145_FC5smp #1)
Jul 22 03:48:54 dublin kernel: EIP is at __journal_remove_checkpoint+0xe/0x74 [jbd]
Jul 22 03:48:54 dublin kernel: eax: d03d27f0   ebx: d03d27f0   ecx: 00080000   edx: 00000001
Jul 22 03:48:54 dublin kernel: esi: d03d27f0   edi: c1289ce0   ebp: d03d27f0   esp: f7f4ae10
Jul 22 03:48:54 dublin kernel: ds: 007b   es: 007b   ss: 0068
Jul 22 03:48:54 dublin kernel: Process kswapd0 (pid: 109, threadinfo=f7f4a000 task=f7efb930)
Jul 22 03:48:54 dublin kernel: Stack: d03edd38 d03edd38 d03d27f0 f882e0dd c1289cb8 00000246 01013d6c c1289cb8
Jul 22 03:48:54 dublin kernel:        ee0ebae4 f74a4200 d03edd38 f88c5864 000000d0 c06d9d00 00000001 c046cc93
Jul 22 03:48:54 dublin kernel:        c1289ce0 ee0ebae4 c04553f9 f7f4af48 c04e5856 f7646af8 00000002 f7f4af8c
Jul 22 03:48:54 dublin kernel: Call Trace:
Jul 22 03:48:54 dublin kernel:  <f882e0dd> journal_try_to_free_buffers+0xe5/0x14a [jbd]  <f88c5864> ext3_releasepage+0x0/0x7b [ext3]
Jul 22 03:48:54 dublin kernel:  <c046cc93> try_to_release_page+0x34/0x46  <c04553f9> shrink_zone+0x9ba/0xe36
Jul 22 03:48:54 dublin kernel:  <c04e5856> __bitmap_weight+0x2e/0x64  <c04546bc> shrink_slab+0x62/0x14a
Jul 22 03:48:54 dublin kernel:  <c0455a6c> balance_pgdat+0x1f7/0x320  <c0455d2d> kswapd+0xdf/0xe1
Jul 22 03:48:54 dublin kernel:  <c04363a8> autoremove_wake_function+0x0/0x35  <c0455c4e> kswapd+0x0/0xe1
Jul 22 03:48:54 dublin kernel:  <c0402005> kernel_thread_helper+0x5/0xb
Jul 22 03:48:54 dublin kernel: Code: cb 3b 83 f8 e8 35 5f bf c7 0f 0b 79 02 94 3b 83 f8 83 c4 14 89 d8 5b 5e e9 6c 75 c3 c7 56 53 89 c3 83 ec 04 8b 48 28 85 c9 74 62 <8b> 31 8b
53 30 c7 40 28 00 00 00 00 8b 40 2c 89 50 30 8b 53 30
Jul 22 03:48:54 dublin kernel: EIP: [<f882fbaf>] __journal_remove_checkpoint+0xe/0x74 [jbd] SS:ESP 0068:f7f4ae10





