Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVJYUYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVJYUYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVJYUYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:24:50 -0400
Received: from bellatrix7.j.pl ([80.190.214.98]:49645 "EHLO wb.pl")
	by vger.kernel.org with ESMTP id S932345AbVJYUYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:24:49 -0400
Message-ID: <435E9478.1060104@wb.pl>
Date: Tue, 25 Oct 2005 22:24:24 +0200
From: Tomasz Karwot <adminek@wb.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Bad page state
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oct 24 08:26:01 skretka kernel: Bad page state at free_hot_cold_page (in 
process 'java', page c101b7e0) - (Not only this process, other too 
(firefox etc...))
Oct 24 08:26:01 skretka kernel: flags:0x0000080c mapping:00000000 
mapcount:0 count:0
Oct 24 08:26:01 skretka kernel: Backtrace:
Oct 24 08:26:01 skretka kernel:  [<c0134fe4>] bad_page+0x74/0xb0
Oct 24 08:26:01 skretka kernel:  [<c01356a0>] free_hot_cold_page+0x60/0xe0
Oct 24 08:26:01 skretka kernel:  [<c0131b13>] 
do_generic_mapping_read+0x3f3/0x580
Oct 24 08:26:01 skretka kernel:  [<c02a5174>] ide_do_request+0x1e4/0x370
Oct 24 08:26:01 skretka kernel:  [<c0131f41>] 
__generic_file_aio_read+0x1c1/0x200
Oct 24 08:26:01 skretka kernel:  [<c0131ca0>] file_read_actor+0x0/0xe0
Oct 24 08:26:01 skretka kernel:  [<c0131fda>] 
generic_file_aio_read+0x5a/0x80
Oct 24 08:26:01 skretka kernel:  [<c014d557>] do_sync_read+0xc7/0x110
Oct 24 08:26:01 skretka kernel:  [<c0127020>] 
autoremove_wake_function+0x0/0x60
Oct 24 08:26:01 skretka kernel:  [<c0156f47>] sys_fstat64+0x37/0x40
Oct 24 08:26:01 skretka kernel:  [<c014d647>] vfs_read+0xa7/0x180
Oct 24 08:26:01 skretka kernel:  [<c014da01>] sys_read+0x51/0x80
Oct 24 08:26:01 skretka kernel:  [<c0102cd5>] syscall_call+0x7/0xb
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel: Bad page state at prep_new_page (in 
process 'java', page c10007a0)
Oct 24 08:26:01 skretka kernel: flags:0x00000000 mapping:00000000 
mapcount:0 count:1
Oct 24 08:26:01 skretka kernel: Backtrace:
Oct 24 08:26:01 skretka kernel:  [<c0134fe4>] bad_page+0x74/0xb0
Oct 24 08:26:01 skretka kernel:  [<c0135310>] prep_new_page+0x30/0x70
Oct 24 08:26:01 skretka kernel:  [<c0135828>] buffered_rmqueue+0xe8/0x1a0
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel: Bad page state at prep_new_page (in 
process 'java', page c101f260)
Oct 24 08:26:01 skretka kernel: flags:0x00000000 mapping:00000000 
mapcount:0 count:1
Oct 24 08:26:01 skretka kernel: Backtrace:
Oct 24 08:26:01 skretka kernel:  [<c0134fe4>] bad_page+0x74/0xb0
Oct 24 08:26:01 skretka kernel:  [<c0135310>] prep_new_page+0x30/0x70
Oct 24 08:26:01 skretka kernel:  [<c0135828>] buffered_rmqueue+0xe8/0x1a0
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel: Bad page state at prep_new_page (in 
process 'java', page c100c480)
Oct 24 08:26:01 skretka kernel: flags:0x00000000 mapping:00000000 
mapcount:0 count:1
Oct 24 08:26:01 skretka kernel: Backtrace:
Oct 24 08:26:01 skretka kernel:  [<c0134fe4>] bad_page+0x74/0xb0
Oct 24 08:26:01 skretka kernel:  [<c0135310>] prep_new_page+0x30/0x70
Oct 24 08:26:01 skretka kernel:  [<c0135828>] buffered_rmqueue+0xe8/0x1a0
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel: Bad page state at prep_new_page (in 
process 'java', page c101e5e0)
Oct 24 08:26:01 skretka kernel: flags:0x00000000 mapping:00000000 
mapcount:0 count:1
Oct 24 08:26:01 skretka kernel: Backtrace:
Oct 24 08:26:01 skretka kernel:  [<c0134fe4>] bad_page+0x74/0xb0
Oct 24 08:26:01 skretka kernel:  [<c0135310>] prep_new_page+0x30/0x70
Oct 24 08:26:01 skretka kernel:  [<c0135828>] buffered_rmqueue+0xe8/0x1a0
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel: Bad page state at prep_new_page (in 
process 'java', page c100f1e0)
Oct 24 08:26:01 skretka kernel: flags:0x00000000 mapping:00000000 
mapcount:0 count:1
Oct 24 08:26:01 skretka kernel: Backtrace:
Oct 24 08:26:01 skretka kernel:  [<c0134fe4>] bad_page+0x74/0xb0
Oct 24 08:26:01 skretka kernel:  [<c0135310>] prep_new_page+0x30/0x70
Oct 24 08:26:01 skretka kernel:  [<c0135828>] buffered_rmqueue+0xe8/0x1a0
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel: Bad page state at prep_new_page (in 
process 'java', page c1019a20)
Oct 24 08:26:01 skretka kernel: flags:0x00000000 mapping:00000000 
mapcount:0 count:1
Oct 24 08:26:01 skretka kernel: Backtrace:
Oct 24 08:26:01 skretka kernel:  [<c0134fe4>] bad_page+0x74/0xb0
Oct 24 08:26:01 skretka kernel:  [<c0135310>] prep_new_page+0x30/0x70
Oct 24 08:26:01 skretka kernel:  [<c0135828>] buffered_rmqueue+0xe8/0x1a0
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel: Bad page state at prep_new_page (in 
process 'java', page c101bb60)
Oct 24 08:26:01 skretka kernel: flags:0x00000000 mapping:00000000 
mapcount:0 count:1
Oct 24 08:26:01 skretka kernel: Backtrace:
Oct 24 08:26:01 skretka kernel:  [<c0134fe4>] bad_page+0x74/0xb0
Oct 24 08:26:01 skretka kernel:  [<c0135310>] prep_new_page+0x30/0x70
Oct 24 08:26:01 skretka kernel:  [<c0135828>] buffered_rmqueue+0xe8/0x1a0
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel: Bad page state at prep_new_page (in 
process 'java', page c101e6c0)
Oct 24 08:26:01 skretka kernel: flags:0x00000000 mapping:00000000 
mapcount:0 count:1
Oct 24 08:26:01 skretka kernel: Backtrace:
Oct 24 08:26:01 skretka kernel:  [<c0134fe4>] bad_page+0x74/0xb0
Oct 24 08:26:01 skretka kernel:  [<c0135310>] prep_new_page+0x30/0x70
Oct 24 08:26:01 skretka kernel:  [<c0135828>] buffered_rmqueue+0xe8/0x1a0
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Trying to fix it up, but a reboot is needed
Oct 24 08:26:01 skretka kernel: ------------[ cut here ]------------
Oct 24 08:26:01 skretka kernel: kernel BUG at mm/page_alloc.c:718!
Oct 24 08:26:01 skretka kernel: invalid operand: 0000 [#3]
Oct 24 08:26:01 skretka kernel: Modules linked in: snd_pcm_oss 
snd_mixer_oss ipv6 parport_pc parport 8250_pnp 8250 serial_core via_agp 
pci_hotplug snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer 
snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
i2c_viapro i2c_core nvidia nvidiafb nls_iso8859_2 nls_cp852 
ip_nat_snmp_basic ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc 
ip_conntrack_ftp ipt_conntrack ip_conntrack ip_tables agpgart evdev
Oct 24 08:26:01 skretka kernel: CPU:    0
Oct 24 08:26:01 skretka kernel: EIP:    0060:[<c013587b>]    Tainted: 
P    B VLI
Oct 24 08:26:01 skretka kernel: EFLAGS: 00210202   (2.6.13.4)
Oct 24 08:26:01 skretka kernel: EIP is at buffered_rmqueue+0x13b/0x1a0
Oct 24 08:26:01 skretka kernel: eax: 00000001   ebx: c03bc938   ecx: 
00000000   edx: 00003c50
Oct 24 08:26:01 skretka kernel: esi: 00200206   edi: c03bc954   ebp: 
c03bc920   esp: d4029da0
Oct 24 08:26:01 skretka kernel: ds: 007b   es: 007b   ss: 0068
Oct 24 08:26:01 skretka kernel: Process java (pid: 4290, 
threadinfo=d4028000 task=d473d530)
Oct 24 08:26:01 skretka kernel: Stack: c03bc920 c1078a00 00000001 
c03bc964 c1078a00 c03bc920 00000000 00000001
Oct 24 08:26:01 skretka kernel:        000201d2 c0135db8 c03bc920 
00000000 000201d2 00000001 00000000 00000000
Oct 24 08:26:01 skretka kernel:        00000001 00000000 d473d530 
00000010 c03bccc4 00000000 c03bc94c 000002ea
Oct 24 08:26:01 skretka kernel: Call Trace:
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Code: f8 05 c1 e0 0c 2d 00 00 00 40 89 
04 24 e8 de 3c 0e 00 4b 75 df 8b 44 24 10 83 c4 14 5b 5e 5f 5d c3 0f 0b 
a5 02 ee 09 36 c0 eb c1 <0f> 0b ce 02 ee 09 36 c0 e9 4a ff ff ff 9c 5e 
fa 89 2c 24 8b 4c
Oct 24 08:26:01 skretka kernel:  ------------[ cut here ]------------
Oct 24 08:26:01 skretka kernel: kernel BUG at mm/page_alloc.c:718!
Oct 24 08:26:01 skretka kernel: invalid operand: 0000 [#4]
Oct 24 08:26:01 skretka kernel: Modules linked in: snd_pcm_oss 
snd_mixer_oss ipv6 parport_pc parport 8250_pnp 8250 serial_core via_agp 
pci_hotplug snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer 
snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
i2c_viapro i2c_core nvidia nvidiafb nls_iso8859_2 nls_cp852 
ip_nat_snmp_basic ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc 
ip_conntrack_ftp ipt_conntrack ip_conntrack ip_tables agpgart evdev
Oct 24 08:26:01 skretka kernel: CPU:    0
Oct 24 08:26:01 skretka kernel: EIP:    0060:[<c013587b>]    Tainted: 
P    B VLI
Oct 24 08:26:01 skretka kernel: EFLAGS: 00210202   (2.6.13.4)
Oct 24 08:26:01 skretka kernel: EIP is at buffered_rmqueue+0x13b/0x1a0
Oct 24 08:26:01 skretka kernel: eax: 00000001   ebx: c03bc938   ecx: 
00000000   edx: 0000f7b7
Oct 24 08:26:01 skretka kernel: esi: 00200206   edi: c03bc954   ebp: 
c03bc920   esp: cbb47da0
Oct 24 08:26:01 skretka kernel: ds: 007b   es: 007b   ss: 0068
Oct 24 08:26:01 skretka kernel: Process java (pid: 4284, 
threadinfo=cbb46000 task=cd4c6570)
Oct 24 08:26:01 skretka kernel: Stack: c03bc920 c11ef6e0 00000001 
c03bc964 c11ef6e0 c03bc920 00000000 00000001
Oct 24 08:26:01 skretka kernel:        000201d2 c0135db8 c03bc920 
00000000 000201d2 00000001 00000000 00000000
Oct 24 08:26:01 skretka kernel:        00000001 00000000 cd4c6570 
00000010 c03bccc4 00000000 00000008 000002d7
Oct 24 08:26:01 skretka kernel: Call Trace:
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034a2e4>] schedule+0x324/0x5b0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Code: f8 05 c1 e0 0c 2d 00 00 00 40 89 
04 24 e8 de 3c 0e 00 4b 75 df 8b 44 24 10 83 c4 14 5b 5e 5f 5d c3 0f 0b 
a5 02 ee 09 36 c0 eb c1 <0f> 0b ce 02 ee 09 36 c0 e9 4a ff ff ff 9c 5e 
fa 89 2c 24 8b 4c
Oct 24 08:26:01 skretka kernel:  ------------[ cut here ]------------
Oct 24 08:26:01 skretka kernel: kernel BUG at mm/page_alloc.c:718!
Oct 24 08:26:01 skretka kernel: invalid operand: 0000 [#5]
Oct 24 08:26:01 skretka kernel: Modules linked in: snd_pcm_oss 
snd_mixer_oss ipv6 parport_pc parport 8250_pnp 8250 serial_core via_agp 
pci_hotplug snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer 
snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
i2c_viapro i2c_core nvidia nvidiafb nls_iso8859_2 nls_cp852 
ip_nat_snmp_basic ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc 
ip_conntrack_ftp ipt_conntrack ip_conntrack ip_tables agpgart evdev
Oct 24 08:26:01 skretka kernel: CPU:    0
Oct 24 08:26:01 skretka kernel: EIP:    0060:[<c013587b>]    Tainted: 
P    B VLI
Oct 24 08:26:01 skretka kernel: EFLAGS: 00210202   (2.6.13.4)
Oct 24 08:26:01 skretka kernel: EIP is at buffered_rmqueue+0x13b/0x1a0
Oct 24 08:26:01 skretka kernel: eax: 00000001   ebx: c03bc938   ecx: 
00000000   edx: 0000f7b6
Oct 24 08:26:01 skretka kernel: esi: 00200206   edi: c03bc954   ebp: 
c03bc920   esp: d3ad5da0
Oct 24 08:26:01 skretka kernel: ds: 007b   es: 007b   ss: 0068
Oct 24 08:26:01 skretka kernel: Process java (pid: 4274, 
threadinfo=d3ad4000 task=c0c65550)
Oct 24 08:26:01 skretka kernel: Stack: c03bc920 c11ef6c0 00000001 
c03bc964 c11ef6c0 c03bc920 00000000 00000001
Oct 24 08:26:01 skretka kernel:        000201d2 c0135db8 c03bc920 
00000000 000201d2 00000001 00000000 00000000
Oct 24 08:26:01 skretka kernel:        00000001 00000000 c0c65550 
00000010 c03bccc4 00000000 00000008 000002d7
Oct 24 08:26:01 skretka kernel: Call Trace:
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034a2e4>] schedule+0x324/0x5b0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Code: f8 05 c1 e0 0c 2d 00 00 00 40 89 
04 24 e8 de 3c 0e 00 4b 75 df 8b 44 24 10 83 c4 14 5b 5e 5f 5d c3 0f 0b 
a5 02 ee 09 36 c0 eb c1 <0f> 0b ce 02 ee 09 36 c0 e9 4a ff ff ff 9c 5e 
fa 89 2c 24 8b 4c
Oct 24 08:26:01 skretka kernel:  ------------[ cut here ]------------
Oct 24 08:26:01 skretka kernel: kernel BUG at mm/page_alloc.c:718!
Oct 24 08:26:01 skretka kernel: invalid operand: 0000 [#6]
Oct 24 08:26:01 skretka kernel: Modules linked in: snd_pcm_oss 
snd_mixer_oss ipv6 parport_pc parport 8250_pnp 8250 serial_core via_agp 
pci_hotplug snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer 
snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
i2c_viapro i2c_core nvidia nvidiafb nls_iso8859_2 nls_cp852 
ip_nat_snmp_basic ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc 
ip_conntrack_ftp ipt_conntrack ip_conntrack ip_tables agpgart evdev
Oct 24 08:26:01 skretka kernel: CPU:    0
Oct 24 08:26:01 skretka kernel: EIP:    0060:[<c013587b>]    Tainted: 
P    B VLI
Oct 24 08:26:01 skretka kernel: EFLAGS: 00210202   (2.6.13.4)
Oct 24 08:26:01 skretka kernel: EIP is at buffered_rmqueue+0x13b/0x1a0
Oct 24 08:26:01 skretka kernel: eax: 00000001   ebx: c03bc938   ecx: 
00000000   edx: 0000f7b5
Oct 24 08:26:01 skretka kernel: esi: 00200206   edi: c03bc954   ebp: 
c03bc920   esp: d3cfbda0
Oct 24 08:26:01 skretka kernel: ds: 007b   es: 007b   ss: 0068
Oct 24 08:26:01 skretka kernel: Process java (pid: 4272, 
threadinfo=d3cfa000 task=d473d020)
Oct 24 08:26:01 skretka kernel: Stack: c03bc920 c11ef6a0 00000001 
c03bc964 c11ef6a0 c03bc920 00000000 00000001
Oct 24 08:26:01 skretka kernel:        000201d2 c0135db8 c03bc920 
00000000 000201d2 00000001 00000000 00000000
Oct 24 08:26:01 skretka kernel:        00000001 00000000 d473d020 
00000010 c03bccc4 00000000 d6cb9000 000002d7
Oct 24 08:26:01 skretka kernel: Call Trace:
Oct 24 08:26:01 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:01 skretka kernel:  [<c0138199>] 
__do_page_cache_readahead+0xd9/0x110
Oct 24 08:26:01 skretka kernel:  [<c013863f>] max_sane_readahead+0x2f/0x70
Oct 24 08:26:01 skretka kernel:  [<c0132673>] filemap_nopage+0x2a3/0x370
Oct 24 08:26:01 skretka kernel:  [<c013fdc2>] do_no_page+0xa2/0x2b0
Oct 24 08:26:01 skretka kernel:  [<c0102823>] setup_rt_frame+0x1b3/0x2d0
Oct 24 08:26:01 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:01 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c034ac64>] schedule_timeout+0x64/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f388>] sigprocmask+0x48/0xb0
Oct 24 08:26:01 skretka kernel:  [<c011f472>] sys_rt_sigprocmask+0x82/0xe0
Oct 24 08:26:01 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:01 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:01 skretka kernel: Code: f8 05 c1 e0 0c 2d 00 00 00 40 89 
04 24 e8 de 3c 0e 00 4b 75 df 8b 44 24 10 83 c4 14 5b 5e 5f 5d c3 0f 0b 
a5 02 ee 09 36 c0 eb c1 <0f> 0b ce 02 ee 09 36 c0 e9 4a ff ff ff 9c 5e 
fa 89 2c 24 8b 4c
Oct 24 08:26:01 skretka kernel:  <1>Unable to handle kernel paging 
request at virtual address 00100104
Oct 24 08:26:01 skretka kernel:  printing eip:
Oct 24 08:26:01 skretka kernel: c01356c3
Oct 24 08:26:01 skretka kernel: *pde = 00000000
Oct 24 08:26:01 skretka kernel: Oops: 0002 [#7]
Oct 24 08:26:01 skretka kernel: Modules linked in: snd_pcm_oss 
snd_mixer_oss ipv6 parport_pc parport 8250_pnp 8250 serial_core via_agp 
pci_hotplug snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer 
snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
i2c_viapro i2c_core nvidia nvidiafb nls_iso8859_2 nls_cp852 
ip_nat_snmp_basic ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc 
ip_conntrack_ftp ipt_conntrack ip_conntrack ip_tables agpgart evdev
Oct 24 08:26:01 skretka kernel: CPU:    0
Oct 24 08:26:01 skretka kernel: EIP:    0060:[<c01356c3>]    Tainted: 
P    B VLI
Oct 24 08:26:01 skretka kernel: EFLAGS: 00210046   (2.6.13.4)
Oct 24 08:26:01 skretka kernel: EIP is at free_hot_cold_page+0x83/0xe0
Oct 24 08:26:01 skretka kernel: eax: 00100100   ebx: c03bc920   ecx: 
c03bc94c   edx: c101e578
Oct 24 08:26:01 skretka kernel: esi: c101e560   edi: c03bc93c   ebp: 
00200246   esp: c53eff40
Oct 24 08:26:01 skretka kernel: ds: 007b   es: 007b   ss: 0068
Oct 24 08:26:01 skretka kernel: Process java (pid: 4191, 
threadinfo=c53ee000 task=c5dd55b0)
Oct 24 08:26:01 skretka kernel: Stack: 00000034 00000001 00000008 
d0df8168 c03bc920 c0f2b008 c0f2b008 00000000
Oct 24 08:26:01 skretka kernel:        083ae100 c015fd1a 00000000 
00000000 d0df8168 c0160914 c53eff98 d0df8160
Oct 24 08:26:01 skretka kernel:        c53eff98 0000001a 083ae100 
d0df8160 00000000 00000000 c015fd30 c0f2b000
Oct 24 08:26:01 skretka kernel: Call Trace:
Oct 24 08:26:01 skretka kernel:  [<c015fd1a>] poll_freewait+0x3a/0x50
Oct 24 08:26:01 skretka kernel:  [<c0160914>] sys_poll+0x1e4/0x210
Oct 24 08:26:01 skretka kernel:  [<c015fd30>] __pollwait+0x0/0xd0
Oct 24 08:26:01 skretka kernel:  [<c0102cd5>] syscall_call+0x7/0xb
Oct 24 08:26:01 skretka kernel: Code: f3 34 c0 e8 d0 f8 ff ff 8b 06 a8 
10 74 04 0f ba 36 04 8b 54 24 10 8d 04 5b 8d 1c c2 8d 7b 1c 9c 5d fa 8b 
43 2c 8d 56 18 8d 4b 2c <89> 50 04 89 46 18 89 4a 04 8b 43 1c 89 53 2c 
40 3b 47 08 89 43
Oct 24 08:26:02 skretka kernel:  <1>Unable to handle kernel paging 
request at virtual address 00100100
Oct 24 08:26:02 skretka kernel:  printing eip:
Oct 24 08:26:02 skretka kernel: c0135792
Oct 24 08:26:02 skretka kernel: *pde = 00000000
Oct 24 08:26:02 skretka kernel: Oops: 0000 [#8]
Oct 24 08:26:02 skretka kernel: Modules linked in: snd_pcm_oss 
snd_mixer_oss ipv6 parport_pc parport 8250_pnp 8250 serial_core via_agp 
pci_hotplug snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer 
snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
i2c_viapro i2c_core nvidia nvidiafb nls_iso8859_2 nls_cp852 
ip_nat_snmp_basic ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc 
ip_conntrack_ftp ipt_conntrack ip_conntrack ip_tables agpgart evdev
Oct 24 08:26:02 skretka kernel: CPU:    0
Oct 24 08:26:02 skretka kernel: EIP:    0060:[<c0135792>]    Tainted: 
P    B VLI
Oct 24 08:26:02 skretka kernel: EFLAGS: 00013006   (2.6.13.4)
Oct 24 08:26:02 skretka kernel: EIP is at buffered_rmqueue+0x52/0x1a0
Oct 24 08:26:02 skretka kernel: eax: 00100100   ebx: c03bc920   ecx: 
0000018f   edx: 001000e8
Oct 24 08:26:02 skretka kernel: esi: 00003246   edi: c03bc93c   ebp: 
c03bc920   esp: cf90ddec
Oct 24 08:26:02 skretka kernel: ds: 007b   es: 007b   ss: 0068
Oct 24 08:26:02 skretka kernel: Process X (pid: 4020, 
threadinfo=cf90c000 task=d7049590)
Oct 24 08:26:02 skretka kernel: Stack: c1de4000 00000000 0000001f 
c03bca78 001000e8 c03bc920 00000000 00000001
Oct 24 08:26:02 skretka kernel:        000080d2 c0135db8 c03bc920 
00000000 000080d2 00000001 00000000 00000000
Oct 24 08:26:02 skretka kernel:        00000001 00000000 d7049590 
00000010 c03bccc4 00000000 c103a2e0 00470025
Oct 24 08:26:02 skretka kernel: Call Trace:
Oct 24 08:26:02 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:02 skretka kernel:  [<c013fc5d>] do_anonymous_page+0x4d/0x110
Oct 24 08:26:02 skretka kernel:  [<c013fd83>] do_no_page+0x63/0x2b0
Oct 24 08:26:02 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:02 skretka kernel:  [<d91662ad>] _nv003265rm+0x9d/0xbc [nvidia]
Oct 24 08:26:02 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:02 skretka kernel:  [<c011cb90>] process_timeout+0x0/0x10
Oct 24 08:26:02 skretka kernel:  [<c034a2e4>] schedule+0x324/0x5b0
Oct 24 08:26:02 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:02 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:02 skretka kernel: Code: 00 00 8d 04 12 01 d0 8d 5c c5 00 
8d 7b 1c 9c 5e fa 8b 43 1c 3b 47 04 0f 8e 2b 01 00 00 85 c0 74 24 8b 47 
10 8d 50 e8 89 54 24 10 <8b> 10 8b 48 04 89 4a 04 89 11 c7 40 04 00 02 
20 00 c7 00 00 01
Oct 24 08:26:02 skretka kernel:  <1>Unable to handle kernel paging 
request at virtual address 00100104
Oct 24 08:26:02 skretka kernel:  printing eip:
Oct 24 08:26:02 skretka kernel: c01356c3
Oct 24 08:26:02 skretka kernel: *pde = 00000000
Oct 24 08:26:02 skretka kernel: Oops: 0002 [#9]
Oct 24 08:26:02 skretka kernel: Modules linked in: snd_pcm_oss 
snd_mixer_oss ipv6 parport_pc parport 8250_pnp 8250 serial_core via_agp 
pci_hotplug snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer 
snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
i2c_viapro i2c_core nvidia nvidiafb nls_iso8859_2 nls_cp852 
ip_nat_snmp_basic ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc 
ip_conntrack_ftp ipt_conntrack ip_conntrack ip_tables agpgart evdev
Oct 24 08:26:02 skretka kernel: CPU:    0
Oct 24 08:26:02 skretka kernel: EIP:    0060:[<c01356c3>]    Tainted: 
P    B VLI
Oct 24 08:26:02 skretka kernel: EFLAGS: 00013003   (2.6.13.4)
Oct 24 08:26:02 skretka kernel: EIP is at free_hot_cold_page+0x83/0xe0
Oct 24 08:26:02 skretka kernel: eax: 00100100   ebx: c03bc920   ecx: 
c03bc94c   edx: c1009858
Oct 24 08:26:02 skretka kernel: esi: c1009840   edi: c03bc93c   ebp: 
00003203   esp: cf90db9c
Oct 24 08:26:02 skretka kernel: ds: 007b   es: 007b   ss: 0068
Oct 24 08:26:02 skretka kernel: Process X (pid: 4020, 
threadinfo=cf90c000 task=d7049590)
Oct 24 08:26:02 skretka kernel: Stack: 00000034 00000001 c03bca78 
00000000 c03bc920 c2ee4668 0899a000 c1009840
Oct 24 08:26:02 skretka kernel:        004c2067 c013e7c8 c1009840 
00000000 d6e78088 08c00000 08c48000 08c47fff
Oct 24 08:26:02 skretka kernel:        c013e91a c0474348 d6e78088 
08848000 08c00000 00000000 00400000 08c48000
Oct 24 08:26:02 skretka kernel: Call Trace:
Oct 24 08:26:02 skretka kernel:  [<c013e7c8>] zap_pte_range+0xd8/0x1a0
Oct 24 08:26:02 skretka kernel:  [<c013e91a>] unmap_page_range+0x8a/0xb0
Oct 24 08:26:02 skretka kernel:  [<c013ea29>] unmap_vmas+0xe9/0x1e0
Oct 24 08:26:02 skretka kernel:  [<c0142f69>] exit_mmap+0x79/0x150
Oct 24 08:26:02 skretka kernel:  [<c01125bc>] mmput+0x2c/0x80
Oct 24 08:26:02 skretka kernel:  [<c0116638>] do_exit+0xd8/0x380
Oct 24 08:26:02 skretka kernel:  [<c0114827>] printk+0x17/0x20
Oct 24 08:26:02 skretka kernel:  [<c010366a>] die+0x14a/0x150
Oct 24 08:26:02 skretka kernel:  [<c0114827>] printk+0x17/0x20
Oct 24 08:26:02 skretka kernel:  [<c010fb27>] do_page_fault+0x2e7/0x5e7
Oct 24 08:26:02 skretka kernel:  [<d8fd9bfd>] _nv002168rm+0x1d/0x2c [nvidia]
Oct 24 08:26:02 skretka kernel:  [<d91148ab>] _nv004517rm+0x23/0x28 [nvidia]
Oct 24 08:26:02 skretka kernel:  [<d9114801>] _nv004519rm+0x19/0x40 [nvidia]
Oct 24 08:26:02 skretka kernel:  [<c0110b65>] activate_task+0x65/0x80
Oct 24 08:26:02 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:02 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:02 skretka kernel:  [<c0135792>] buffered_rmqueue+0x52/0x1a0
Oct 24 08:26:02 skretka kernel:  [<c0135db8>] __alloc_pages+0x438/0x480
Oct 24 08:26:02 skretka kernel:  [<c013fc5d>] do_anonymous_page+0x4d/0x110
Oct 24 08:26:02 skretka kernel:  [<c013fd83>] do_no_page+0x63/0x2b0
Oct 24 08:26:02 skretka kernel:  [<c01401ae>] __handle_mm_fault+0xde/0x150
Oct 24 08:26:02 skretka kernel:  [<d91662ad>] _nv003265rm+0x9d/0xbc [nvidia]
Oct 24 08:26:02 skretka kernel:  [<c010f9cc>] do_page_fault+0x18c/0x5e7
Oct 24 08:26:02 skretka kernel:  [<c011cb90>] process_timeout+0x0/0x10
Oct 24 08:26:02 skretka kernel:  [<c034a2e4>] schedule+0x324/0x5b0
Oct 24 08:26:02 skretka kernel:  [<c010f840>] do_page_fault+0x0/0x5e7
Oct 24 08:26:02 skretka kernel:  [<c0102eef>] error_code+0x4f/0x54
Oct 24 08:26:02 skretka kernel: Code: f3 34 c0 e8 d0 f8 ff ff 8b 06 a8 
10 74 04 0f ba 36 04 8b 54 24 10 8d 04 5b 8d 1c c2 8d 7b 1c 9c 5d fa 8b 
43 2c 8d 56 18 8d 4b 2c <89> 50 04 89 46 18 89 4a 04 8b 43 1c 89 53 2c 
40 3b 47 08 89 43
Oct 24 08:26:02 skretka kernel:  <1>Fixing recursive fault but reboot is 
needed!

cat /proc/version
Linux version 2.6.13.4 (root@skretka) (gcc version 3.3.4) #2 Mon Oct 17 
19:58:32 CEST 2005 (this 'bug' in all 2.6 kernels what I use [I know, my 
english is terrible)

cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2000+
stepping        : 1
cpu MHz         : 1875.300
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmxfxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3755.37

cat /proc/modules
snd_pcm_oss 47264 0 - Live 0xd8cad000
snd_mixer_oss 16960 2 snd_pcm_oss, Live 0xd8c98000
ipv6 229568 171 - Live 0xd8cdb000
parport_pc 31940 0 - Live 0xd8c84000
parport 31496 1 parport_pc, Live 0xd8c8f000
8250_pnp 8192 0 - Live 0xd8c38000
8250 20004 1 8250_pnp, Live 0xd8c7e000
serial_core 18240 1 8250, Live 0xd8c78000
via_agp 7744 1 - Live 0xd8c35000
pci_hotplug 9796 0 - Live 0xd8c31000
snd_cmipci 29760 2 - Live 0xd8c3b000
snd_pcm 78984 2 snd_pcm_oss,snd_cmipci, Live 0xd8c49000
snd_page_alloc 8392 1 snd_pcm, Live 0xd8c27000
snd_opl3_lib 9152 1 snd_cmipci, Live 0xd8c23000
snd_timer 20356 2 snd_pcm,snd_opl3_lib, Live 0xd8c2b000
snd_hwdep 7072 1 snd_opl3_lib, Live 0xd8c0a000
snd_mpu401_uart 6016 1 snd_cmipci, Live 0xd8c07000
snd_rawmidi 19872 1 snd_mpu401_uart, Live 0xd8c0e000
snd_seq_device 7180 2 snd_opl3_lib,snd_rawmidi, Live 0xd8bb4000
snd 45540 12 
snd_pcm_oss,snd_mixer_oss,snd_cmipci,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xd8c16000
soundcore 7008 2 snd, Live 0xd8baa000
i2c_viapro 6800 0 - Live 0xd8ba7000
i2c_core 16912 1 i2c_viapro, Live 0xd8bae000
nvidia 3706248 12 - Live 0xd8fc6000
nvidiafb 48476 0 - Live 0xd8bb8000
nls_iso8859_2 4416 2 - Live 0xd887b000
nls_cp852 4672 2 - Live 0xd8878000
ip_nat_snmp_basic 10500 0 - Live 0xd8874000
ip_nat_irc 2112 0 - Live 0xd8860000
ip_nat_ftp 2752 0 - Live 0xd8804000
iptable_nat 20564 2 ip_nat_irc,ip_nat_ftp, Live 0xd8857000
ip_conntrack_irc 70800 1 ip_nat_irc, Live 0xd8b94000
ip_conntrack_ftp 71568 1 ip_nat_ftp, Live 0xd8b81000
ipt_conntrack 2112 0 - Live 0xd8806000
ip_conntrack 38712 7 
ip_nat_snmp_basic,ip_nat_irc,ip_nat_ftp,iptable_nat,ip_conntrack_irc,ip_conntrack_ftp,ipt_conntrack, 
Live 0xd8864000
ip_tables 17920 2 iptable_nat,ipt_conntrack, Live 0xd8851000
agpgart 29320 2 via_agp,nvidia, Live 0xd8848000
evdev 7296 0 - Live 0xd881a000

cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
4000-407f : 0000:00:11.0
  4000-407f : motherboard
    4000-4003 : PM1a_EVT_BLK
    4008-400b : PM_TMR
    4010-4015 : ACPI CPU throttle
    4020-4023 : GPE0_BLK
40f0-40f1 : PM1a_CNT_BLK
5000-500f : 0000:00:11.0
  5000-500f : motherboard
    5000-500f : pnp 00:01
      5000-5007 : viapro-smbus
d000-d0ff : 0000:00:09.0
  d000-d0ff : 8139too
d400-d4ff : 0000:00:0b.0
  d400-d4ff : CMI8738
e400-e40f : 0000:00:11.1
  e400-e407 : ide0
  e408-e40f : ide1
e800-e8ff : 0000:00:12.0
  e800-e8ff : via-rhine

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-0034bc06 : Kernel code
  0034bc07-00441fe7 : Kernel data
17ff0000-17ff2fff : ACPI Non-volatile Storage
17ff3000-17ffffff : ACPI Tables
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
    e0000000-e7ffffff : vesafb
e8000000-ebffffff : 0000:00:00.0
ec000000-edffffff : PCI Bus #01
  ec000000-ecffffff : 0000:01:00.0
    ec000000-ecffffff : nvidia
  ed000000-ed01ffff : 0000:01:00.0
ee000000-ee0000ff : 0000:00:09.0
  ee000000-ee0000ff : 8139too
ee002000-ee0020ff : 0000:00:12.0
  ee002000-ee0020ff : via-rhine
ffff0000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown 
device a232
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW-AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- 
Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at ee000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown 
device a232
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown 
device a232
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at e400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 74)
        Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded 
Ethernet Controller on VT8235
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at ee002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 
5200] (rev a1) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at ed000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x4
