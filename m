Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWGNMXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWGNMXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 08:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWGNMXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 08:23:49 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:38946 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161079AbWGNMXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 08:23:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nwm+9xCHuwHq1i+V8LLYz75bbbxTOUrJxT8rSE+HqWxdF1WrqX/btavKmfY4pcNFDbZ4M7FQP0lJMLSXkK8s6rC2isbdtkipjQDVIQoJPFLDYzeZmCvGsudE+7k+lpLRgoRCupBqgaWUcdljGIwowqiPjXkbi3CegD8fMUWQjZ4=
Message-ID: <6bffcb0e0607140523i16cfdd57h5edef428619348f6@mail.gmail.com>
Date: Fri, 14 Jul 2006 14:23:39 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm2
Cc: "Jean Delvare" <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       i2c@lm-sensors.org
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/07/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/
>
> - Patches were merged, added, dropped and fixed.  Nothing particularly exciting.
>

It looks like an i2c bug.

Jul 14 14:12:42 ltg01-fedora smartd[1709]: smartd is exiting (exit status 0)
Jul 14 14:12:43 ltg01-fedora kernel: BUG: unable to handle kernel NULL
pointer dereference at virtual address 00000008
Jul 14 14:12:43 ltg01-fedora kernel:  printing eip:
Jul 14 14:12:43 ltg01-fedora kernel: c01f9f1a
Jul 14 14:12:43 ltg01-fedora kernel: *pde = 00000000
Jul 14 14:12:43 ltg01-fedora kernel: Oops: 0000 [#1]
Jul 14 14:12:43 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
Jul 14 14:12:43 ltg01-fedora kernel: last sysfs file:
/devices/platform/i2c-9191/9191-0290/temp2_input
Jul 14 14:12:43 ltg01-fedora kernel: Modules linked in: ipv6 w83627hf
hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios
_ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp
iptable_filter ip_tables x_tables cpufreq_userspace p4_clockmod spe
edstep_lib binfmt_misc thermal processor fan container parport_pc
parport nvram evdev snd_intel8x0 snd_ac97_codec snd_ac97_b
us snd_seq_dummy sk98lin snd_seq_oss snd_seq_midi_event snd_seq skge
snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_ti
mer intel_agp snd agpgart ide_cd i2c_i801 soundcore cdrom
snd_page_alloc rtc unix
Jul 14 14:12:43 ltg01-fedora kernel: CPU:    0
Jul 14 14:12:43 ltg01-fedora kernel: EIP:    0060:[<c01f9f1a>]    Not
tainted VLI
Jul 14 14:12:43 ltg01-fedora kernel: EFLAGS: 00010246   (2.6.18-rc1-mm2 #73)
Jul 14 14:12:43 ltg01-fedora kernel: EIP is at _raw_spin_lock+0xd/0x12e
Jul 14 14:12:43 ltg01-fedora kernel: eax: 00000000   ebx: 00000000
ecx: c0356e8c   edx: 00000000
Jul 14 14:12:43 ltg01-fedora kernel: esi: 00000000   edi: c037efe0
ebp: f5019eb0   esp: f5019ea0
Jul 14 14:12:43 ltg01-fedora kernel: ds: 007b   es: 007b   ss: 0068
Jul 14 14:12:43 ltg01-fedora kernel: Process modprobe (pid: 8927,
ti=f5019000 task=f4d16930 task.ti=f5019000)
Jul 14 14:12:43 ltg01-fedora kernel: Stack: 00000014 00000000 00000000
c037efe0 f5019ec8 c02ea1fa 00000000 00000002
Jul 14 14:12:43 ltg01-fedora kernel:        c02e6cab f6b50e9c f5019ed8
c02e6cab 00000000 f6b50df4 f5019eec c024aa70
Jul 14 14:12:43 ltg01-fedora kernel:        f6b50df4 f6b50df4 f6b51030
f5019f04 c0249913 fdbbcb6c f6b50df4 fdbbcb20
Jul 14 14:12:43 ltg01-fedora kernel: Call Trace:
Jul 14 14:12:43 ltg01-fedora kernel:  [<c02ea1fa>] _spin_lock+0x2a/0x32
Jul 14 14:12:43 ltg01-fedora kernel:  [<c02e6cab>] klist_remove+0x10/0x2c
Jul 14 14:12:43 ltg01-fedora kernel:  [<c024aa70>] bus_remove_device+0x7a/0x91
Jul 14 14:12:43 ltg01-fedora kernel:  [<c0249913>] device_del+0x124/0x158
Jul 14 14:12:43 ltg01-fedora kernel:  [<c0249952>] device_unregister+0xb/0x15
Jul 14 14:12:43 ltg01-fedora kernel:  [<c0294737>] i2c_detach_client+0xb4/0xce
Jul 14 14:12:43 ltg01-fedora kernel:  [<fdba4066>]
w83627hf_detach_client+0x20/0x4a [w83627hf]
Jul 14 14:12:43 ltg01-fedora kernel:  [<fdbbc03b>]
i2c_isa_del_driver+0x1e/0x66 [i2c_isa]
Jul 14 14:12:43 ltg01-fedora kernel:  [<fdba6459>]
sensors_w83627hf_exit+0xd/0xf [w83627hf]
Jul 14 14:12:43 ltg01-fedora kernel:  [<c01407a6>] sys_delete_module+0x194/0x1be
Jul 14 14:12:43 ltg01-fedora kernel:  [<c0103115>] sysenter_past_esp+0x56/0x8d
Jul 14 14:12:43 ltg01-fedora kernel: Code: f0 89 03 c7 43 08 ad 4e ad
de c7 43 10 ff ff ff ff c7 43 0c ff ff ff ff 5a 5b 5e
5f 5d c3 55 89 e5 57 56 53 83 ec 04 89 c3 31 d2 <81> 78 08 ad 4e ad de
0f 95 c2 b8 84 c2 36 c0 e8 92 12 00 00 85
Jul 14 14:12:43 ltg01-fedora kernel: EIP: [<c01f9f1a>]
_raw_spin_lock+0xd/0x12e SS:ESP 0068:f5019ea0
Jul 14 14:12:43 ltg01-fedora kernel:  <3>BUG: sleeping function called
from invalid context at /usr/src/linux-mm/kernel/rwse
m.c:20
Jul 14 14:12:43 ltg01-fedora kernel: in_atomic():1, irqs_disabled():0
Jul 14 14:12:43 ltg01-fedora kernel:  [<c010418a>] show_trace_log_lvl+0x54/0xfd
Jul 14 14:12:43 ltg01-fedora kernel:  [<c01047ff>] show_trace+0xd/0x10
Jul 14 14:12:43 ltg01-fedora kernel:  [<c010491e>] dump_stack+0x19/0x1b
Jul 14 14:12:43 ltg01-fedora kernel:  [<c0118e8d>] __might_sleep+0x8d/0x95
Jul 14 14:12:43 ltg01-fedora kernel:  [<c0135755>] down_read+0x15/0x3b
Jul 14 14:12:43 ltg01-fedora kernel:  [<c012cc5f>]
blocking_notifier_call_chain+0x11/0x2d
Jul 14 14:12:43 ltg01-fedora kernel:  [<c012cc92>] notify_watchers+0x17/0x53
Jul 14 14:12:43 ltg01-fedora kernel:  [<c0122a35>] do_exit+0x26/0xa27
Jul 14 14:12:43 ltg01-fedora kernel:  [<c010470a>] die+0x2a7/0x2cd
Jul 14 14:12:43 ltg01-fedora kernel: Kernel logging (proc) stopped.

Here is a config file
http://www.stardust.webpages.pl/files/mm/2.6.18-rc1-mm2/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
