Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUJOCpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUJOCpS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUJOCpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:45:18 -0400
Received: from mxsf13.cluster1.charter.net ([209.225.28.213]:26587 "EHLO
	mxsf13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S263736AbUJOCpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:45:02 -0400
X-Ironport-AV: i="3.85,143,1094443200"; 
   d="scan'208"; a="337252969:sNHT15385572"
Message-ID: <416F39AA.9080608@charter.net>
Date: Thu, 14 Oct 2004 21:44:58 -0500
From: Frank Phillips <frankalso@charter.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 oops on java
References: <20041014210606.GA23179@butterfly.hjsoft.com>
In-Reply-To: <20041014210606.GA23179@butterfly.hjsoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John M Flinchbaugh wrote:

> when i try to start jboss 4.0.0 (sun jdk 1.5.0), i get this oops.
> trying to start the simple shutdown program does the same thing.
>
> otherwise, it's debian unstable, 1.4Ghz pentium m, thinkpad r40.
>
> Unable to handle kernel paging request at virtual address 00013c1c
> printing eip:
> c011cdc4
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: ipv6 thermal fan button ac battery snd_intel8x0 
> snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd 
> soundcore snd_page_alloc cpufreq_userspace cpufreq_powersave 
> speedstep_centrino processor ide_cd cdrom evdev psmouse autofs4 
> af_packet ntfs agpgart e100 mii ds yenta_socket pcmcia_core rtc
> CPU: 0
> EIP: 0060:[<c011cdc4>] Not tainted VLI
> EFLAGS: 00010082 (2.6.9-rc4-mm1)
> EIP is at profile_hit+0x24/0x28
> eax: 00000000 ebx: 000009c9 ecx: 00000000 edx: 00013c1c
> esi: 00000000 edi: ffffffea ebp: df2c8f94 esp: df2c8f94
> ds: 007b es: 007b ss: 0068
> Process java (pid: 2505, threadinfo=df2c8000 task=df15e510)
> Stack: df2c8fbc c0118a9b df15e510 c03bd3e0 00000000 00000082 0000000a 
> 000009c9
> 00000001 aa170bb0 df2c8000 c010512f 000009c9 00000000 aa170a20 00000001
> aa170bb0 aa170a20 0000009c 0000007b 0000007b 0000009c b7f50504 00000073
> Call Trace:
> [<c0105f1a>] show_stack+0x7a/0x90
> [<c0106099>] show_registers+0x149/0x1b0
> [<c010628d>] die+0xdd/0x180
> [<c01169f1>] do_page_fault+0x2f1/0x60b
> [<c0105b7d>] error_code+0x2d/0x38
> [<c0118a9b>] setscheduler+0xab/0x230
> [<c010512f>] syscall_call+0x7/0xb
> Code: ec 5d c3 8d 74 26 00 55 8b 0d 6c e6 3d c0 81 ea 28 02 10 c0 a1 
> 68 e6 3d c0 89 e5 d3 ea 48 39 d0 0f 46 d0 a1 64 e6 3d c0 8d 14 90 <ff> 
> 02 5d c3 51 52 e8 11 94 1a 00 5a 59 e9 ef f9 ff ff 66 4a 0f
> <6>note: java[2505] exited with preempt_count 2
> Unable to handle kernel paging request at virtual address 00013c1c
> printing eip:
> c011cdc4
> *pde = 00000000
> Oops: 0002 [#2]
> PREEMPT
> Modules linked in: ipv6 thermal fan button ac battery snd_intel8x0 
> snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd 
> soundcore snd_page_alloc cpufreq_userspace cpufreq_powersave 
> speedstep_centrino processor ide_cd cdrom evdev psmouse autofs4 
> af_packet ntfs agpgart e100 mii ds yenta_socket pcmcia_core rtc
> CPU: 0
> EIP: 0060:[<c011cdc4>] Not tainted VLI
> EFLAGS: 00010082 (2.6.9-rc4-mm1)
> EIP is at profile_hit+0x24/0x28
> eax: 00000000 ebx: 000009b0 ecx: 00000000 edx: 00013c1c
> esi: 00000000 edi: ffffffea ebp: df311f94 esp: df311f94
> ds: 007b es: 007b ss: 0068
> Process java (pid: 2480, threadinfo=df311000 task=df7e25d0)
> Stack: df311fbc c0118a9b df7e25d0 c03bd3e0 df311fbc 00000082 00000005 
> 000009b0
> 00000001 b7e88080 df311000 c010512f 000009b0 00000000 bfffd5a8 00000001
> b7e88080 bfffd5a8 0000009c 0000007b 0000007b 0000009c b7f50504 00000073
> Call Trace:
> [<c0105f1a>] show_stack+0x7a/0x90
> [<c0106099>] show_registers+0x149/0x1b0
> [<c010628d>] die+0xdd/0x180
> [<c01169f1>] do_page_fault+0x2f1/0x60b
> [<c0105b7d>] error_code+0x2d/0x38
> [<c0118a9b>] setscheduler+0xab/0x230
> [<c010512f>] syscall_call+0x7/0xb
> Code: ec 5d c3 8d 74 26 00 55 8b 0d 6c e6 3d c0 81 ea 28 02 10 c0 a1 
> 68 e6 3d c0 89 e5 d3 ea 48 39 d0 0f 46 d0 a1 64 e6 3d c0 8d 14 90 <ff> 
> 02 5d c3 51 52 e8 11 94 1a 00 5a 59 e9 ef f9 ff ff 66 4a 0f
> <6>note: java[2480] exited with preempt_count 2
> scheduling while atomic: java/0x04000002/2480
> [<c0105f47>] dump_stack+0x17/0x20
> [<c02c584f>] schedule+0x51f/0x530
> [<c02c5d70>] cond_resched+0x30/0x50
> [<c0149d03>] unmap_vmas+0x1a3/0x200
> [<c014e2c4>] exit_mmap+0x74/0x160
> [<c0119955>] mmput+0x35/0xd0
> [<c011e4a2>] do_exit+0x152/0x450
> [<c0106322>] die+0x172/0x180
> [<c01169f1>] do_page_fault+0x2f1/0x60b
> [<c0105b7d>] error_code+0x2d/0x38
> [<c0118a9b>] setscheduler+0xab/0x230
> [<c010512f>] syscall_call+0x7/0xb

This should fix it:
cd /path/to/your/kernel/source
wget
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/nroken-out/optimize-profile-path-slightly.patch 


patch -R -p1 -i optimize-profile-path-slightly.patch

Frank
