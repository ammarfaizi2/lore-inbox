Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264567AbTLCNTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 08:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTLCNTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 08:19:32 -0500
Received: from chico.rediris.es ([130.206.1.3]:53706 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S264567AbTLCNTJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 08:19:09 -0500
From: David =?iso-8859-15?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: linux-kernel@vger.kernel.org
Subject: Errors and later panics in 2.6.0-test11.
Date: Wed, 3 Dec 2003 14:17:18 +0100
User-Agent: KMail/1.5.4
Cc: ender@debian.org, clubinfo.servers@adi.uam.es
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312031417.18462.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

	Hello again. I'm testing 2.6.0-test11 in one of my servers. In about a day or
so under a web/FTP server load, the kernel starts to spit messages:

Dec  2 22:07:25 ulises kernel: Bad page state at prep_new_page
Dec  2 22:07:25 ulises kernel: flags:0x0102002c mapping:d50c8a28 mapped:0 count:1
Dec  2 22:07:25 ulises kernel: Backtrace:
Dec  2 22:07:25 ulises kernel: Call Trace:
Dec  2 22:07:25 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
Dec  2 22:07:25 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
Dec  2 22:07:25 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
Dec  2 22:07:25 ulises kernel:  [find_get_page+26/37] find_get_page+0x1a/0x25
Dec  2 22:07:25 ulises kernel:  [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
Dec  2 22:07:25 ulises kernel:  [do_wp_page+168/674] do_wp_page+0xa8/0x2a2
Dec  2 22:07:25 ulises kernel:  [handle_mm_fault+293/308] handle_mm_fault+0x125/0x134
Dec  2 22:07:25 ulises kernel:  [do_page_fault+288/1264] do_page_fault+0x120/0x4f0
Dec  2 22:07:25 ulises kernel:  [dentry_open+246/334] dentry_open+0xf6/0x14e
Dec  2 22:07:25 ulises kernel:  [filp_open+98/100] filp_open+0x62/0x64
Dec  2 22:07:25 ulises kernel:  [do_fcntl+188/394] do_fcntl+0xbc/0x18a
Dec  2 22:07:25 ulises kernel:  [sys_fcntl64+87/149] sys_fcntl64+0x57/0x95
Dec  2 22:07:25 ulises kernel:  [do_page_fault+0/1264] do_page_fault+0x0/0x4f0
Dec  2 22:07:25 ulises kernel:  [error_code+45/56] error_code+0x2d/0x38
Dec  2 22:07:25 ulises kernel:
Dec  2 22:07:25 ulises kernel: Trying to fix it up, but a reboot is needed
Dec  2 22:07:28 ulises kernel: Bad page state at prep_new_page
Dec  2 22:07:28 ulises kernel: flags:0x0102002c mapping:d348b8a8 mapped:0 count:1
Dec  2 22:07:28 ulises kernel: Backtrace:
Dec  2 22:07:28 ulises kernel: Call Trace:
Dec  2 22:07:28 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
Dec  2 22:07:28 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
Dec  2 22:07:28 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
Dec  2 22:07:28 ulises kernel:  [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
Dec  2 22:07:28 ulises kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Dec  2 22:07:28 ulises kernel:  [__pollwait+133/198] __pollwait+0x85/0xc6
Dec  2 22:07:28 ulises kernel:  [datagram_poll+43/202] datagram_poll+0x2b/0xca
Dec  2 22:07:28 ulises kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Dec  2 22:07:28 ulises kernel:  [do_pollfd+140/144] do_pollfd+0x8c/0x90
Dec  2 22:07:28 ulises kernel:  [do_poll+97/192] do_poll+0x61/0xc0
Dec  2 22:07:28 ulises kernel:  [sys_poll+405/651] sys_poll+0x195/0x28b
Dec  2 22:07:28 ulises kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Dec  2 22:07:28 ulises kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Dec  2 22:07:28 ulises kernel:
Dec  2 22:07:28 ulises kernel: Trying to fix it up, but a reboot is needed
Dec  2 22:07:45 ulises kernel: Bad page state at prep_new_page
Dec  2 22:07:45 ulises kernel: flags:0x0102002c mapping:d348b8a8 mapped:0 count:1
Dec  2 22:07:45 ulises kernel: Backtrace:
Dec  2 22:07:45 ulises kernel: Call Trace:
Dec  2 22:07:45 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
Dec  2 22:07:45 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
Dec  2 22:07:45 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
Dec  2 22:07:45 ulises kernel:  [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
Dec  2 22:07:45 ulises kernel:  [do_wp_page+168/674] do_wp_page+0xa8/0x2a2
Dec  2 22:07:45 ulises kernel:  [handle_mm_fault+293/308] handle_mm_fault+0x125/0x134
Dec  2 22:07:45 ulises kernel:  [do_page_fault+288/1264] do_page_fault+0x120/0x4f0
Dec  2 22:07:45 ulises kernel:  [sock_destroy_inode+27/31] sock_destroy_inode+0x1b/0x1f
Dec  2 22:07:45 ulises kernel:  [destroy_inode+53/80] destroy_inode+0x35/0x50
Dec  2 22:07:45 ulises kernel:  [iput+85/111] iput+0x55/0x6f
Dec  2 22:07:45 ulises kernel:  [dput+210/347] dput+0xd2/0x15b
Dec  2 22:07:45 ulises kernel:  [__fput+121/188] __fput+0x79/0xbc
Dec  2 22:07:45 ulises kernel:  [sys_setresuid+227/369] sys_setresuid+0xe3/0x171
Dec  2 22:07:45 ulises kernel:  [do_page_fault+0/1264] do_page_fault+0x0/0x4f0
Dec  2 22:07:45 ulises kernel:  [error_code+45/56] error_code+0x2d/0x38
Dec  2 22:07:45 ulises kernel:
Dec  2 22:07:45 ulises kernel: Trying to fix it up, but a reboot is needed
Dec  2 22:07:56 ulises kernel: Bad page state at prep_new_page
Dec  2 22:07:56 ulises kernel: flags:0x0102002c mapping:d50c8a28 mapped:0 count:1
Dec  2 22:07:56 ulises kernel: Backtrace:
Dec  2 22:07:56 ulises kernel: Call Trace:
Dec  2 22:07:56 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
Dec  2 22:07:56 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
Dec  2 22:07:56 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
Dec  2 22:07:56 ulises kernel:  [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
Dec  2 22:07:56 ulises kernel:  [do_wp_page+168/674] do_wp_page+0xa8/0x2a2
Dec  2 22:07:56 ulises kernel:  [handle_mm_fault+293/308] handle_mm_fault+0x125/0x134
Dec  2 22:07:56 ulises kernel:  [do_page_fault+288/1264] do_page_fault+0x120/0x4f0
Dec  2 22:07:56 ulises kernel:  [dentry_open+246/334] dentry_open+0xf6/0x14e
Dec  2 22:07:56 ulises kernel:  [filp_open+98/100] filp_open+0x62/0x64
Dec  2 22:07:56 ulises kernel:  [sys_open+126/139] sys_open+0x7e/0x8b
Dec  2 22:07:56 ulises kernel:  [do_page_fault+0/1264] do_page_fault+0x0/0x4f0
Dec  2 22:07:56 ulises kernel:  [error_code+45/56] error_code+0x2d/0x38
Dec  2 22:07:56 ulises kernel:
Dec  2 22:07:56 ulises kernel: Trying to fix it up, but a reboot is needed
[...]

	After that, probably due to these errors, the kernel starts to panic:

Dec  2 22:11:28 ulises kernel: Bad page state at prep_new_page
Dec  2 22:11:28 ulises kernel: flags:0x0102002c mapping:d50c8a28 mapped:0 count:1
Dec  2 22:11:28 ulises kernel: Backtrace:
Dec  2 22:11:28 ulises kernel: Call Trace:
Dec  2 22:11:28 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
Dec  2 22:11:28 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
Dec  2 22:11:28 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
Dec  2 22:11:28 ulises kernel:  [__alloc_pages+331/788] __alloc_pages+0x14b/0x314
Dec  2 22:11:28 ulises kernel:  [do_page_cache_readahead+221/265] do_page_cache_readahead+0xdd/0x109
Dec  2 22:11:28 ulises kernel:  [kfree_skbmem+36/44] kfree_skbmem+0x24/0x2c
Dec  2 22:11:28 ulises kernel:  [page_cache_readahead+190/335] page_cache_readahead+0xbe/0x14f
Dec  2 22:11:28 ulises kernel:  [do_generic_mapping_read+186/927] do_generic_mapping_read+0xba/0x39f
Dec  2 22:11:28 ulises kernel:  [file_read_actor+0/234] file_read_actor+0x0/0xea
Dec  2 22:11:28 ulises kernel:  [__generic_file_aio_read+444/494] __generic_file_aio_read+0x1bc/0x1ee
Dec  2 22:11:28 ulises kernel:  [file_read_actor+0/234] file_read_actor+0x0/0xea
Dec  2 22:11:28 ulises kernel:  [xfs_read+346/620] xfs_read+0x15a/0x26c
Dec  2 22:11:28 ulises kernel:  [linvfs_read+141/159] linvfs_read+0x8d/0x9f
Dec  2 22:11:28 ulises kernel:  [do_sync_read+139/183] do_sync_read+0x8b/0xb7
Dec  2 22:11:28 ulises kernel:  [inet_setsockopt+54/58] inet_setsockopt+0x36/0x3a
Dec  2 22:11:28 ulises kernel:  [sys_setsockopt+120/178] sys_setsockopt+0x78/0xb2
Dec  2 22:11:28 ulises kernel:  [vfs_read+176/281] vfs_read+0xb0/0x119
Dec  2 22:11:28 ulises kernel:  [sys_read+66/99] sys_read+0x42/0x63
Dec  2 22:11:28 ulises kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Dec  2 22:11:28 ulises kernel:
Dec  2 22:11:28 ulises kernel: Trying to fix it up, but a reboot is needed
Dec  2 22:11:29 ulises kernel: ------------[ cut here ]------------
Dec  2 22:11:29 ulises kernel: kernel BUG at mm/vmscan.c:280!
Dec  2 22:11:29 ulises kernel: invalid operand: 0000 [#2]
Dec  2 22:11:29 ulises kernel: CPU:    0
Dec  2 22:11:29 ulises kernel: EIP:    0060:[shrink_list+1061/1099]    Not tainted
Dec  2 22:11:29 ulises kernel: EFLAGS: 00010202
Dec  2 22:11:29 ulises kernel: EIP is at shrink_list+0x425/0x44b
Dec  2 22:11:29 ulises kernel: eax: 01010041   ebx: d5d57b34   ecx: c13588a0   edx: c104b7c0
Dec  2 22:11:29 ulises kernel: esi: c104b7a8   edi: ce393cfc   ebp: c0463b0c   esp: ce393c38
Dec  2 22:11:29 ulises kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 22:11:29 ulises kernel: Process proftpd (pid: 30881, threadinfo=ce392000 task=d3a43900)
Dec  2 22:11:29 ulises kernel: Stack: 00000000 00000000 00000000 00000000 00000000 00000000 ce393c50 ce393c50
Dec  2 22:11:29 ulises kernel:        0000f1ce 00000000 00000000 00000050 0000f1ce c012d871 dea9a5d8 0000f1ce
Dec  2 22:11:29 ulises kernel:        00000000 00000001 c012d5f9 c13877c8 c13877c8 00000000 c026ecea dea9a5d8
Dec  2 22:11:29 ulises kernel: Call Trace:
Dec  2 22:11:29 ulises kernel:  [find_or_create_page+33/170] find_or_create_page+0x21/0xaa
Dec  2 22:11:29 ulises kernel:  [unlock_page+21/82] unlock_page+0x15/0x52
Dec  2 22:11:29 ulises kernel:  [_pagebuf_lookup_pages+725/941] _pagebuf_lookup_pages+0x2d5/0x3ad
Dec  2 22:11:29 ulises kernel:  [__pagevec_lru_add_active+150/165] __pagevec_lru_add_active+0x96/0xa5
Dec  2 22:11:29 ulises kernel:  [shrink_cache+353/637] shrink_cache+0x161/0x27d
Dec  2 22:11:29 ulises kernel:  [xfs_da_buf_make+508/513] xfs_da_buf_make+0x1fc/0x201
Dec  2 22:11:29 ulises kernel:  [xfs_da_do_buf+738/2470] xfs_da_do_buf+0x2e2/0x9a6
Dec  2 22:11:29 ulises kernel:  [shrink_caches+167/189] shrink_caches+0xa7/0xbd
Dec  2 22:11:29 ulises kernel:  [try_to_free_pages+159/351] try_to_free_pages+0x9f/0x15f
Dec  2 22:11:29 ulises kernel:  [__alloc_pages+469/788] __alloc_pages+0x1d5/0x314
Dec  2 22:11:29 ulises kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Dec  2 22:11:29 ulises kernel:  [__pollwait+133/198] __pollwait+0x85/0xc6
Dec  2 22:11:29 ulises kernel:  [tcp_poll+52/346] tcp_poll+0x34/0x15a
Dec  2 22:11:29 ulises kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Dec  2 22:11:29 ulises kernel:  [do_select+582/675] do_select+0x246/0x2a3
Dec  2 22:11:29 ulises kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Dec  2 22:11:29 ulises kernel:  [sys_select+711/1251] sys_select+0x2c7/0x4e3
Dec  2 22:11:29 ulises kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Dec  2 22:11:29 ulises kernel:
Dec  2 22:11:29 ulises kernel: Code: 0f 0b 18 01 ca cd 40 c0 e9 7c fc ff ff 8b 84 24 b0 00 00 00
Dec  2 22:11:32 ulises kernel:  ------------[ cut here ]------------
Dec  2 22:11:32 ulises kernel: kernel BUG at mm/vmscan.c:280!
Dec  2 22:11:32 ulises kernel: invalid operand: 0000 [#3]
Dec  2 22:11:32 ulises kernel: CPU:    0
Dec  2 22:11:32 ulises kernel: EIP:    0060:[shrink_list+1061/1099]    Not tainted
Dec  2 22:11:32 ulises kernel: EFLAGS: 00010202
Dec  2 22:11:32 ulises kernel: EIP is at shrink_list+0x425/0x44b
Dec  2 22:11:32 ulises kernel: eax: 01020049   ebx: 00000000   ecx: c141ae00   edx: c10bc100
Dec  2 22:11:32 ulises kernel: esi: c10bc0e8   edi: d653dcfc   ebp: c0463b0c   esp: d653dc38
Dec  2 22:11:32 ulises kernel: ds: 007b   es: 007b   ss: 0068
Dec  2 22:11:32 ulises kernel: Process proftpd (pid: 30503, threadinfo=d653c000 task=c80ba080)
Dec  2 22:11:32 ulises kernel: Stack: c036608a dffe799c dddd5180 de49e680 00000000 00000000 d653dc50 d653dc50
Dec  2 22:11:32 ulises kernel:        00000000 c036a066 dddd5180 d653dc68 0000012c 00000001 00000001 c0545e90
Dec  2 22:11:32 ulises kernel:        00000000 00000001 00000013 00000980 c04c1380 dfd39ba0 c010b04a 00000292
Dec  2 22:11:32 ulises kernel: Call Trace:
Dec  2 22:11:32 ulises kernel:  [kfree_skbmem+36/44] kfree_skbmem+0x24/0x2c
Dec  2 22:11:32 ulises kernel:  [net_tx_action+58/172] net_tx_action+0x3a/0xac
Dec  2 22:11:32 ulises kernel:  [do_IRQ+196/223] do_IRQ+0xc4/0xdf
Dec  2 22:11:32 ulises kernel:  [start_this_handle+172/688] start_this_handle+0xac/0x2b0
Dec  2 22:11:32 ulises kernel:  [__pagevec_lru_add_active+150/165] __pagevec_lru_add_active+0x96/0xa5
Dec  2 22:11:32 ulises kernel:  [shrink_cache+353/637] shrink_cache+0x161/0x27d
Dec  2 22:11:32 ulises kernel:  [__block_commit_write+136/138] __block_commit_write+0x88/0x8a
Dec  2 22:11:32 ulises kernel:  [__ext3_journal_stop+36/80] __ext3_journal_stop+0x24/0x50
Dec  2 22:11:32 ulises kernel:  [shrink_caches+167/189] shrink_caches+0xa7/0xbd
Dec  2 22:11:32 ulises kernel:  [try_to_free_pages+159/351] try_to_free_pages+0x9f/0x15f
Dec  2 22:11:32 ulises kernel:  [__alloc_pages+469/788] __alloc_pages+0x1d5/0x314
Dec  2 22:11:32 ulises kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Dec  2 22:11:32 ulises kernel:  [__pollwait+133/198] __pollwait+0x85/0xc6
Dec  2 22:11:32 ulises kernel:  [tcp_poll+52/346] tcp_poll+0x34/0x15a
Dec  2 22:11:32 ulises kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Dec  2 22:11:32 ulises kernel:  [do_select+582/675] do_select+0x246/0x2a3
Dec  2 22:11:32 ulises kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Dec  2 22:11:32 ulises kernel:  [sys_select+711/1251] sys_select+0x2c7/0x4e3
Dec  2 22:11:32 ulises kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Dec  2 22:11:32 ulises kernel:
Dec  2 22:11:32 ulises kernel: Code: 0f 0b 18 01 ca cd 40 c0 e9 7c fc ff ff 8b 84 24 b0 00 00 00
[...]

	This machine is Pentium IV with 512 MB of RAM, IDE & SATA disks, RAID 0 over the
2 SATA disks, vanilla 2.6.0-test11, Debian testing, apache2 and proftpd.

	And yes :-) it's compiled from a fresh cleaned tree.

	Any ideas? Should I switch to 2.6.0-test10-mm1, in case that will be
more stable?

	Thanks in advance,


		Ender.
- -- 
Another C-3PO: E chu ta!
C-3PO: How rude!
		-- C-3PO (The Empire Strikes Back)
- --
Servicios de red - Network services
Centro de Comunicaciones CSIC/RedIRIS
Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.49.05
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zeJeWs/EhA1iABsRAv1dAKCqjUn0lzLiYlpUuh6Wm9G20Qt2iwCeJRaL
rNXUG4kfKEIfm0DVyIsMez8=
=D0lV
-----END PGP SIGNATURE-----

