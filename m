Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVBTKxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVBTKxP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVBTKxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:53:15 -0500
Received: from [81.23.229.73] ([81.23.229.73]:4836 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261812AbVBTKvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:51:42 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SOLVED] Linux 2.6.10-rc3-bk15 hanged under high load (i386)
Date: Sun, 20 Feb 2005 11:51:33 +0100
User-Agent: KMail/1.6.2
References: <20050220103958.GA4258@localhost>
In-Reply-To: <20050220103958.GA4258@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200502201151.33805.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same broken box here: Graphics freezes, sometime the whole box: It 
needs to warm up. Once warmed up, it will keep running stable forever (-: 
(Ok, the forever claim can not be verified).

On Sunday 20 February 2005 11:39, Jose Luis Domingo Lopez wrote:
> Hi:
>
> This is more an attempt to get this indexed by web search engines than a
> request for help, although maybe someone can draw some conclusion from the
> following and be of some use to anyone. Although the subject refers to
> some specific kernel version, what is reported in the mail is also valid
> for (at least) any kernel version up to 2.6.11-rc3.
>
> Back in the beginning of January I sent a (desperate) email to the list
> reporting frequenet lockups with (then) recent 2.6.x kernel versions. The
> Message-ID of the original post is 20050105183947.GA5601@localhost, and
> the subject "Linux 2.6.10-rc3-bk15 hanged under high load (i386)".
>
> Well, I heve suffering from the same problem since then, but soon I
> realized some kind of pattern: I was only getting one (and only one)
> kernel hang each day. I power on the PC, start downloading tons of mail
> (mostly spam), at some point spamassassin gets killed and the logs get
> full of very nasty messages as the ones reported back in January (" Unable
> to handle kernel paging request" and stack dumps). Finally the box freezes.
>
> After the above I reboot the box (a simple RESET, not a power OFF / power
> ON cycle), start downloading mail again...and no more paging request
> failures, stack dumps, process killed, or hung boxes, _never_.
>
> So it seemed like the hardware is flawed and somehow needed to be rebooted
> once to be put in a "stable" configuration. From the day I realized the
> pattern I booted the PC, then inmediately did a "reboot", and then started
> using the box as usual: no more error or problems of any kind since then.
>
> It's been two weeks since then, and no problems. Maybe it was just a
> coincidence, so today I booted the box and started using it without an
> "initializing reboot" like the previous two weeks. And some minutes after
> started downloading mail the box freezed hard with the messages inlined to
> the end of this email.
>
> So it seems clear to me that something is very broken in the hardware, but
> somehow it gets fixed after a reboot. I have no knowledge to investigate
> this further, but at least someone with the same problem will search
> through Google and hopefully find this message.
>
> Greetings.
>
>
> Feb 20 11:16:30 dardhal kernel: Unable to handle kernel paging request at
> virtual address 0016a51c Feb 20 11:16:30 dardhal kernel: printing eip:
> Feb 20 11:16:30 dardhal kernel: c01320b7
> Feb 20 11:16:30 dardhal kernel: *pde = 00000000
> Feb 20 11:16:30 dardhal kernel: Oops: 0002 [#1]
> Feb 20 11:16:30 dardhal kernel: Modules linked in: sch_htb cls_u32
> sch_ingress ipt_LOG ipt_limit ipt_state iptable_filter ipt_MASQUERADE
> iptable_nat ip_conntrack ip_tables ppp_deflate bsd_comp ppp_async crc_ccitt
> ppp_generic slhc deflate zlib_deflate zlib_inflate twofish serpent aes_i586
> blowfish des sha256 sha1 crypto_null af_key md5 ipv6 snd_via82xx uhci_hcd
> usbcore i2c_viapro tuner tvaudio bttv video_buf v4l2_common btcx_risc
> tveeprom videodev snd_ymfpci snd_ac97_codec snd_pcm_oss snd_mixer_oss
> snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc snd_mpu401_uart
> snd_rawmidi snd_seq_device snd soundcore skystar2 dvb_core mt352 stv0299
> nxt2002 firmware_class mt312 8139too 8139cp mii via_agp agpgart reiserfs
> xfs exportfs dm_mod it87 i2c_sensor i2c_isa rtc Feb 20 11:16:30 dardhal
> kernel: CPU:    0
> Feb 20 11:16:30 dardhal kernel: EIP:    0060:[<c01320b7>]    Not tainted
> VLI Feb 20 11:16:30 dardhal kernel: EFLAGS: 00010006   (2.6.11-rc3)
> Feb 20 11:16:30 dardhal kernel: EIP is at buffered_rmqueue+0x57/0x1a0
> Feb 20 11:16:30 dardhal kernel: eax: c10ef5f8   ebx: c0309224   ecx:
> c0309250   edx: 0016a518 Feb 20 11:16:30 dardhal kernel: esi: 00000246  
> edi: c0309240   ebp: c0309224   esp: c0b69df4 Feb 20 11:16:30 dardhal
> kernel: ds: 007b   es: 007b   ss: 0068
> Feb 20 11:16:30 dardhal kernel: Process spamassassin (pid: 5554,
> threadinfo=c0b68000 task=cdd065d0) Feb 20 11:16:30 dardhal kernel: Stack:
> c77ae000 00000000 00000010 c0309250 c10ef5e0 c0309224 cd5a07dc 00000000 Feb
> 20 11:16:30 dardhal kernel: ce900b1c c01326c3 c0309224 00000000 000080d2
> 00000001 00000000 00000000 Feb 20 11:16:30 dardhal kernel: 00000001
> 00000000 cdd065d0 00000010 c030948c 00000000 000080d2 c0b69e74 Feb 20
> 11:16:30 dardhal kernel: Call Trace:
> Feb 20 11:16:30 dardhal kernel: [<c01326c3>] __alloc_pages+0x423/0x450
> Feb 20 11:16:30 dardhal kernel: [<c013c3e1>] do_anonymous_page+0x71/0x130
> Feb 20 11:16:30 dardhal kernel: [<c013c503>] do_no_page+0x63/0x2b0
> Feb 20 11:16:30 dardhal kernel: [<c013c92e>] handle_mm_fault+0xde/0x150
> Feb 20 11:16:30 dardhal kernel: [<c010fd8c>] do_page_fault+0x18c/0x599
> Feb 20 11:16:30 dardhal kernel: [<c0218516>] i8042_interrupt+0x116/0x2f0
> Feb 20 11:16:30 dardhal kernel: [<c013ef2f>] unmap_vma_list+0x1f/0x30
> Feb 20 11:16:30 dardhal kernel: [<c012caa0>] handle_IRQ_event+0x30/0x70
> Feb 20 11:16:30 dardhal kernel: [<c012cb31>] __do_IRQ+0x51/0xe0
> Feb 20 11:16:30 dardhal kernel: [<c010fc00>] do_page_fault+0x0/0x599
> Feb 20 11:16:30 dardhal kernel: [<c0102f57>] error_code+0x2b/0x30
> Feb 20 11:16:30 dardhal kernel: Code: 01 d0 8d 5c c5 00 8d 7b 1c 9c 5e fa
> 8b 43 1c 3b 47 04 0f 8e 2b 01 00 00 85 c0 74 24 8b 47 10 8d 50 e8 89 54 24
> 10 8b 10 8b 48 04 <89> 4a 04 89 11 c7 40 04 00 02 20 00 c7 00 00 01 10 00
> ff 4b 1c Feb 20 11:16:44 dardhal kernel: <0>Bad page state at
> free_hot_cold_page (in process 'spamassassin', page c11b6bc0) Feb 20
> 11:16:44 dardhal kernel: flags:0x20000010 mapping:00000000 mapcount:262144
> count:0 Feb 20 11:16:44 dardhal kernel: Backtrace:
> Feb 20 11:16:44 dardhal kernel: [<c0131924>] bad_page+0x74/0xb0
> Feb 20 11:16:44 dardhal kernel: [<c0131fc0>] free_hot_cold_page+0x60/0xe0
> Feb 20 11:16:44 dardhal kernel: [<c013ab2b>] zap_pte_range+0x13b/0x240
> Feb 20 11:16:44 dardhal kernel: [<c013ac83>] zap_pmd_range+0x53/0x70
> Feb 20 11:16:44 dardhal kernel: [<c013acda>] zap_pud_range+0x3a/0x60
> Feb 20 11:16:44 dardhal kernel: [<c013ad70>] unmap_page_range+0x70/0x90
> Feb 20 11:16:44 dardhal kernel: [<c013ae86>] unmap_vmas+0xf6/0x1f0
> Feb 20 11:16:44 dardhal kernel: [<c013f698>] exit_mmap+0x78/0x140
> Feb 20 11:16:44 dardhal kernel: [<c0112afc>] mmput+0x2c/0x80
> Feb 20 11:16:44 dardhal kernel: [<c01168f0>] do_exit+0x90/0x2c0
> Feb 20 11:16:44 dardhal kernel: [<c0116b94>] do_group_exit+0x34/0x70
> Feb 20 11:16:44 dardhal kernel: [<c0102543>] syscall_call+0x7/0xb
> Feb 20 11:16:44 dardhal kernel: Trying to fix it up, but a reboot is needed
> Feb 20 11:16:47 dardhal kernel: Unable to handle kernel paging request at
> virtual address 000fe4fc Feb 20 11:16:47 dardhal kernel: printing eip:
> Feb 20 11:16:47 dardhal kernel: c01320b7
> Feb 20 11:16:47 dardhal kernel: *pde = 00000000
> Feb 20 11:16:47 dardhal kernel: Oops: 0002 [#2]
> Feb 20 11:16:47 dardhal kernel: Modules linked in: sch_htb cls_u32
> sch_ingress ipt_LOG ipt_limit ipt_state iptable_filter ipt_MASQUERADE
> iptable_nat ip_conntrack ip_tables ppp_deflate bsd_comp ppp_async crc_ccitt
> ppp_generic slhc deflate zlib_deflate zlib_inflate twofish serpent aes_i586
> blowfish des sha256 sha1 crypto_null af_key md5 ipv6 snd_via82xx uhci_hcd
> usbcore i2c_viapro tuner tvaudio bttv video_buf v4l2_common btcx_risc
> tveeprom videodev snd_ymfpci snd_ac97_codec snd_pcm_oss snd_mixer_oss
> snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc snd_mpu401_uart
> snd_rawmidi snd_seq_device snd soundcore skystar2 dvb_core mt352 stv0299
> nxt2002 firmware_class mt312 8139too 8139cp mii via_agp agpgart reiserfs
> xfs exportfs dm_mod it87 i2c_sensor i2c_isa rtc Feb 20 11:16:47 dardhal
> kernel: CPU:    0
> Feb 20 11:16:47 dardhal kernel: EIP:    0060:[<c01320b7>]    Tainted: G   
> B VLI Feb 20 11:16:47 dardhal kernel: EFLAGS: 00010002   (2.6.11-rc3)
> Feb 20 11:16:47 dardhal kernel: EIP is at buffered_rmqueue+0x57/0x1a0
> Feb 20 11:16:47 dardhal kernel: eax: c10b7f38   ebx: c0309224   ecx:
> c0309250   edx: 000fe4f8 Feb 20 11:16:47 dardhal kernel: esi: 00000246  
> edi: c0309240   ebp: c0309224   esp: c448bdf4 Feb 20 11:16:47 dardhal
> kernel: ds: 007b   es: 007b   ss: 0068
> Feb 20 11:16:47 dardhal kernel: Process spamassassin (pid: 5623,
> threadinfo=c448a000 task=cdd065d0) Feb 20 11:16:47 dardhal kernel: Stack:
> cb0a5000 00000000 00000010 c0309250 c10b7f20 c0309224 dd8d4c10 00000000 Feb
> 20 11:16:47 dardhal kernel: ce9004ec c01326c3 c0309224 00000000 000080d2
> 00000001 00000000 00000000 Feb 20 11:16:47 dardhal kernel: 00000001
> 00000000 cdd065d0 00000010 c030948c 00000000 000080d2 dd8d4bfc Feb 20
> 11:16:47 dardhal kernel: Call Trace:
> Feb 20 11:16:47 dardhal kernel: [<c01326c3>] __alloc_pages+0x423/0x450
> Feb 20 11:16:47 dardhal kernel: [<c013c3e1>] do_anonymous_page+0x71/0x130
> Feb 20 11:16:47 dardhal kernel: [<c013c503>] do_no_page+0x63/0x2b0
> Feb 20 11:16:47 dardhal kernel: [<c013c92e>] handle_mm_fault+0xde/0x150
> Feb 20 11:16:47 dardhal kernel: [<c010fd8c>] do_page_fault+0x18c/0x599
> Feb 20 11:16:47 dardhal kernel: [<c021daa7>] transmit_chars+0xa7/0xe0
> Feb 20 11:16:47 dardhal kernel: [<c021dc66>] serial8250_interrupt+0x36/0xe0
> Feb 20 11:16:47 dardhal kernel: [<c012caa0>] handle_IRQ_event+0x30/0x70
> Feb 20 11:16:47 dardhal kernel: [<c012cb31>] __do_IRQ+0x51/0xe0
> Feb 20 11:16:47 dardhal kernel: [<c010fc00>] do_page_fault+0x0/0x599
> Feb 20 11:16:47 dardhal kernel: [<c0102f57>] error_code+0x2b/0x30
> Feb 20 11:16:47 dardhal kernel: Code: 01 d0 8d 5c c5 00 8d 7b 1c 9c 5e fa
> 8b 43 1c 3b 47 04 0f 8e 2b 01 00 00 85 c0 74 24 8b 47 10 8d 50 e8 89 54 24
> 10 8b 10 8b 48 04 <89> 4a 04 89 11 c7 40 04 00 02 20 00 c7 00 00 01 10 00
> ff 4b 1c Feb 20 11:16:58 dardhal kernel: <1>Unable to handle kernel paging
> request at virtual address 0007d5dc Feb 20 11:16:58 dardhal kernel:
> printing eip:
> Feb 20 11:16:58 dardhal kernel: c01320b7
> Feb 20 11:16:58 dardhal kernel: *pde = 00000000
> Feb 20 11:16:58 dardhal kernel: Oops: 0002 [#3]
> Feb 20 11:16:58 dardhal kernel: Modules linked in: sch_htb cls_u32
> sch_ingress ipt_LOG ipt_limit ipt_state iptable_filter ipt_MASQUERADE
> iptable_nat ip_conntrack ip_tables ppp_deflate bsd_comp ppp_async crc_ccitt
> ppp_generic slhc deflate zlib_deflate zlib_inflate twofish serpent aes_i586
> blowfish des sha256 sha1 crypto_null af_key md5 ipv6 snd_via82xx uhci_hcd
> usbcore i2c_viapro tuner tvaudio bttv video_buf v4l2_common btcx_risc
> tveeprom videodev snd_ymfpci snd_ac97_codec snd_pcm_oss snd_mixer_oss
> snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc snd_mpu401_uart
> snd_rawmidi snd_seq_device snd soundcore skystar2 dvb_core mt352 stv0299
> nxt2002 firmware_class mt312 8139too 8139cp mii via_agp agpgart reiserfs
> xfs exportfs dm_mod it87 i2c_sensor i2c_isa rtc Feb 20 11:16:58 dardhal
> kernel: CPU:    0
> Feb 20 11:16:58 dardhal kernel: EIP:    0060:[<c01320b7>]    Tainted: G   
> B VLI Feb 20 11:16:58 dardhal kernel: EFLAGS: 00010002   (2.6.11-rc3)
> Feb 20 11:16:58 dardhal kernel: EIP is at buffered_rmqueue+0x57/0x1a0
> Feb 20 11:16:58 dardhal kernel: eax: c107d5b8   ebx: c0309224   ecx:
> c0309250   edx: 0007d5d8 Feb 20 11:16:58 dardhal kernel: esi: 00000246  
> edi: c0309240   ebp: c0309224   esp: c3515df4 Feb 20 11:16:58 dardhal
> kernel: ds: 007b   es: 007b   ss: 0068
> Feb 20 11:16:58 dardhal kernel: Process spamassassin (pid: 5670,
> threadinfo=c3514000 task=c8a36060) Feb 20 11:16:58 dardhal kernel: Stack:
> c3eac000 00000000 00000010 c0309250 c107d5a0 c0309224 c3961c88 00000000 Feb
> 20 11:16:58 dardhal kernel: c92feb74 c01326c3 c0309224 00000000 000080d2
> 00000001 00000000 00000000 Feb 20 11:16:58 dardhal kernel: 00000001
> 00000000 c8a36060 00000010 c030948c 00000000 000080d2 c3961c74 Feb 20
> 11:16:58 dardhal kernel: Call Trace:
> Feb 20 11:16:58 dardhal kernel: [<c01326c3>] __alloc_pages+0x423/0x450
> Feb 20 11:16:58 dardhal kernel: [<c013c3e1>] do_anonymous_page+0x71/0x130
> Feb 20 11:16:58 dardhal kernel: [<c013c503>] do_no_page+0x63/0x2b0
> Feb 20 11:16:58 dardhal kernel: [<c013c92e>] handle_mm_fault+0xde/0x150
> Feb 20 11:16:58 dardhal kernel: [<c010fd8c>] do_page_fault+0x18c/0x599
> Feb 20 11:16:58 dardhal kernel: [<c0122c70>] delayed_work_timer_fn+0x0/0x20
> Feb 20 11:16:58 dardhal kernel: [<c0110da8>] recalc_task_prio+0x88/0x150
> Feb 20 11:16:58 dardhal kernel: [<c02b3811>] schedule+0x2d1/0x4c0
> Feb 20 11:16:58 dardhal kernel: [<c010fc00>] do_page_fault+0x0/0x599
> Feb 20 11:16:58 dardhal kernel: [<c0102f57>] error_code+0x2b/0x30
> Feb 20 11:16:58 dardhal kernel: Code: 01 d0 8d 5c c5 00 8d 7b 1c 9c 5e fa
> 8b 43 1c 3b 47 04 0f 8e 2b 01 00 00 85 c0 74 24 8b 47 10 8d 50 e8 89 54 24
> 10 8b 10 8b 48 04 <89> 4a 04 89 11 c7 40 04 00 02 20 00 c7 00 00 01 10 00
> ff 4b 1c Feb 20 11:17:13 dardhal kernel: VM: killing process spamassassin
> Feb 20 11:17:13 dardhal kernel: swap_free: Bad swap offset entry 00080000
> Feb 20 11:17:24 dardhal kernel: Unable to handle kernel paging request at
> virtual address 0029395c Feb 20 11:17:24 dardhal kernel: printing eip:
> Feb 20 11:17:24 dardhal kernel: c01320b7
> Feb 20 11:17:24 dardhal kernel: *pde = 00000000
> Feb 20 11:17:24 dardhal kernel: Oops: 0002 [#4]
> Feb 20 11:17:24 dardhal kernel: Modules linked in: sch_htb cls_u32
> sch_ingress ipt_LOG ipt_limit ipt_state iptable_filter ipt_MASQUERADE
> iptable_nat ip_conntrack ip_tables ppp_deflate bsd_comp ppp_async crc_ccitt
> ppp_generic slhc deflate zlib_deflate zlib_inflate twofish serpent aes_i586
> blowfish des sha256 sha1 crypto_null af_key md5 ipv6 snd_via82xx uhci_hcd
> usbcore i2c_viapro tuner tvaudio bttv video_buf v4l2_common btcx_risc
> tveeprom videodev snd_ymfpci snd_ac97_codec snd_pcm_oss snd_mixer_oss
> snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc snd_mpu401_uart
> snd_rawmidi snd_seq_device snd soundcore skystar2 dvb_core mt352 stv0299
> nxt2002 firmware_class mt312 8139too 8139cp mii via_agp agpgart reiserfs
> xfs exportfs dm_mod it87 i2c_sensor i2c_isa rtc Feb 20 11:17:24 dardhal
> kernel: CPU:    0
> Feb 20 11:17:24 dardhal kernel: EIP:    0060:[<c01320b7>]    Tainted: G   
> B VLI Feb 20 11:17:24 dardhal kernel: EFLAGS: 00010006   (2.6.11-rc3)
> Feb 20 11:17:24 dardhal kernel: EIP is at buffered_rmqueue+0x57/0x1a0
> Feb 20 11:17:24 dardhal kernel: eax: c1293db8   ebx: c0309224   ecx:
> c0309250   edx: 00293958 Feb 20 11:17:24 dardhal kernel: esi: 00000246  
> edi: c0309240   ebp: c0309224   esp: cd977df4 Feb 20 11:17:24 dardhal
> kernel: ds: 007b   es: 007b   ss: 0068
> Feb 20 11:17:24 dardhal kernel: Process spamassassin (pid: 5780,
> threadinfo=cd976000 task=cd93ca80) Feb 20 11:17:24 dardhal kernel: Stack:
> d49ec000 00000000 0000077d 00000000 c1293da0 c0309224 d8b30944 00000000 Feb
> 20 11:17:24 dardhal kernel: d4466964 c01326c3 c0309224 00000000 000080d2
> 00000001 00000000 00000000 Feb 20 11:17:24 dardhal kernel: 00000001
> 00000000 cd93ca80 00000010 c030948c 00000000 000080d2 cd977e88 Feb 20
> 11:17:24 dardhal kernel: Call Trace:
> Feb 20 11:17:24 dardhal kernel: [<c01326c3>] __alloc_pages+0x423/0x450
> Feb 20 11:17:24 dardhal kernel: [<c013c3e1>] do_anonymous_page+0x71/0x130
> Feb 20 11:17:24 dardhal kernel: [<c013c503>] do_no_page+0x63/0x2b0
> Feb 20 11:17:24 dardhal kernel: [<c013c92e>] handle_mm_fault+0xde/0x150
> Feb 20 11:17:24 dardhal kernel: [<c010fd8c>] do_page_fault+0x18c/0x599
> Feb 20 11:17:24 dardhal kernel: [<c0126e20>]
> autoremove_wake_function+0x0/0x60 Feb 20 11:17:24 dardhal kernel:
> [<c0153447>] sys_fstat64+0x37/0x40 Feb 20 11:17:24 dardhal kernel:
> [<c014a235>] vfs_read+0x95/0x110
> Feb 20 11:17:24 dardhal kernel: [<c014a501>] sys_read+0x51/0x80
> Feb 20 11:17:24 dardhal kernel: [<c010fc00>] do_page_fault+0x0/0x599
> Feb 20 11:17:24 dardhal kernel: [<c0102f57>] error_code+0x2b/0x30
> Feb 20 11:17:24 dardhal kernel: Code: 01 d0 8d 5c c5 00 8d 7b 1c 9c 5e fa
> 8b 43 1c 3b 47 04 0f 8e 2b 01 00 00 85 c0 74 24 8b 47 10 8d 50 e8 89 54 24
> 10 8b 10 8b 48 04 <89> 4a 04 89 11 c7 40 04 00 02 20 00 c7 00 00 01 10 00
> ff 4b 1c Feb 20 11:17:26 dardhal kernel: <4>IN=ppp0 OUT= MAC=
> SRC=168.203.4.23 DST=213.0.204.127 LEN=32 TOS=0x00 PREC=0x00 TTL=3 ID=21
> PROTO=UDP SPT=10144 DPT=33435 LEN=12 Feb 20 11:17:28 dardhal kernel: Unable
> to handle kernel paging request at virtual address 001bec5c Feb 20 11:17:28
> dardhal kernel: printing eip:
> Feb 20 11:17:28 dardhal kernel: c01320b7
> Feb 20 11:17:28 dardhal kernel: *pde = 00000000
> Feb 20 11:17:28 dardhal kernel: Oops: 0002 [#5]
> Feb 20 11:17:28 dardhal kernel: Modules linked in: sch_htb cls_u32
> sch_ingress ipt_LOG ipt_limit ipt_state iptable_filter ipt_MASQUERADE
> iptable_nat ip_conntrack ip_tables ppp_deflate bsd_comp ppp_async crc_ccitt
> ppp_generic slhc deflate zlib_deflate zlib_inflate twofish serpent aes_i586
> blowfish des sha256 sha1 crypto_null af_key md5 ipv6 snd_via82xx uhci_hcd
> usbcore i2c_viapro tuner tvaudio bttv video_buf v4l2_common btcx_risc
> tveeprom videodev snd_ymfpci snd_ac97_codec snd_pcm_oss snd_mixer_oss
> snd_pcm snd_opl3_lib snd_timer snd_hwdep snd_page_alloc snd_mpu401_uart
> snd_rawmidi snd_seq_device snd soundcore skystar2 dvb_core mt352 stv0299
> nxt2002 firmware_class mt312 8139too 8139cp mii via_agp agpgart reiserfs
> xfs exportfs dm_mod it87 i2c_sensor i2c_isa rtc Feb 20 11:17:28 dardhal
> kernel: CPU:    0
> Feb 20 11:17:28 dardhal kernel: EIP:    0060:[<c01320b7>]    Tainted: G   
> B VLI Feb 20 11:17:28 dardhal kernel: EFLAGS: 00010002   (2.6.11-rc3)
> Feb 20 11:17:28 dardhal kernel: EIP is at buffered_rmqueue+0x57/0x1a0
> Feb 20 11:17:28 dardhal kernel: eax: c10abb38   ebx: c0309224   ecx:
> c0309250   edx: 001bec58 Feb 20 11:17:28 dardhal kernel: esi: 00000246  
> edi: c0309240   ebp: c0309224   esp: c842ddf4 Feb 20 11:17:28 dardhal
> kernel: ds: 007b   es: 007b   ss: 0068
> Feb 20 11:17:28 dardhal kernel: Process spamassassin (pid: 5802,
> threadinfo=c842c000 task=d0a40020) Feb 20 11:17:28 dardhal kernel: Stack:
> c55d8000 00000000 00001000 00000000 c10abb20 c0309224 d4516b30 00000000 Feb
> 20 11:17:28 dardhal kernel: cf137a14 c01326c3 c0309224 00000000 000080d2
> 00000001 00000000 00000000 Feb 20 11:17:28 dardhal kernel: 00000001
> 00000000 d0a40020 00000010 c030948c 00000000 000080d2 c842de88 Feb 20
> 11:17:28 dardhal kernel: Call Trace:
> Feb 20 11:17:28 dardhal kernel: [<c01326c3>] __alloc_pages+0x423/0x450
> Feb 20 11:17:28 dardhal kernel: [<c013c3e1>] do_anonymous_page+0x71/0x130
> Feb 20 11:17:28 dardhal kernel: [<c013c503>] do_no_page+0x63/0x2b0
> Feb 20 11:17:28 dardhal kernel: [<c013c92e>] handle_mm_fault+0xde/0x150
> Feb 20 11:17:28 dardhal kernel: [<c010fd8c>] do_page_fault+0x18c/0x599
> Feb 20 11:17:28 dardhal kernel: [<c011169d>] scheduler_tick+0x1d/0x290
> Feb 20 11:17:28 dardhal kernel: [<c010d667>]
> smp_local_timer_interrupt+0x17/0x70 Feb 20 11:17:28 dardhal kernel:
> [<c0106e61>] timer_interrupt+0xf1/0x100 Feb 20 11:17:28 dardhal kernel:
> [<c012caa0>] handle_IRQ_event+0x30/0x70 Feb 20 11:17:28 dardhal kernel:
> [<c0118e3d>] __do_softirq+0x7d/0x90 Feb 20 11:17:28 dardhal kernel:
> [<c010fc00>] do_page_fault+0x0/0x599 Feb 20 11:17:28 dardhal kernel:
> [<c0102f57>] error_code+0x2b/0x30
> Feb 20 11:17:28 dardhal kernel: Code: 01 d0 8d 5c c5 00 8d 7b 1c 9c 5e fa
> 8b 43 1c 3b 47 04 0f 8e 2b 01 00 00 85 c0 74 24 8b 47 10 8d 50 e8 89 54 24
> 10 8b 10 8b 48 04 <89> 4a 04 89 11 c7 40 04 00 02 20 00 c7 00 00 01 10 00
> ff 4b 1c Feb 20 11:17:31 dardhal kernel: swap_free: Bad swap offset entry
> 00080000 Feb 20 11:17:33 dardhal kernel: VM: killing process spamassassin
> Feb 20 11:17:33 dardhal kernel: swap_free: Bad swap offset entry 00bf0000
