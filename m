Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUHNPUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUHNPUh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 11:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUHNPUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 11:20:37 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:48263 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263725AbUHNPUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 11:20:21 -0400
Subject: Re: [OOPS] - Linux 2.6.8, NFSv3
From: Kasper Sandberg <lkml@metanurb.dk>
To: Chris Rankin <rankincj@yahoo.com>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040814141555.87521.qmail@web52910.mail.yahoo.com>
References: <20040814141555.87521.qmail@web52910.mail.yahoo.com>
Content-Type: text/plain
Date: Sat, 14 Aug 2004 17:20:19 +0200
Message-Id: <1092496819.6506.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get 2.6.8.1

On Sat, 2004-08-14 at 15:15 +0100, Chris Rankin wrote:
> Hi,
> 
> I see that there's a thread about this already, but
> those oopsen don't look quite like mine. This oops was
> generated on a UP 1 GHz PIII machine, kernel compiled
> with gcc 3.4.1.
> 
> The NFS mount was over UDP to another machine running
> 2.6.8, which hasn't oopsed yet.
> 
> Cheers,
> Chris
> 
> Aug 14 14:18:29 twopit kernel: Unable to handle kernel
> NULL pointer dereference at virtual address 00000014
> Aug 14 14:18:29 twopit kernel:  printing eip:
> Aug 14 14:18:29 twopit kernel: e0b7ac0b
> Aug 14 14:18:29 twopit kernel: *pde = 00000000
> Aug 14 14:18:29 twopit kernel: Oops: 0002 [#1]
> Aug 14 14:18:29 twopit kernel: SMP 
> Aug 14 14:18:29 twopit kernel: Modules linked in:
> videodev mga deflate zlib_deflate zlib_inflate twofish
> serpent aes_i586 blowfish des sha256 crypto_null
> af_key md5 ipv6 snd_rtctimer binfmt_misc w83781d
> eeprom i2c_sensor i2c_i801 i2c_core ide_cd cdrom
> psmouse pcspkr button processor nfs nfsd exportfs
> lockd sunrpc ehci_hcd eth1394 ohci_hcd ohci1394
> ieee1394 8139too mii crc32 emu10k1_gp gameport
> snd_emu10k1 snd_rawmidi snd_pcm snd_timer
> snd_seq_device snd_ac97_codec snd_page_alloc
> snd_util_mem snd_hwdep snd soundcore uhci_hcd usbcore
> i8xx_tco intel_agp agpgart ext3 jbd
> Aug 14 14:18:29 twopit kernel: CPU:    0
> Aug 14 14:18:29 twopit kernel: EIP:   
> 0060:[__crc_unregister_binfmt+1307648/1495193]    Not
> tainted
> Aug 14 14:18:29 twopit kernel: EFLAGS: 00010246  
> (2.6.8) 
> Aug 14 14:18:29 twopit kernel: EIP is at
> nfs3_request_init+0x1b/0x30 [nfs]
> Aug 14 14:18:29 twopit kernel: eax: 00000000   ebx:
> d5f1a620   ecx: 00000000   edx: e0b98680
> Aug 14 14:18:29 twopit kernel: esi: c12bb4a0   edi:
> d5f1a620   ebp: d5880000   esp: d5880c14
> Aug 14 14:18:29 twopit kernel: ds: 007b   es: 007b  
> ss: 0068
> Aug 14 14:18:29 twopit kernel: Process tail (pid:
> 
> 1647, threadinfo=d5880000 task=d5a1d150)
> Aug 14 14:18:29 twopit kernel: Stack: dcfa93a8
> d55b3920 d5f1a620 e0b7266c d5f1a620 d55b3920 00000004
> dfc31800 
> Aug 14 14:18:29 twopit kernel:        dcfa93a8
> 00000f90 c12bb4a0 00000000 e0b754e4 d55b3920 dcfa93a8
> c12bb4a0 
> Aug 14 14:18:30 twopit kernel:        00000000
> 00000f90 d5880cfc c12bb4b8 c12bb4a0 d5880da8 00000000
> c0140098 
> Aug 14 14:18:30 twopit kernel: Call Trace:
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1273441/1495193]
> nfs_create_request+0xbc/0x100 [nfs]
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1285337/1495193]
> readpage_async_filler+0x94/0x140 [nfs]
> Aug 14 14:18:30 twopit kernel: 
> [read_cache_pages+184/352] read_cache_pages+0xb8/0x160
> Aug 14 14:18:30 twopit kernel: 
> [autoremove_wake_function+0/96]
> autoremove_wake_function+0x0/0x60
> Aug 14 14:18:30 twopit kernel: 
> [autoremove_wake_function+0/96]
> autoremove_wake_function+0x0/0x60
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1285608/1495193]
> nfs_readpages+0x63/0xf0 [nfs]
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1285189/1495193]
> readpage_async_filler+0x0/0x140 [nfs]
> Aug 14 14:18:30 twopit kernel:  [read_pages+345/368]
> read_pages+0x159/0x170
> Aug 14 14:18:30 twopit kernel: 
> [buffered_rmqueue+269/528]
> buffered_rmqueue+0x10d/0x210
> Aug 14 14:18:30 twopit kernel: 
> [__alloc_pages+163/784] __alloc_pages+0xa3/0x310
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1097333/1495193]
> rpc_run_timer+0x0/0x90 [sunrpc]
> Aug 14 14:18:30 twopit kernel: 
> [do_page_cache_readahead+385/416]
> do_page_cache_readahead+0x181/0x1a0
> Aug 14 14:18:30 twopit kernel: 
> [page_cache_readahead+252/528]
> page_cache_readahead+0xfc/0x210
> Aug 14 14:18:30 twopit kernel: 
> [do_generic_mapping_read+263/1312]
> do_generic_mapping_read+0x107/0x520
> Aug 14 14:18:30 twopit kernel: 
> [__generic_file_aio_read+474/592]
> __generic_file_aio_read+0x1da/0x250
> Aug 14 14:18:30 twopit kernel: 
> [file_read_actor+0/256] file_read_actor+0x0/0x100
> Aug 14 14:18:30 twopit kernel: 
> [generic_file_aio_read+91/128]
> generic_file_aio_read+0x5b/0x80
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1252393/1495193]
> nfs_file_read+0xc4/0x110 [nfs]
> Aug 14 14:18:30 twopit kernel:  [do_sync_read+128/192]
> do_sync_read+0x80/0xc0
> Aug 14 14:18:30 twopit kernel:  [sys_fstat64+49/64]
> sys_fstat64+0x31/0x40
> Aug 14 14:18:30 twopit kernel:  [vfs_read+278/352]
> vfs_read+0x116/0x160
> Aug 14 14:18:30 twopit kernel:  [sys_read+81/128]
> sys_read+0x51/0x80
> Aug 14 14:18:30 twopit kernel:  [syscall_call+7/11]
> syscall_call+0x7/0xb
> Aug 14 14:18:30 twopit kernel: Code: f0 ff 40 14 89 43
> 18 83 c4 08 5b c3 89 f6 8d bc 27 00 00 00 
> Aug 14 14:18:30 twopit kernel:  <1>Unable to handle
> kernel NULL pointer dereference at virtual address
> 00000014
> Aug 14 14:18:30 twopit kernel:  printing eip:
> Aug 14 14:18:30 twopit kernel: e0b7ac0b
> Aug 14 14:18:30 twopit kernel: *pde = 00000000
> Aug 14 14:18:30 twopit kernel: Oops: 0002 [#2]
> Aug 14 14:18:30 twopit kernel: SMP 
> Aug 14 14:18:30 twopit kernel: Modules linked in:
> videodev mga deflate zlib_deflate zlib_inflate twofish
> serpent aes_i586 blowfish des sha256 crypto_null
> af_key md5 ipv6 snd_rtctimer binfmt_misc w83781d
> eeprom i2c_sensor i2c_i801 i2c_core ide_cd cdrom
> psmouse pcspkr button processor nfs nfsd exportfs
> lockd sunrpc ehci_hcd eth1394 ohci_hcd ohci1394
> ieee1394 8139too mii crc32 emu10k1_gp gameport
> snd_emu10k1 snd_rawmidi snd_pcm snd_timer
> snd_seq_device snd_ac97_codec snd_page_alloc
> snd_util_mem snd_hwdep snd soundcore uhci_hcd usbcore
> i8xx_tco intel_agp agpgart ext3 jbd
> Aug 14 14:18:30 twopit kernel: CPU:    0
> Aug 14 14:18:30 twopit kernel: EIP:   
> 0060:[__crc_unregister_binfmt+1307648/1495193]    Not
> tainted
> Aug 14 14:18:30 twopit kernel: EFLAGS: 00010246  
> (2.6.8) 
> Aug 14 14:18:30 twopit kernel: EIP is at
> nfs3_request_init+0x1b/0x30 [nfs]
> Aug 14 14:18:30 twopit kernel: eax: 00000000   ebx:
> d5f1a5c0   ecx: 00000000   edx: e0b98680
> Aug 14 14:18:30 twopit kernel: esi: c12bb320   edi:
> d5f1a5c0   ebp: d5880000   esp: d5880c14
> Aug 14 14:18:30 twopit kernel: ds: 007b   es: 007b  
> ss: 0068
> Aug 14 14:18:30 twopit kernel: Process grep (pid:
> 1649, threadinfo=d5880000 task=d5a1d150)
> Aug 14 14:18:30 twopit kernel: Stack: d5f19188
> d55b3b00 d5f1a5c0 e0b7266c d5f1a5c0 d55b3b00 00000004
> dfc31800 
> Aug 14 14:18:30 twopit kernel:        d5f19188
> 00000fdd c12bb320 00000000 e0b754e4 d55b3b00 d5f19188
> c12bb320 
> Aug 14 14:18:30 twopit kernel:        00000000
> 00000fdd d5880cfc c12bb338 c12bb320 d5880da8 00000000
> c0140098 
> Aug 14 14:18:30 twopit kernel: Call Trace:
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1273441/1495193]
> nfs_create_request+0xbc/0x100 [nfs]
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1285337/1495193]
> readpage_async_filler+0x94/0x140 [nfs]
> Aug 14 14:18:30 twopit kernel: 
> [read_cache_pages+184/352] read_cache_pages+0xb8/0x160
> Aug 14 14:18:30 twopit kernel: 
> [autoremove_wake_function+0/96]
> autoremove_wake_function+0x0/0x60
> Aug 14 14:18:30 twopit kernel: 
> [autoremove_wake_function+0/96]
> autoremove_wake_function+0x0/0x60
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1285608/1495193]
> nfs_readpages+0x63/0xf0 [nfs]
> Aug 14 14:18:30 twopit kernel: 
> [__crc_unregister_binfmt+1285189/1495193]
> readpage_async_filler+0x0/0x140 [nfs]
> Aug 14 14:18:30 twopit kernel:  [read_pages+345/368]
> read_pages+0x159/0x170
> Aug 14 14:18:31 twopit kernel: 
> [buffered_rmqueue+269/528]
> buffered_rmqueue+0x10d/0x210
> Aug 14 14:18:31 twopit kernel: 
> [__alloc_pages+163/784] __alloc_pages+0xa3/0x310
> Aug 14 14:18:31 twopit kernel: 
> [__crc_unregister_binfmt+1097333/1495193]
> rpc_run_timer+0x0/0x90 [sunrpc]
> Aug 14 14:18:31 twopit kernel: 
> [do_page_cache_readahead+385/416]
> do_page_cache_readahead+0x181/0x1a0
> Aug 14 14:18:31 twopit kernel: 
> [page_cache_readahead+252/528]
> page_cache_readahead+0xfc/0x210
> Aug 14 14:18:31 twopit kernel: 
> [do_generic_mapping_read+263/1312]
> do_generic_mapping_read+0x107/0x520
> Aug 14 14:18:31 twopit kernel: 
> [__generic_file_aio_read+474/592]
> __generic_file_aio_read+0x1da/0x250
> Aug 14 14:18:31 twopit kernel: 
> [file_read_actor+0/256] file_read_actor+0x0/0x100
> Aug 14 14:18:31 twopit kernel: 
> [generic_file_aio_read+91/128]
> generic_file_aio_read+0x5b/0x80
> Aug 14 14:18:31 twopit kernel: 
> [__crc_unregister_binfmt+1252393/1495193]
> nfs_file_read+0xc4/0x110 [nfs]
> Aug 14 14:18:31 twopit kernel:  [do_sync_read+128/192]
> do_sync_read+0x80/0xc0
> Aug 14 14:18:31 twopit kernel:  [sys_fstat64+49/64]
> sys_fstat64+0x31/0x40
> Aug 14 14:18:31 twopit kernel:  [vfs_read+278/352]
> vfs_read+0x116/0x160
> Aug 14 14:18:31 twopit kernel:  [sys_read+81/128]
> sys_read+0x51/0x80
> Aug 14 14:18:31 twopit kernel:  [syscall_call+7/11]
> syscall_call+0x7/0xb
> Aug 14 14:18:31 twopit kernel: Code: f0 ff 40 14 89 43
> 18 83 c4 08 5b c3 89 f6 8d bc 27 00 00 00 
> Aug 14 14:18:31 twopit kernel:  <1>Unable to handle
> kernel NULL pointer dereference at virtual address
> 00000014
> Aug 14 14:18:31 twopit kernel:  printing eip:
> Aug 14 14:18:31 twopit kernel: e0b7ac0b
> Aug 14 14:18:31 twopit kernel: *pde = 00000000
> Aug 14 14:18:31 twopit kernel: Oops: 0002 [#3]
> Aug 14 14:18:31 twopit kernel: SMP 
> Aug 14 14:18:31 twopit kernel: Modules linked in:
> videodev mga deflate zlib_deflate zlib_inflate twofish
> serpent aes_i586 blowfish des sha256 crypto_null
> af_key md5 ipv6 snd_rtctimer binfmt_misc w83781d
> eeprom i2c_sensor i2c_i801 i2c_core ide_cd cdrom
> psmouse pcspkr button processor nfs nfsd exportfs
> lockd sunrpc ehci_hcd eth1394 ohci_hcd ohci1394
> ieee1394 8139too mii crc32 emu10k1_gp gameport
> snd_emu10k1 snd_rawmidi snd_pcm snd_timer
> snd_seq_device snd_ac97_codec snd_page_alloc
> snd_util_mem snd_hwdep snd soundcore uhci_hcd usbcore
> i8xx_tco intel_agp agpgart ext3 jbd
> Aug 14 14:18:31 twopit kernel: CPU:    0
> Aug 14 14:18:31 twopit kernel: EIP:   
> 0060:[__crc_unregister_binfmt+1307648/1495193]    Not
> tainted
> Aug 14 14:18:31 twopit kernel: EFLAGS: 00010246  
> (2.6.8) 
> Aug 14 14:18:31 twopit kernel: EIP is at
> nfs3_request_init+0x1b/0x30 [nfs]
> Aug 14 14:18:31 twopit kernel: eax: 00000000   ebx:
> d5f1a560   ecx: 00000000   edx: e0b98680
> Aug 14 14:18:31 twopit kernel: esi: c12bb340   edi:
> d5f1a560   ebp: d5880000   esp: d5880c14
> Aug 14 14:18:31 twopit kernel: ds: 007b   es: 007b  
> ss: 0068
> Aug 14 14:18:31 twopit kernel: Process grep (pid:
> 1650, threadinfo=d5880000 task=d5a1d150)
> Aug 14 14:18:31 twopit kernel: Stack: d5f19648
> d55b3920 d5f1a560 e0b7266c d5f1a560 d55b3920 00000004
> dfc31800 
> Aug 14 14:18:31 twopit kernel:        d5f19648
> 00000fe2 c12bb340 00000000 e0b754e4 d55b3920 d5f19648
> c12bb340 
> Aug 14 14:18:31 twopit kernel:        00000000
> 00000fe2 d5880cfc c12bb358 c12bb340 d5880da8 00000000
> c0140098 
> Aug 14 14:18:31 twopit kernel: Call Trace:
> Aug 14 14:18:31 twopit kernel: 
> [__crc_unregister_binfmt+1273441/1495193]
> nfs_create_request+0xbc/0x100 [nfs]
> Aug 14 14:18:31 twopit kernel: 
> [__crc_unregister_binfmt+1285337/1495193]
> readpage_async_filler+0x94/0x140 [nfs]
> Aug 14 14:18:31 twopit kernel: 
> [read_cache_pages+184/352] read_cache_pages+0xb8/0x160
> Aug 14 14:18:31 twopit kernel: 
> [autoremove_wake_function+0/96]
> autoremove_wake_function+0x0/0x60
> Aug 14 14:18:31 twopit kernel: 
> [autoremove_wake_function+0/96]
> autoremove_wake_function+0x0/0x60
> Aug 14 14:18:31 twopit kernel: 
> [__crc_unregister_binfmt+1285608/1495193]
> nfs_readpages+0x63/0xf0 [nfs]
> Aug 14 14:18:31 twopit kernel: 
> [__crc_unregister_binfmt+1285189/1495193]
> readpage_async_filler+0x0/0x140 [nfs]
> Aug 14 14:18:31 twopit kernel:  [read_pages+345/368]
> read_pages+0x159/0x170
> Aug 14 14:18:31 twopit kernel: 
> [buffered_rmqueue+269/528]
> buffered_rmqueue+0x10d/0x210
> Aug 14 14:18:31 twopit kernel: 
> [__alloc_pages+163/784] __alloc_pages+0xa3/0x310
> Aug 14 14:18:31 twopit kernel: 
> [__crc_unregister_binfmt+1097333/1495193]
> rpc_run_timer+0x0/0x90 [sunrpc]
> Aug 14 14:18:31 twopit kernel: 
> [do_page_cache_readahead+385/416]
> do_page_cache_readahead+0x181/0x1a0
> Aug 14 14:18:31 twopit kernel: 
> [page_cache_readahead+252/528]
> page_cache_readahead+0xfc/0x210
> Aug 14 14:18:31 twopit kernel: 
> [do_generic_mapping_read+263/1312]
> do_generic_mapping_read+0x107/0x520
> Aug 14 14:18:31 twopit kernel: 
> [__generic_file_aio_read+474/592]
> __generic_file_aio_read+0x1da/0x250
> Aug 14 14:18:31 twopit kernel: 
> [file_read_actor+0/256] file_read_actor+0x0/0x100
> Aug 14 14:18:31 twopit kernel: 
> [generic_file_aio_read+91/128]
> generic_file_aio_read+0x5b/0x80
> Aug 14 14:18:31 twopit kernel: 
> [__crc_unregister_binfmt+1252393/1495193]
> nfs_file_read+0xc4/0x110 [nfs]
> Aug 14 14:18:31 twopit kernel:  [do_sync_read+128/192]
> do_sync_read+0x80/0xc0
> Aug 14 14:18:31 twopit kernel:  [sys_fstat64+49/64]
> sys_fstat64+0x31/0x40
> Aug 14 14:18:31 twopit kernel:  [vfs_read+278/352]
> vfs_read+0x116/0x160
> Aug 14 14:18:31 twopit kernel:  [sys_read+81/128]
> sys_read+0x51/0x80
> Aug 14 14:18:31 twopit kernel:  [syscall_call+7/11]
> syscall_call+0x7/0xb
> Aug 14 14:18:31 twopit kernel: Code: f0 ff 40 14 89 43
> 18 83 c4 08 5b c3 89 f6 8d bc 27 00 00 00 
> 
> 
> 
> 	
> 	
> 		
> ___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

