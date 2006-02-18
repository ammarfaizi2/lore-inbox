Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWBRART@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWBRART (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWBRART
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:17:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:4065 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751073AbWBRARS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:17:18 -0500
X-Authenticated: #31060655
Message-ID: <43F6678C.5080001@gmx.net>
Date: Sat, 18 Feb 2006 01:17:16 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: oops during boot of 2.6.16-rc3-git7 on AMD64
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

vanilla 2.6.16-rc3-git7 gives me the following oops during boot (most
of the time while mounting all filesystems) on my amd64 machine:

(hand-written, no serial interface available)
Unable to handle kernel NULL pointer dereference at 00000008
rip: run_timer_softirq+322
process udev
Call trace:
__do_softirq+68
call_softirq+30
do_softirq+46
do_IRQ+61
ret_from_intr+0
EOI

Since the oops happens in an interrupt every time I got it, it
locked the machine hard with a kernel panic message.

The same machine runs fine with 2.6.15-git1 and previous kernels.
switch:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 31
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 0
cpu MHz         : 1000.000
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm 3dnowext 3dnow lahf_lm
bogomips        : 2012.44
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

Modules loaded:
cls_u32 sch_htb ipt_physdev iptable_filter ip_tables ebtable_filter
ebt_arpreply ebt_arp ebt_ip ebtable_nat ebtables bridge cpufreq_userspace
powernow_k8 freq_table thermal processor fan button battery ac ipv6
floppy snd_pcm_oss snd_mixer_oss twofish cryptoloop edd joydev st sr_mod
video1394 raw1394 capability commoncap sg ohci1394 ieee1394 sky2 ehci_hcd
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore
snd_page_alloc forcedeth ohci_hcd usbcore parport_pc lp parport reiserfs
ide_cd cdrom ide_disk dm_snapshot dm_mod sata_sil sata_nv libata amd74xx
ide_core sd_mod scsi_mod


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
