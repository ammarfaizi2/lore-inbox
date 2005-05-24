Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVEXBqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVEXBqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 21:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVEXBqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 21:46:00 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:21359 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261286AbVEXBpi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 21:45:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rE4NxGaSN6IMphLAV1LqNOmQ8QuWRuA8jdlupiFSig81RwVubYPJ8KnwvOWL31t1vS16egxEzAklN66pOtl/sRreVbCogE91+ORD2a0DMQJF4Hy5wlWerJRw/TvPAknK165+YSGFm5Miz422I/PVPd2XvG5koP2Iz39g3aSwCvc=
Message-ID: <dda83e78050523184511732ae9@mail.gmail.com>
Date: Mon, 23 May 2005 18:45:37 -0700
From: Bret Towe <magnade@gmail.com>
Reply-To: Bret Towe <magnade@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel oops with powernow-k8 on k8t neo-v
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when trying to get cool-n-quiet working on my msi k8t neo-v motherboard
i get the error below this error is from 2.6.12-rc4-mm2 but happens
with 2.6.11.10
and  2.6.12-rc4 also if compiled into the kernel the system just hangs
and doesnt do any
thing else to get this error message i had to compile it as a module
the cpu is an athlon64 2800+ 754 pin
i noticed some other people having problems with another 754 mobo and
powernow-k8
does the 754 have a different way of changning cpu speeds?
cause i have a k8t neo2 socket 939 and it works fine with linux...

on a side note perhaps unrelated sensors report a 1.6 vcore
before and after powernow blows up
frequency does change tho from what i have it set to orignally in bios to
max which is 1800mhz

any configuration details or logs that are needed just ask im also willing
to test any patchs

[  102.929859] powernow-k8: Found 1 AMD Athlon 64 / Opteron processors
(version 1.40.0)
[  102.935030] powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
[  102.935035] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
[  102.935040] cpu_init done, current fid 0x8, vid 0x0
[  102.944428] Unable to handle kernel paging request at ffff81082ccf65f8 RIP: 
[  102.944451] <ffffffff803a72b5>{cpufreq_stats_update+261}
[  102.944505] PGD 8063 PUD 0 
[  102.944530] Oops: 0002 [1] PREEMPT 
[  102.944556] CPU 0 
[  102.944576] Modules linked in: powernow_k8 ehci_hcd uhci_hcd
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi
snd_seq_midi_emul snd_pcm_oss snd_mixer_oss snd_seq_oss
snd_seq_midi_event snd_seq snd_emu10k1 snd_rawmidi snd_seq_device
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep
snd w83627hf i2c_sensor i2c_isa i2c_core usb_storage 8139too
[  102.944763] Pid: 6590, comm: modprobe Not tainted 2.6.12-rc4-mm2
[  102.944788] RIP: 0010:[<ffffffff803a72b5>]
<ffffffff803a72b5>{cpufreq_stats_update+261}
[  102.944821] RSP: 0018:ffff81002c13faf8  EFLAGS: 00010246
[  102.944857] RAX: 00000000fffcac6e RBX: 0000000000000000 RCX: 0000000000000000
[  102.944883] RDX: 00000000fffcac6e RSI: 0000000000000000 RDI: 00000000ffffffff
[  102.944910] RBP: ffff81002ccf6658 R08: ffff81002ccf6658 R09: ffff81002ccf6600
[  102.944936] R10: 00000000ffffffff R11: 000000000000000b R12: 0000000000000001
[  102.944962] R13: 00000000ffffffff R14: 0000000000000002 R15: 000000000000000a
[  102.944989] FS:  00002aaaaaac9b00(0000) GS:ffffffff806ad840(0000)
knlGS:0000000000000000
[  102.945027] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  102.945052] CR2: ffff81082ccf65f8 CR3: 000000002c7e0000 CR4: 00000000000006e0
[  102.945079] Process modprobe (pid: 6590, threadinfo
ffff81002c13e000, task ffff81002e969830)
[  102.945117] Stack: ffff81002ffe25c0 00000000000000d0
ffff81002c13fbb8 ffffffff803a797a
[  102.945157]        ffff81002c13fbb8 ffffffff80599a20
ffff81002c13fbb8 0000000000000001
[  102.945209]        ffff81002b84c950 ffffffff80152c10 
[  102.945240] Call
Trace:<ffffffff803a797a>{cpufreq_stat_notifier_trans+90}
<ffffffff80152c10>{notifier_call_chain+32}
[  102.945303]       
<ffffffff803a3544>{cpufreq_notify_transition+564}
<ffffffff88132b15>{:powernow_k8:powernowk8_target+1621}
[  102.945367]        <ffffffff803a4dec>{__cpufreq_driver_target+108}
<ffffffff803a7b6e>{cpufreq_governor_performance+62}
[  102.945429]        <ffffffff803a3bdd>{__cpufreq_governor+173}
<ffffffff803a53e5>{__cpufreq_set_policy+805}
[  102.945484]        <ffffffff803a5754>{cpufreq_set_policy+100}
<ffffffff803a5d91>{cpufreq_add_dev+1505}
[  102.945540]        <ffffffff803a56c0>{handle_update+0}
<ffffffff803210eb>{sysdev_driver_register+171}
[  102.945615]        <ffffffff803a6836>{cpufreq_register_driver+710}
<ffffffff80167795>{sys_init_module+309}
[  102.945674]        <ffffffff8010f426>{system_call+126} 
[  102.945726] 
[  102.945727] Code: 49 01 0c f9 48 8b 05 40 ef 30 00 49 89 40 08 48
81 3d 31 c9
[  102.945834] RIP <ffffffff803a72b5>{cpufreq_stats_update+261} RSP
<ffff81002c13faf8>
[  102.945879] CR2: ffff81082ccf65f8
[  102.945899]  <6>note: modprobe[6590] exited with preempt_count 1
[  102.945931] Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
[  102.945969] in_atomic():1, irqs_disabled():1
[  102.945989] 
[  102.945990] Call Trace:<ffffffff801349ef>{__might_sleep+191}
<ffffffff8013eff8>{exit_mm+56}
[  102.946048]        <ffffffff801401a7>{do_exit+439}
<ffffffff801266c3>{do_page_fault+1795}
[  102.946104]        <ffffffff80177ba9>{free_hot_cold_page+249}
<ffffffff802937e9>{vsnprintf+1321}
[  102.946164]        <ffffffff80135126>{try_to_wake_up+582}
<ffffffff8010fdd1>{error_exit+0}
[  102.946221]        <ffffffff803a72b5>{cpufreq_stats_update+261}
<ffffffff803a71c1>{cpufreq_stats_update+17}
[  102.946281]       
<ffffffff803a797a>{cpufreq_stat_notifier_trans+90}
<ffffffff80152c10>{notifier_call_chain+32}
[  102.946337]       
<ffffffff803a3544>{cpufreq_notify_transition+564}
<ffffffff88132b15>{:powernow_k8:powernowk8_target+1621}
[  102.946397]        <ffffffff803a4dec>{__cpufreq_driver_target+108}
<ffffffff803a7b6e>{cpufreq_governor_performance+62}
[  102.946458]        <ffffffff803a3bdd>{__cpufreq_governor+173}
<ffffffff803a53e5>{__cpufreq_set_policy+805}
[  102.946513]        <ffffffff803a5754>{cpufreq_set_policy+100}
<ffffffff803a5d91>{cpufreq_add_dev+1505}
[  102.946569]        <ffffffff803a56c0>{handle_update+0}
<ffffffff803210eb>{sysdev_driver_register+171}
[  102.946640]        <ffffffff803a6836>{cpufreq_register_driver+710}
<ffffffff80167795>{sys_init_module+309}
[  102.946696]        <ffffffff8010f426>{system_call+126}
