Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVIDDFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVIDDFL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 23:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVIDDFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 23:05:11 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:37265 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750818AbVIDDFJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 23:05:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k7agoN7oiEIZeTM1kNtMLD/a8hWkH7NqO9kf4oB6vKBzuTLzYHr/5mkxjk/w1FBBF+Cs8U7SPFTED9qbpxgM+KgP/wsgViD5Su7LD+0mDA0dUVWnh9hNTHxMpvT0GvCq9Z3a6XOOoqPmSYVTMDHxrlaAg0N7zphWmXgABbUQxms=
Message-ID: <dda83e7805090320053b03615d@mail.gmail.com>
Date: Sat, 3 Sep 2005 20:05:05 -0700
From: Bret Towe <magnade@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs4 client bug
In-Reply-To: <dda83e78050903171516948181@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dda83e78050903171516948181@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/05, Bret Towe <magnade@gmail.com> wrote:
> i encountered the following error while using nfs4
> ive hit this error i think twice now not sure what causes it yet tho
> this time the only io related items going on was emerge sync running
> in the background (which shouldnt of touched nfs at all) and xmms
> playing some music
> 
> another problem i had was iowait was showing near 100% but nothing
> over nfs was working
> but no errors or anything was showing in dmesg if i encounter this
> again is there a way to
> find out where it locked up so i can give a report on what the problem is?
> 
> attached is my config the box is an athlon64
> if any further information is needed let me know
> 
> Unable to handle kernel paging request at 0000000000100108 RIP:
> <ffffffff80189538>{generic_drop_inode+56}
> PGD 27bec067 PUD 27be9067 PMD 0
> Oops: 0002 [1]
> CPU 0
> Modules linked in: fglrx agpgart snd_seq_midi snd_emu10k1_synth
> snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss
> snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_emu10k1
> snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer
> snd_page_alloc snd_util_mem snd_hwdep snd w83627hf i2c_sensor i2c_isa
> i2c_core usb_storage r8169 ehci_hcd uhci_hcd dm_mirror dm_snapshot
> dm_mod
> Pid: 149, comm: kswapd0 Tainted: P   M  2.6.13
> RIP: 0010:[<ffffffff80189538>] <ffffffff80189538>{generic_drop_inode+56}
> RSP: 0018:ffff81002f9d9b78  EFLAGS: 00010246
> RAX: 0000000000100100 RBX: ffff810022d4d950 RCX: 0000000000200200
> RDX: ffff810022d4d960 RSI: ffff81002ea21000 RDI: ffff810022d4d950
> RBP: ffff810022d4d950 R08: 00000000fffffffa R09: ffff810022d4da68
> R10: 0000000000000001 R11: ffffffff80189500 R12: 0000000000000000
> R13: ffff810022d4d7d0 R14: ffff810022d4d860 R15: ffff81002c3cec00
> FS:  00002aaaabc64f80(0000) GS:ffffffff805bc800(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000100108 CR3: 0000000027468000 CR4: 00000000000006e0
> Process kswapd0 (pid: 149, threadinfo ffff81002f9d8000, task ffff81002f9d2760)
> Stack: ffff81002a65fa00 ffffffff801e2925 000000012f9d9bf8 ffff81002f9d9c28
>        ffffffffffffffff ffff81002f9d9c28 ffff81002f9d9c10 ffff810022d4d938
>        0000000000000001 0000000000000000
> Call Trace:<ffffffff801e2925>{__nfs_revalidate_inode+261}
> <ffffffff80151dcf>{find_get_pages_tag+31}
>        <ffffffff8015af2a>{pagevec_lookup_tag+26}
> <ffffffff801517fe>{wait_on_page_writeback_range+206}
>        <ffffffff801fc0ca>{nfs_do_return_delegation+42}
> <ffffffff801fc1f5>{nfs_inode_return_delegation+197}
>        <ffffffff801e3910>{nfs4_clear_inode+32}
> <ffffffff8018839e>{clear_inode+158}
>        <ffffffff80188fee>{dispose_list+94}
> <ffffffff80189222>{shrink_icache_memory+434}
>        <ffffffff8015b77b>{shrink_slab+219} <ffffffff8015cb99>{balance_pgdat+617}
>        <ffffffff8015c932>{balance_pgdat+2} <ffffffff8015ce17>{kswapd+295}
>        <ffffffff80144730>{autoremove_wake_function+0}
> <ffffffff80144730>{autoremove_wake_function+0}
>        <ffffffff8010f3e6>{child_rip+8} <ffffffff8015ccf0>{kswapd+0}
>        <ffffffff8010f3de>{child_rip+0}
> 
> Code: 48 89 48 08 48 89 01 48 8b 05 8a 4e 30 00 48 89 50 08 48 89
> RIP <ffffffff80189538>{generic_drop_inode+56} RSP <ffff81002f9d9b78>
> CR2: 0000000000100108
>  ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at "fs/inode.c":1142
> invalid operand: 0000 [2]
> CPU 0
> Modules linked in: fglrx agpgart snd_seq_midi snd_emu10k1_synth
> snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss
> snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_emu10k1
> snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer
> snd_page_alloc snd_util_mem snd_hwdep snd w83627hf i2c_sensor i2c_isa
> i2c_core usb_storage r8169 ehci_hcd uhci_hcd dm_mirror dm_snapshot
> dm_mod
> Pid: 9539, comm: rpciod/0 Tainted: P   M  2.6.13
> RIP: 0010:[<ffffffff8018853e>] <ffffffff8018853e>{iput+30}
> RSP: 0018:ffff81002a181e08  EFLAGS: 00010246
> RAX: ffffffff80494a00 RBX: ffff810023da8d40 RCX: ffff81002311f490
> RDX: ffff810022919680 RSI: ffff81002614da40 RDI: ffff810023da8d40
> RBP: ffff8100286af780 R08: ffff8100230f64e0 R09: 0000000000000000
> R10: 0000000000000001 R11: ffffffff801f8c90 R12: ffff81002311f480
> R13: ffff81002614da00 R14: ffff81002c3cec00 R15: ffffffff805c3fb0
> FS:  00002aaaaade6b00(0000) GS:ffffffff805bc800(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 00002aaaaade0680 CR3: 0000000022d19000 CR4: 00000000000006e0
> Process rpciod/0 (pid: 9539, threadinfo ffff81002a180000, task ffff81002a4a2330)
> Stack: ffff81002311f480 ffffffff801fb0fd 00000000fffffff3 ffff81002fb0f1c0
>        ffff8100286af780 ffffffff801efa51 ffff81002fb0f1c0 ffff81002d9be310
>        ffff81002fb0f2a8 ffff81002d9be320
> Call Trace:<ffffffff801fb0fd>{nfs4_put_open_state+109}
> <ffffffff801efa51>{nfs4_close_done+225}
>        <ffffffff803940a5>{__rpc_execute+165}
> <ffffffff8014046a>{worker_thread+442}
>        <ffffffff8012e060>{default_wake_function+0}
> <ffffffff8012e060>{default_wake_function+0}
>        <ffffffff801402b0>{worker_thread+0} <ffffffff8014424d>{kthread+205}
>        <ffffffff8010f3e6>{child_rip+8}
> <ffffffff80144290>{keventd_create_kthread+0}
>        <ffffffff80144180>{kthread+0} <ffffffff8010f3de>{child_rip+0}
> 
> 
> Code: 0f 0b a3 e0 61 3c 80 ff ff ff ff c2 76 04 66 66 66 90 48 85
> RIP <ffffffff8018853e>{iput+30} RSP <ffff81002a181e08>
> 
> 
> 

after moving some files on the server to a new location then trying to
add the files
to xmms playlist i found the following in dmesg after xmms froze
wonder how many more items i can find...

nfs_update_inode: inode number mismatch
expected (0:11/0x27c27), got (0:11/0xe4c7d3)
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "fs/inode.c":1142
invalid operand: 0000 [1]
CPU 0
Modules linked in: fglrx agpgart snd_seq_midi snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_emu10k1
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd w83627hf i2c_sensor i2c_isa
i2c_core usb_storage r8169 ehci_hcd uhci_hcd dm_mirror dm_snapshot
dm_mod
Pid: 11028, comm: gvim Tainted: P   M  2.6.13
RIP: 0010:[<ffffffff8018853e>] <ffffffff8018853e>{iput+30}
RSP: 0018:ffff81000e999c98  EFLAGS: 00010246
RAX: ffffffff80494a00 RBX: ffff810012235d80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff810012235d80 RDI: ffff810012235d80
RBP: ffff810012235d80 R08: ffff81002ccb3d40 R09: ffff81002ccb3cf8
R10: ffff81002ccb3d40 R11: ffffffff80154a40 R12: ffff81000e999d28
R13: ffff81000e999d38 R14: ffff81002cb08cc0 R15: 00007ffffff53b30
FS:  00002aaaafc47b80(0000) GS:ffffffff805bc800(0000) knlGS:00000000563ca620
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000511338 CR3: 0000000011d53000 CR4: 00000000000006e0
Process gvim (pid: 11028, threadinfo ffff81000e998000, task ffff81001a732a60)
Stack: ffff81002ccb3cf8 ffffffff801867c6 ffff81000e999d38 ffff81002ccb3cf8
       ffff81000e999e68 ffffffff8017d2ee 68706f7200000007 00000000fffffff5
       ffff81002fd24001 0000000000000000
Call Trace:<ffffffff801867c6>{dput+390} <ffffffff8017d2ee>{do_lookup+414}
       <ffffffff8017d801>{__link_path_walk+849}
<ffffffff8017e2aa>{link_path_walk+186}
       <ffffffff80229f7a>{strncpy_from_user+74}
<ffffffff8017e521>{path_lookup+385}
       <ffffffff8017e7ee>{__user_walk+62} <ffffffff80178d89>{vfs_stat+41}
       <ffffffff801791df>{sys_newstat+31} <ffffffff8010e8b6>{system_call+126}


Code: 0f 0b a3 e0 61 3c 80 ff ff ff ff c2 76 04 66 66 66 90 48 85
RIP <ffffffff8018853e>{iput+30} RSP <ffff81000e999c98>
 <0>general protection fault: 0000 [2]
CPU 0
Modules linked in: fglrx agpgart snd_seq_midi snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_emu10k1
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd w83627hf i2c_sensor i2c_isa
i2c_core usb_storage r8169 ehci_hcd uhci_hcd dm_mirror dm_snapshot
dm_mod
Pid: 11074, comm: klauncher Tainted: P   M  2.6.13
RIP: 0010:[<ffffffff801de262>] <ffffffff801de262>{nfs_lookup_revalidate+386}
RSP: 0018:ffff81001a341b18  EFLAGS: 00010282
RAX: ed05fe0eed52fe10 RBX: ffff81002195c638 RCX: 425f676209090945
RDX: 0000000000000001 RSI: ffff81001ba065a0 RDI: ffff81001ba065a0
RBP: ffff81001ba065a0 R08: 0000000000000000 R09: 000000000000000b
R10: ffff81002a4e58d8 R11: 0000000000000246 R12: ffff81001bd2d2d8
R13: ffff810012235270 R14: ffff81001a341e68 R15: 00007ffffff4b400
FS:  00002aaaaea99a00(0000) GS:ffffffff805bc800(0000) knlGS:00000000563ca620
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaab1c4520 CR3: 0000000018294000 CR4: 00000000000006e0
Process klauncher (pid: 11074, threadinfo ffff81001a340000, task
ffff81001ab2f440)
Stack: ffff81001a341cd8 00008001000002c7 30ba174331000000 0000000000000000
       0000000000000000 0000000000000000 ffff810013cf38d8 ffff81002e2a0a00
       0000000000000000 ffff810028b56700
Call Trace:<ffffffff801e2f85>{nfs_revalidate_inode+37}
<ffffffff801de34c>{nfs_lookup_revalidate+620}
       <ffffffff80394c90>{rpcauth_lookup_credcache+320}
<ffffffff80394c4b>{rpcauth_lookup_credcache+251}
       <ffffffff801de95d>{nfs_open_revalidate+269}
<ffffffff8017d2cb>{do_lookup+379}
       <ffffffff8017dd6d>{__link_path_walk+2237}
<ffffffff8017e2aa>{link_path_walk+186}
       <ffffffff80229f7a>{strncpy_from_user+74}
<ffffffff8017e521>{path_lookup+385}
       <ffffffff8017e7ee>{__user_walk+62} <ffffffff80178df6>{vfs_lstat+38}
       <ffffffff8017922f>{sys_newlstat+31} <ffffffff8010e8b6>{system_call+126}


Code: 48 8b b8 50 02 00 00 74 17 41 8b 46 20 a8 40 75 19 a8 14 75
RIP <ffffffff801de262>{nfs_lookup_revalidate+386} RSP <ffff81001a341b18>
 <0>general protection fault: 0000 [3]
CPU 0
Modules linked in: fglrx agpgart snd_seq_midi snd_emu10k1_synth
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss
snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_emu10k1
snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd w83627hf i2c_sensor i2c_isa
i2c_core usb_storage r8169 ehci_hcd uhci_hcd dm_mirror dm_snapshot
dm_mod
Pid: 11067, comm: konsole Tainted: P   M  2.6.13
RIP: 0010:[<ffffffff801de262>] <ffffffff801de262>{nfs_lookup_revalidate+386}
RSP: 0018:ffff81000f4f1b18  EFLAGS: 00010282
RAX: ed05fe0eed52fe10 RBX: ffff81002195c638 RCX: 425f676209090945
RDX: 0000000000000001 RSI: ffff81001ba065a0 RDI: ffff81001ba065a0
RBP: ffff81001ba065a0 R08: 0000000000000000 R09: 000000000000000b
R10: ffff81002a4e58d8 R11: 0000000000000246 R12: ffff81001bd2d2d8
R13: ffff810012235270 R14: ffff81000f4f1e68 R15: 00007fffffc71c60
FS:  00002aaaaef4c0a0(0000) GS:ffffffff805bc800(0000) knlGS:00000000563ca620
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fffffc70c48 CR3: 000000001cab2000 CR4: 00000000000006e0
Process konsole (pid: 11067, threadinfo ffff81000f4f0000, task ffff810018467900)
Stack: ffff81000f4f1cd8 0000000000000001 ffff81002e347240 ffff810018467900
       ffff810018467938 0000000000000073 0000023459aab717 ffffffff803a4ee0
       ffff81000f4f1bd8 0000000000000082
Call Trace:<ffffffff803a4ee0>{thread_return+0}
<ffffffff801e2f85>{nfs_revalidate_inode+37}
       <ffffffff801de34c>{nfs_lookup_revalidate+620}
<ffffffff803a580e>{schedule_timeout+30}
       <ffffffff80394c4b>{rpcauth_lookup_credcache+251}
<ffffffff801de95d>{nfs_open_revalidate+269}
       <ffffffff8017d2cb>{do_lookup+379}
<ffffffff8017dd6d>{__link_path_walk+2237}
       <ffffffff8017e2aa>{link_path_walk+186}
<ffffffff80229f7a>{strncpy_from_user+74}
       <ffffffff8017e521>{path_lookup+385} <ffffffff8017e7ee>{__user_walk+62}
       <ffffffff80178df6>{vfs_lstat+38} <ffffffff8017922f>{sys_newlstat+31}
       <ffffffff8010e8b6>{system_call+126}

Code: 48 8b b8 50 02 00 00 74 17 41 8b 46 20 a8 40 75 19 a8 14 75
RIP <ffffffff801de262>{nfs_lookup_revalidate+386} RSP <ffff81000f4f1b18>
