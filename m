Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbUDFAFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 20:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbUDFAFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 20:05:18 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:55721 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S263544AbUDFAFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 20:05:02 -0400
Date: Tue, 6 Apr 2004 02:05:00 +0200
From: Jan Killius <jkillius@arcor.de>
To: linux-kernel@vger.kernel.org
Subject: Oops with cpufreq on 2.6.5-mm1
Message-ID: <20040406000500.GA26760@gate.unimatrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5 i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
cpufreq make an Oops on loading. I have attached the oops.

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 8
cpu MHz         : 2002.580
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow
bogomips        : 3923.96
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

/proc/modules:
nvidia 2564468 0 - Live 0xffffffffa017d000
ipv6 242688 8 - Live 0xffffffffa0140000
nfs 102496 1 - Live 0xffffffffa0125000
lockd 60880 2 nfs, Live 0xffffffffa0115000
sunrpc 136032 5 nfs,lockd, Live 0xffffffffa00f2000
ehci_hcd 27528 0 - Live 0xffffffffa00ea000
uhci_hcd 28456 0 - Live 0xffffffffa00e2000
sata_via 5892 0 - Live 0xffffffffa00df000
libata 35456 1 sata_via,[permanent], Live 0xffffffffa00d5000
snd_seq 52928 0 - Live 0xffffffffa00c7000
snd_via82xx 21568 0 - Live 0xffffffffa00c0000
snd_pcm 89996 1 snd_via82xx, Live 0xffffffffa00a9000
snd_timer 22152 2 snd_seq,snd_pcm, Live 0xffffffffa00a2000
snd_ac97_codec 65156 1 snd_via82xx, Live 0xffffffffa0091000
snd_page_alloc 9864 2 snd_via82xx,snd_pcm, Live 0xffffffffa008d000
snd_mpu401_uart 6912 1 snd_via82xx, Live 0xffffffffa008a000
snd_rawmidi 20608 1 snd_mpu401_uart, Live 0xffffffffa0083000
snd_seq_device 7308 2 snd_seq,snd_rawmidi, Live 0xffffffffa0080000
snd 41648 8
snd_seq,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device,
Live 0xffffffffa0074000
usbcore 99056 4 ehci_hcd,uhci_hcd, Live 0xffffffffa005a000
vfat 13824 5 - Live 0xffffffffa0055000
fat 43200 1 vfat, Live 0xffffffffa0049000
sk98lin 149068 1 - Live 0xffffffffa0023000
w83781d 34432 0 - Live 0xffffffffa0019000
i2c_sensor 2816 1 w83781d, Live 0xffffffffa0017000
i2c_isa 2560 0 - Live 0xffffffffa0015000
i2c_dev 10496 0 - Live 0xffffffffa0011000
i2c_core 21124 4 w83781d,i2c_sensor,i2c_isa,i2c_dev, Live
0xffffffffa000a000
cpufreq_powersave 1920 0 - Live 0xffffffffa0008000
cpufreq_userspace 5344 0 - Live 0xffffffffa0005000
powernow_k8 9643 2 - Loading 0xffffffffa0000000

-- 
        Jan

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

Unable to handle kernel NULL pointer dereference at 0000000000000004 RIP:
<ffffffff80269922>{cpufreq_frequency_table_cpuinfo+2}PML4 3e8f6067 PGD 3e963067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Pid: 5201, comm: modprobe Not tainted 2.6.5-mm1
RIP: 0010:[<ffffffff80269922>] <ffffffff80269922>{cpufreq_frequency_table_cpuinfo+2}
RSP: 0018:000001003ecb7d90  EFLAGS: 00010246
RAX: 00000000001e8480 RBX: 000000000000000c RCX: 0000000000000000
RDX: 00000000fffffffb RSI: 0000000000000000 RDI: 000001003fb739c0
RBP: 000001003f40f600 R08: 0000000000000033 R09: 0000000000000003
R10: 00000000ffffffff R11: 0000000000000000 R12: 000000000000020c
R13: 000000000000000c R14: 00000100000f0e88 R15: 000001003fb739c0
FS:  0000003872f0f060(0000) GS:ffffffff803ef580(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
        CR2: 0000000000000004 CR3: 0000000000101000 CR4: 00000000000006e0
Process modprobe (pid: 5201, stackpage=1003e8b5000)
        Stack: ffffffffa0003523 0000000000000002 ffffffff00000002 000001003fbc3c60
        0000000000000001 000001003fb739c0 ffffffff803ba688 000001003fb739e8
        0000000000000000 0000000000517c70
        Call Trace:<ffffffffa0003523>{:powernow_k8:powernowk8_cpu_init+1315}
        <ffffffff802691e1>{cpufreq_add_dev+257} <ffffffff8013333e>{printk+494}
        <ffffffff80213a09>{sysdev_driver_register+121} <ffffffff802696fb>{cpufreq_register_driver+219}
        <ffffffffa0003698>{:powernow_k8:powernowk8_init+216}
        <ffffffff80149c8e>{sys_init_module+318} <ffffffff8010f172>{system_call+126}


Code: 83 7e 04 fe 41 b8 ff ff ff ff 89 ca 74 22 31 c0 8b 44 c6 04
RIP <ffffffff80269922>{cpufreq_frequency_table_cpuinfo+2} RSP <000001003ecb7d90>
CR2: 0000000000000004


--opJtzjQTFsWo+cga--
