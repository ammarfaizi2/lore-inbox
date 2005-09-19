Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVISCs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVISCs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 22:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVISCs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 22:48:29 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:47621 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932291AbVISCs2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 22:48:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cl3lPdAflhre9SLQ2ci5JS294sdXxYzFEhqo2FvZXCl6t1lsIBaCByKYpisQX2VRb14EUYkxr94IbWMAp4De6H+8zlIPNJM+ajnhZdNHrIwA8BK+zrt8y8g1Y8CJawzMQMcVm2/xEM01FZIZ71Mn1GVD/97fd01lnpkAAq3qC9g=
Message-ID: <5d8b7b905091819482a07d85b@mail.gmail.com>
Date: Mon, 19 Sep 2005 05:48:23 +0300
From: "Dr.Dre" <pharon@gmail.com>
Reply-To: pharon@gmail.com
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: PFC <lists@boutiquenumerique.com>, Dan Oglesby <doglesby@teleformix.com>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <25065367-E1E5-4C1E-8B94-8986D17BA224@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
	 <432DCE2A.5070705@slaphack.com> <432DDF7A.3050704@teleformix.com>
	 <op.sxbtg9lzth1vuj@localhost>
	 <25065367-E1E5-4C1E-8B94-8986D17BA224@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a bug report for the first time about reiser4 in 2.6.14-rc1-mm1
with 4k stacks,
preempt and smp. It is the first time I face a bug after using reiser4
for about a year. Well I had to with 4k stacks right ?
firefox has triggerred the bug twice and I had to fsck the filesystem
with --fix --build-fs which fixed the error. After fixing it any
attempt to access the drive resulted in a 'Bus error' message. A sync
and reboot using the sysreq mechanism returned me to a working system.

Sorry if this is not the place to report the bug, or if doesn't get
attatched to the reiser4 thread, I am new to LKML. Thanks in advance.

------------[ cut here ]------------
kernel BUG at <bad filename>:59883!
invalid operand: 0000 [#1]
PREEMPT SMP
last sysfs file: /class/sound/seq/dev
Modules linked in: snd_seq_instr snd_seq_midi_emul snd_seq_midi
snd_seq_midi_event snd_seq firmware_class nls_utf8 nls_cp864 vfat fat
nls_base af_packet joydev tsdev ohci_hcd ehci_hcd yealink usbhid
mousedev nvidia snd_pcm_oss snd_mixer_oss video via_rhine uhci_hcd
usbcore tpm_nsc tpm_infineon tpm_atmel tpm thermal speedstep_lib
snd_cmipci gameport snd_pcm snd_page_alloc snd_opl3_lib snd_timer
snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
shpchp pci_hotplug rtc processor loop intel_agp agpgart i2c_i801
i2c_core fan cpufreq_userspace cpufreq_stats freq_table
cpufreq_powersave cpufreq_ondemand cpufreq_conservative container
button battery
CPU:    0
EIP:    0060:[<c01d56fb>]    Tainted: P      VLI
EFLAGS: 00010297   (2.6.14-rc1-mm1)
EIP is at sub_from_ctx_grabbed+0x2b/0x30
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: 00000000
esi: d24deec0   edi: df69e800   ebp: d50fc9e0   esp: cea25d8c
ds: 007b   es: 007b   ss: 0068
Process firefox-bin (pid: 10393, threadinfo=cea25000 task=de659050)
Stack: 00000001 00000000 c01d63c0 d24deec0 00000001 00000000 de202680 d50fc9e0
      d50fc9e0 ce6cb8d4 c01d8594 d50fc9e0 00000001 00000000 de202680 d50fc9e0
      de2026b4 c01d85e7 de202680 d50fc9e0 00000000 de202680 c01d861e de202680
Call Trace:
 [<c01d63c0>] grabbed2flush_reserved_nolock+0x30/0x70
 [<c01d8594>] do_jnode_make_dirty+0xf4/0x120
 [<c01d85e7>] jnode_make_dirty_locked+0x27/0x40
 [<c01d861e>] znode_make_dirty+0x1e/0x90
 [<c01ef1b5>] update_sd_at+0xc5/0x1f0
 [<c01ef32d>] update_sd+0x4d/0x70
 [<c01ee5fb>] write_sd_by_inode_common+0x8b/0x90
 [<c01e37c8>] reiser4_dirty_inode+0x18/0x70
 [<c0180883>] __mark_inode_dirty+0xb3/0x190
 [<c01784c4>] update_atime+0x54/0x80
 [<c01f1aee>] read_unix_file+0x35e/0x3c0
 [<c015d316>] vfs_read+0xa6/0x140
 [<c015d64d>] sys_read+0x3d/0x70
 [<c0102d7b>] sysenter_past_esp+0x54/0x79
Code: 56 53 8b 74 24 0c 8b 5c 24 14 8b 4c 24 10 8b 56 78 8b 46 74 39
da 76 0d 29 c8 19 da 89 46 74 89 56 78 5b 5e c3 72 04 39 c8 73 ed <0f>
0b eb e9 90 8b 4c 24 04 8b 41 74 8b 51 78 03 44 24 08 13 54
 <6>note: firefox-bin[10393] exited with preempt_count 3


Please request any extra info you need.

Thanks and keep up the good work.
