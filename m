Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVHAPSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVHAPSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVHAPRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:17:32 -0400
Received: from dsl3-63-249-67-69.cruzio.com ([63.249.67.69]:51693 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S261288AbVHAPRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:17:31 -0400
Date: Mon, 1 Aug 2005 08:17:28 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508011517.j71FHS6N010568@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.3 Oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stock 2.6.12.3 #2 Sun Jul 31 16:55:16 PDT 2005 i686 i686 i386 GNU/Linux

Seems to be triggered by mplayer but not right away (30 minutes sometimes), sometimes
no mplayer is necessary.

This is a busy machine. There is continuous usb soundcard (3 soundcards) and
usb ethernet activity (news server and alot of downloading) and video is being
read continuously from the bt878 card.

Any suggestions for workarounds are greatly appreciated. I'm going to try running
with swap off and see if that helps.

Please let me know of any debugging/testing that I can help you with.

Jul 31 17:35:41 cichlid kernel: Linux version 2.6.12.3 (root@athlon) (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #2 Sun Jul 31 16:55:16 PDT 2005
...
Jul 31 17:35:42 cichlid kernel: Kernel command line: ro root=LABEL=/ rhgb vga=791 pci=noacpi noapic acpi=ht
...
Jul 31 18:39:30 cichlid kernel: Unable to handle kernel paging request at virtual address 29262829
Jul 31 18:39:30 cichlid kernel:  printing eip:
Jul 31 18:39:30 cichlid kernel: c014788a
Jul 31 18:39:30 cichlid kernel: *pde = 00000000
Jul 31 18:39:30 cichlid kernel: Oops: 0002 [#1]
Jul 31 18:39:30 cichlid kernel: PREEMPT 
Jul 31 18:39:30 cichlid kernel: Modules linked in: emi26 ipt_TOS ipt_state vfat fat softdog ipt_REJECT ipt_MASQUERADE ipt_LOG ipt_multiport ip_nat_ftp ip_conntrack_ftp iptable_mangle iptable_nat ip_conntrack usb_storage ftdi_sio usbserial dsbr100 snd_seq_midi snd_seq_midi_event snd_seq parport_pc lp parport md5 ipv6 autofs4 sunrpc iptable_filter ip_tables loop dm_mod ohci1394 ieee1394 uhci_hcd ehci_hcd bt878 bttv video_buf v4l2_common btcx_risc tveeprom videodev nvidiafb i2c_algo_bit i2c_i801 i2c_core snd_usb_audio snd_usb_lib snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart snd_rawmidi snd_seq_device snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc kaweth usbnet mii floppy ext3 jbd ata_piix libata 3w_xxxx sd_mod scsi_mod
Jul 31 18:39:30 cichlid kernel: CPU:    0
Jul 31 18:39:30 cichlid kernel: EIP:    0060:[free_block+106/224]    Not tainted VLI
Jul 31 18:39:30 cichlid kernel: EIP:    0060:[<c014788a>]    Not tainted VLI
Jul 31 18:39:30 cichlid kernel: EFLAGS: 00010006   (2.6.12.3) 
Jul 31 18:39:30 cichlid kernel: EIP is at free_block+0x6a/0xe0
Jul 31 18:39:30 cichlid kernel: eax: 29262825   ebx: d67ad000   ecx: d67ad02c   edx: d0878000
Jul 31 18:39:30 cichlid kernel: esi: c19fc900   edi: 00000014   ebp: c194fe44   esp: c194fe2c
Jul 31 18:39:30 cichlid kernel: ds: 007b   es: 007b   ss: 0068
Jul 31 18:39:30 cichlid kernel: Process kswapd0 (pid: 85, threadinfo=c194e000 task=f7f81520)
Jul 31 18:39:30 cichlid kernel: Stack: c19fc91c 0000001b f7ce2690 f7ce2690 00000282 c19fc900 c194fe68 c014794b 
Jul 31 18:39:30 cichlid kernel:        f7dbdc00 d0878c6c 0000001b f7ce2680 f7ce2680 00000282 c55f456c c194fe7c 
Jul 31 18:39:30 cichlid kernel:        c0147b3d c55f4600 c194feb4 0000005c c194fe88 c0177da4 c55f4600 c194fe9c 
Jul 31 18:39:30 cichlid kernel: Call Trace:
Jul 31 18:39:30 cichlid kernel:  [show_stack+122/144] show_stack+0x7a/0x90
Jul 31 18:39:30 cichlid kernel:  [<c0103e5a>] show_stack+0x7a/0x90
Jul 31 18:39:30 cichlid kernel:  [show_registers+329/448] show_registers+0x149/0x1c0
Jul 31 18:39:30 cichlid kernel:  [<c0103fd9>] show_registers+0x149/0x1c0
Jul 31 18:39:30 cichlid kernel:  [die+221/368] die+0xdd/0x170
Jul 31 18:39:30 cichlid kernel:  [<c01041dd>] die+0xdd/0x170
Jul 31 18:39:30 cichlid kernel:  [do_page_fault+1102/1586] do_page_fault+0x44e/0x632
Jul 31 18:39:30 cichlid kernel:  [<c011804e>] do_page_fault+0x44e/0x632
Jul 31 18:39:30 cichlid kernel:  [error_code+79/84] error_code+0x4f/0x54
Jul 31 18:39:30 cichlid kernel:  [<c0103aab>] error_code+0x4f/0x54
Jul 31 18:39:30 cichlid kernel:  [cache_flusharray+75/192] cache_flusharray+0x4b/0xc0
Jul 31 18:39:30 cichlid kernel:  [<c014794b>] cache_flusharray+0x4b/0xc0
Jul 31 18:39:30 cichlid kernel:  [kmem_cache_free+61/80] kmem_cache_free+0x3d/0x50
Jul 31 18:39:30 cichlid kernel:  [<c0147b3d>] kmem_cache_free+0x3d/0x50
Jul 31 18:39:30 cichlid kernel:  [destroy_inode+84/96] destroy_inode+0x54/0x60
Jul 31 18:39:30 cichlid kernel:  [<c0177da4>] destroy_inode+0x54/0x60
Jul 31 18:39:30 cichlid kernel:  [dispose_list+31/144] dispose_list+0x1f/0x90
Jul 31 18:39:30 cichlid kernel:  [<c017809f>] dispose_list+0x1f/0x90
Jul 31 18:39:30 cichlid kernel:  [prune_icache+358/560] prune_icache+0x166/0x230
Jul 31 18:39:30 cichlid kernel:  [<c0178486>] prune_icache+0x166/0x230
Jul 31 18:39:30 cichlid kernel:  [shrink_icache_memory+23/64] shrink_icache_memory+0x17/0x40
Jul 31 18:39:30 cichlid kernel:  [<c0178567>] shrink_icache_memory+0x17/0x40
Jul 31 18:39:30 cichlid kernel:  [shrink_slab+253/352] shrink_slab+0xfd/0x160
Jul 31 18:39:30 cichlid kernel:  [<c014998d>] shrink_slab+0xfd/0x160
Jul 31 18:39:30 cichlid kernel:  [balance_pgdat+601/928] balance_pgdat+0x259/0x3a0
Jul 31 18:39:30 cichlid kernel:  [<c014ae19>] balance_pgdat+0x259/0x3a0
Jul 31 18:39:30 cichlid kernel:  [kswapd+220/304] kswapd+0xdc/0x130
Jul 31 18:39:30 cichlid kernel:  [<c014b03c>] kswapd+0xdc/0x130
Jul 31 18:39:30 cichlid kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Jul 31 18:39:30 cichlid kernel:  [<c0101355>] kernel_thread_helper+0x5/0x10
Jul 31 18:39:30 cichlid kernel: Code: 1c 89 43 04 47 3b 7d ec 7d 77 8b 45 f0 8b 15 f0 76 43 c0 8b 0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 10 1c 8b 53 04 8b 03 <89> 50 04 89 02 8b 43 0c c7 03 00 01 10 00 31 d2 c7 43 04 00 02 
Jul 31 18:39:31 cichlid kernel:  <6>note: kswapd0[85] exited with preempt_count 1

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2594.440
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 5144.57


