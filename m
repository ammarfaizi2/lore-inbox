Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWJWUy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWJWUy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWJWUy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:54:28 -0400
Received: from novell.stoldgods.nu ([83.150.147.20]:49066 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP
	id S1751393AbWJWUy1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:54:27 -0400
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm2
Date: Mon, 23 Oct 2006 22:54:15 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061020015641.b4ed72e5.akpm@osdl.org>
In-Reply-To: <20061020015641.b4ed72e5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610232254.15638.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Friday 20 October 2006 10:56, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> 
> - Added the IOAT tree as git-ioat.patch (Chris Leech)
> 
> - I worked out the git magic to make the wireless tree work
>   (git-wireless.patch).  Hopefully it will be in -mm more often now.
> 

I get this BUG and oops everytime I try to start kmail, so I had to fall back to 2.6.18-mm2
to send this mail:

[  316.283343] BUG: sleeping function called from invalid context at mm/slab.c:3014
[  316.305500] in_atomic():0, irqs_disabled():1
[  316.318287]  [<c01042af>] show_trace_log_lvl+0x2f/0x50
[  316.333723]  [<c01042f7>] show_trace+0x27/0x30
[  316.347084]  [<c0104424>] dump_stack+0x24/0x30
[  316.360444]  [<c011d332>] __might_sleep+0xa2/0xc0
[  316.374587]  [<c016d0a4>] kmem_cache_alloc+0x84/0xa0
[  316.389505]  [<c0178029>] getname+0x29/0x70
[  316.402086]  [<c0179ffc>] __user_walk_fd+0x1c/0x70
[  316.416487]  [<c016e834>] sys_faccessat+0x94/0x150
[  316.430886]  [<c016e910>] sys_access+0x20/0x30
[  316.444249]  [<c0103518>] syscall_call+0x7/0xb
[  316.457609]  =======================
[  316.472382] ------------[ cut here ]------------
[  316.486230] kernel BUG at fs/buffer.c:1243!
[  316.498758] invalid opcode: 0000 [#1]
[  316.509725] PREEMPT 
[  316.516327] last sysfs file: /devices/pci0000:00/0000:00:09.0/modalias
[  316.535875] Modules linked in: snd_seq_midi snd_seq_oss ipaq usbserial dvb_bt8xx dvb_pll bt878 tuner bttv video_buf ir_common btcx_risc tveeprom eeprom snd_seq_dummy snd_pcm_oss snd_mixer_oss snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_page_alloc snd_util_mem snd_hwdep psmouse aic7xxx scsi_transport_spi
[  316.651654] CPU:    0
[  316.651655] EIP:    0060:[<c01952bd>]    Not tainted VLI
[  316.651657] EFLAGS: 00010046   (2.6.19-rc2-mm2 #1)
[  316.688733] EIP is at lookup_bh_lru+0x9d/0xb0
[  316.701765] eax: 00000086   ebx: c16d9040   ecx: d5a31c70   edx: c172d400
[  316.722091] esi: 00008160   edi: 00001000   ebp: d5a31a84   esp: d5a31a74
[  316.742416] ds: 007b   es: 007b   ss: 0068
[  316.754686] Process kmail (pid: 9484, ti=d5a30000 task=ec8ecaa0 task.ti=d5a30000)
[  316.776572] Stack: 00000000 d5a31c80 00008160 c16d9040 d5a31aa4 c01952f8 c16d9040 00008160 
[  316.802046]        00001000 d5a31c80 00001000 00008160 d5a31ac4 c0195358 c16d9040 00008160 
[  316.827518]        00001000 d5a31c80 00008160 d5a31c88 d5a31bd0 c01db853 c16d9040 00008160 
[  316.852991] Call Trace:
[  316.860894]  [<c01042af>] show_trace_log_lvl+0x2f/0x50
[  316.876334]  [<c0104397>] show_stack_log_lvl+0x97/0xc0
[  316.891774]  [<c0104622>] show_registers+0x1f2/0x2a0
[  316.906694]  [<c0104842>] die+0x112/0x230
[  316.918756]  [<c01049ea>] do_trap+0x8a/0xd0
[  316.931335]  [<c0104d55>] do_invalid_op+0xb5/0xc0
[  316.945476]  [<c04eda24>] error_code+0x74/0x7c
[  316.958838]  [<c01952f8>] __find_get_block+0x28/0x60
[  316.973757]  [<c0195358>] __getblk+0x28/0x70
[  316.986597]  [<c01db853>] search_by_key+0xb3/0xda0
[  317.000997]  [<c01c1b6d>] search_by_entry_key+0x2d/0x1f0
[  317.016959]  [<c01c212c>] reiserfs_find_entry+0xac/0x130
[  317.032919]  [<c01c2230>] reiserfs_lookup+0x80/0x150
[  317.047837]  [<c01786f1>] real_lookup+0xc1/0x120
[  317.061719]  [<c01789f7>] do_lookup+0x97/0xd0
[  317.074819]  [<c01791e5>] __link_path_walk+0x7b5/0xe00
[  317.090259]  [<c017987a>] link_path_walk+0x4a/0xd0
[  317.104658]  [<c0179bfd>] do_path_lookup+0x12d/0x1e0
[  317.119580]  [<c0179d0e>] __path_lookup_intent_open+0x3e/0x90
[  317.136840]  [<c0179d95>] path_lookup_open+0x35/0x40
[  317.151760]  [<c017a7ef>] open_namei+0x8f/0x5e0
[  317.165379]  [<c016f1e8>] do_filp_open+0x38/0x60
[  317.179261]  [<c016f59e>] do_sys_open+0x5e/0x110
[  317.193139]  [<c016f677>] sys_open+0x27/0x30
[  317.205982]  [<c0103518>] syscall_call+0x7/0xb
[  317.219341]  =======================
[  317.230050] Code: f0 b8 01 00 00 00 e8 c3 6b f8 ff 89 e0 25 00 e0 ff ff 8b 40 08 a8 08 75 0b 8b 45 f0 83 c4 04 5b 5e 5f c9 c3 e8 75 57 35 00 eb ee <0f> 0b 90 eb fd 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 55 89 
[  317.289888] EIP: [<c01952bd>] lookup_bh_lru+0x9d/0xb0 SS:ESP 0068:d5a31a74
[  317.310578]  


Regards,
Magnus M‰‰tt‰

--
You too can wear a nose mitten.
