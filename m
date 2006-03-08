Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWCHJLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWCHJLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWCHJLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:11:14 -0500
Received: from mail.gmx.de ([213.165.64.20]:2782 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932528AbWCHJLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:11:11 -0500
X-Authenticated: #14349625
Subject: 2.6.16-rc5-mm3 oopses on modprobe p4_clockmod
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 10:11:47 +0100
Message-Id: <1141809107.7841.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Subject says it all.  This oops is from 100% virgin mm3 source, no
grubby fingerprints of mine, not even a smudge ;-)

	-Mike

cpufreq-core: trying to register driver p4-clockmod
cpufreq-core: adding CPU 0
p4-clockmod: has errata -- disabling frequencies lower than 2ghz
speedstep-lib: x86: f, model: 2
speedstep-lib: ebx value is 9, x86_mask is 9
speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0xf12000f 0x0
speedstep-lib: P4 - FSB 200000 kHz; Multiplier 15; Speed 3000000 kHz
freq-table: setting show_table for cpu 0 to f8a65720
freq-table: table entry 0 is invalid, skipping
freq-table: table entry 1 is invalid, skipping
freq-table: table entry 2 is invalid, skipping
freq-table: table entry 3 is invalid, skipping
freq-table: table entry 4 is invalid, skipping
freq-table: table entry 5 is invalid, skipping
freq-table: table entry 6 is invalid, skipping
freq-table: table entry 7 is invalid, skipping
freq-table: table entry 8 is invalid, skipping
cpufreq-core: initialization failed
cpufreq-core: adding CPU 1
p4-clockmod: has errata -- disabling frequencies lower than 2ghz
speedstep-lib: x86: f, model: 2
speedstep-lib: ebx value is 9, x86_mask is 9
speedstep-lib: P4 - MSR_EBC_FREQUENCY_ID: 0xf12000f 0x0
speedstep-lib: P4 - FSB 200000 kHz; Multiplier 15; Speed 3000000 kHz
freq-table: setting show_table for cpu 1 to f8a65720
freq-table: table entry 0 is invalid, skipping
freq-table: table entry 1: 375000 kHz, 1 index
freq-table: table entry 2: 750000 kHz, 2 index
freq-table: table entry 3: 1125000 kHz, 3 index
freq-table: table entry 4: 1500000 kHz, 4 index
freq-table: table entry 5: 1875000 kHz, 5 index
freq-table: table entry 6: 2250000 kHz, 6 index
freq-table: table entry 7: 2625000 kHz, 7 index
freq-table: table entry 8: 3000000 kHz, 8 index
cpufreq-core: CPU already managed, adding link
cpufreq-core: setting new policy for CPU 1: 375000 - 3000000 kHz
freq-table: request for verification of policy (375000 - 3000000 kHz) for cpu 1
freq-table: verification lead to (375000 - 3000000 kHz) for cpu 1
freq-table: request for verification of policy (375000 - 3000000 kHz) for cpu 1
freq-table: verification lead to (375000 - 3000000 kHz) for cpu 1
cpufreq-core: new min and max freqs are 375000 - 3000000 kHz
cpufreq-core: governor switch
cpufreq-core: __cpufreq_governor for CPU 1, event 1
performance: setting to 3000000 kHz because of event 1
cpufreq-core: target for CPU 1: 3000000 kHz, relation 1
freq-table: request for target 3000000 kHz (relation: 1) for cpu 1
freq-table: target is 8 (3000000 kHz, 8)
cpufreq-core: governor: change or update limits
cpufreq-core: __cpufreq_governor for CPU 1, event 3
performance: setting to 3000000 kHz because of event 3
cpufreq-core: target for CPU 1: 3000000 kHz, relation 1
freq-table: request for target 3000000 kHz (relation: 1) for cpu 1
freq-table: target is 8 (3000000 kHz, 8)
cpufreq-core: initialization complete
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c1540de3
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
last sysfs file: /devices/pci0000:00/0000:00:1e.0/0000:02:09.0/subsystem_device
Modules linked in: p4_clockmod xt_pkttype ipt_LOG xt_limit speedstep_lib freq_table button snd_pcm_oss snd_mixer_oss battery snd_seq snd_seq_device ac edd tda9887 saa7134 ir_kbd_i2c snd_intel8x0 snd_ac97_codec snd_ac97_bus bt878 snd_pcm ohci1394 ieee1394 snd_timer prism54 snd soundcore snd_page_alloc i2c_i801 ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack ip_tables ip6table_filter ip6_tables x_tables tuner bttv video_buf firmware_class ir_common btcx_risc tveeprom nls_iso8859_1 nls_cp437 nls_utf8 sd_mod fan thermal processor
CPU:    1
EIP:    0060:[<c1540de3>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc5-mm3 #9) 
EIP is at register_cpu_notifier+0x0/0x11
eax: c14d0b50   ebx: 00000000   ecx: c15d5f40   edx: c15d5f40
esi: f8a656c4   edi: f8ae9c64   ebp: f0da0e88   esp: f0da0e6c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 7812, threadinfo=f0da0000 task=f40a7000)
Stack: <0>c12c9bb4 00000001 c13f3d93 c13f3da0 f8a656c4 f8a65780 f40a2800 f0da0e98 
       f8cdb03a c102a025 f8a65780 f0da0fb4 c1035296 f8a657c8 c13f0cde f8a6578c 
       000027fe 00000000 f8ae987c f0da0ed8 00000024 00000430 f8d08a80 f8a657c8 
Call Trace:
 <c1003e93> show_stack_log_lvl+0xa9/0xe3   <c100406d> show_registers+0x1a0/0x236
 <c1004381> die+0x12f/0x2ae   <c101390f> do_page_fault+0x353/0x5fa
 <c1003847> error_code+0x4f/0x54   <f8cdb03a> cpufreq_p4_init+0x3a/0x4e [p4_clockmod]
 <c1035296> sys_init_module+0x115/0x1a1e   <c1002cdf> sysenter_past_esp+0x54/0x75
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 1b db 25 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
 


