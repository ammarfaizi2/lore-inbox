Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268717AbUILM7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268717AbUILM7d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268714AbUILM7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 08:59:33 -0400
Received: from eta.fastwebnet.it ([213.140.2.50]:5352 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S268702AbUILM7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 08:59:25 -0400
From: Willy Gardiol <willy@gardiol.org>
Reply-To: willy@gardiol.org
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:  gzip locks while decompressing a particular file when on NFS v.3
Date: Sun, 12 Sep 2004 14:59:23 +0200
User-Agent: KMail/1.6.2
Cc: linux-net@vger.kernel.org, WilIy Gardiol <willy@gardiol.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409121459.23856.willy@gardiol.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Problem: gzip hangs inside a kernel call when decompressing X430src-3.tgz 
(part of xfree86) on a NFS root system.

Full description: When i try to gunzip (or untar with -zx) the X430src-3.tgz 
archive (its MD5 checksum is correct) over a NFS mounted filesystem it hangs 
at the file 
xc/programs/Xserver/XpConfig/C/print/models/SPSPARC2/fonts/AvantGarde-Demi.pmf
every time. The only way to kill the stalled gzip is to reboot. The gunzip 
does not use CPU nor much ram. Tha same .tgz correctly decompress on a local 
hard drive on the same machine / same config.

keywords: NFS, KERNEL 2.6, NFSROOT, HANG

kernel version: 2.6.8 

Trigger: grab that file from xfree86 ftp site and decompress on a NFS mounted 
filesystem

Environment:
Linux shimitar 2.6.8-gentoo-r3 #1 Tue Aug 31 17:35:53 CEST 2004 i686 Mobile 
AMD Athl AuthenticAMD GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         nvidia lp vmnet parport_pc parport vmmon snd_seq_midi 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul 
snd_emu10k1 snd_rawmidi snd_ac97_codec snd_util_mem snd_hwdep snd_seq_oss 
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_pcm snd_page_alloc 
snd_timer snd_mixer_oss snd rtl8150 8139too thermal fan processor button 
battery ac bttv evdev tuner tvaudio video_buf i2c_algo_bit v4l2_common 
btcx_risc videodev soundcore usbhid via686a w83781d i2c_sensor i2c_isa 
i2c_core usblp usb_storage ohci_hcd ehci_hcd uhci_hcd usbcore sg sd_mod 
ide_scsi ide_cd sr_mod cdrom
"

System is Gentoo, gzip 1.3.5 tar 1.14

CPU info: shimitar scripts # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : Mobile AMD Athl
stepping        : 0
cpu MHz         : 1603.845
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3178.49

Workaround: uncompress the file on a local hard drive then copy the files on 
the NFS partition. This is not acceptable.

ps: i am not subscribed to the list, please CC me....

bye and thanks.




