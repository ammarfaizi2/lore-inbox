Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVEBLpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVEBLpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 07:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVEBLpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 07:45:53 -0400
Received: from [62.53.108.254] ([62.53.108.254]:58007 "EHLO hilly.house")
	by vger.kernel.org with ESMTP id S261205AbVEBLoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 07:44:12 -0400
Message-ID: <42761285.5040306@vu.a.la>
Date: Mon, 02 May 2005 12:44:05 +0100
From: Charlie Brej <brejc8@vu.a.la>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: PROBLEM:Frequent but unpredictable system hangs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the hang happens it simply freezes the system without any 
network/keyboard/anything responses. This can happen while I am hammering the 
machine or in the middle of the night when nothing actively running. But it does 
write the Ooops to the log which I have attached. This happens on both the 
Fedora standard kernel and one I compiled (2.6.11-1.14_FC3 and 
2.6.11.2-kraxel1). The kernel I compiled is patched with the bytesex video4linux 
patch and the Fedora kernel also includes the ATrpms cx88, vide4linux, linux-dvb 
modules. I included the relevant outputs. Happy to provide more information but 
I am unsure which area.

------------------ver_linux-------------------------------
Linux hilly.house 2.6.11-1.14_FC3 #1 Thu Apr 7 19:23:49 EDT 2005 i686 i686 i386 
GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      2.4.26
e2fsprogs              1.36
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   050
Modules Loaded         autofs4 dm_mod video button battery ac md5 ipv6 ohci1394 
ieee1394 yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd ehci_hcd cx8800 
v4l1_compat v4l2_common cx88_dvb cx8802 mt352 cx88xx i2c_algo_bit ir_common 
btcx_risc tveeprom videodev or51132 video_buf_dvb video_buf cx22702 dvb_pll 
budget_ci tda1004x budget_core dvb_core saa7146 ttpci_eeprom stv0299 i2c_sis96x 
i2c_core snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore 
snd_page_alloc b44 mii ext3 jbd

------------------/proc/cpuinfo-------------------------------
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.40GHz
stepping        : 9
cpu MHz         : 2422.243
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat 
pse36 clfl
ush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4800.51

------------------/proc/modules-------------------------------
autofs4 26181 1 - Live 0xf0cea000
dm_mod 59221 0 - Live 0xf0cf3000
video 15813 0 - Live 0xf0c7b000
button 6609 0 - Live 0xf0cdd000
battery 9285 0 - Live 0xf0cd9000
ac 4805 0 - Live 0xf0c83000
md5 4161 1 - Live 0xf0c80000
ipv6 259201 16 - Live 0xf0d20000
ohci1394 39129 0 - Live 0xf0c3c000
ieee1394 309145 1 ohci1394, Live 0xf0c86000
yenta_socket 21065 0 - Live 0xf0c13000
rsrc_nonstatic 10433 1 yenta_socket, Live 0xefaf9000
pcmcia_core 47993 2 yenta_socket,rsrc_nonstatic, Live 0xf0c1a000
ohci_hcd 25685 0 - Live 0xefaf1000
ehci_hcd 39501 0 - Live 0xefad4000
cx8800 30988 0 - Live 0xefadf000
v4l1_compat 12932 1 cx8800, Live 0xefacf000
v4l2_common 5504 1 cx8800, Live 0xefacc000
cx88_dvb 7044 14 - Live 0xefa98000
cx8802 10628 1 cx88_dvb, Live 0xefa94000
mt352 6020 1 cx88_dvb, Live 0xefa91000
cx88xx 50592 3 cx8800,cx88_dvb,cx8802, Live 0xefaa1000
i2c_algo_bit 9033 1 cx88xx, Live 0xefa8d000
ir_common 7044 1 cx88xx, Live 0xef90b000
btcx_risc 4488 3 cx8800,cx8802,cx88xx, Live 0xef911000
tveeprom 11800 1 cx88xx, Live 0xefa7c000
videodev 9665 2 cx8800,cx88xx, Live 0xefa84000
or51132 8964 1 cx88_dvb, Live 0xefa80000
video_buf_dvb 5508 1 cx88_dvb, Live 0xef90e000
video_buf 21764 5 cx8800,cx88_dvb,cx8802,cx88xx,video_buf_dvb, Live 0xefa75000
cx22702 7940 1 cx88_dvb, Live 0xef849000
dvb_pll 3972 3 cx88_dvb,or51132,cx22702, Live 0xef802000
budget_ci 11520 0 - Live 0xef8bd000
tda1004x 12548 1 budget_ci, Live 0xef8f9000
budget_core 11272 1 budget_ci, Live 0xef8b5000
dvb_core 87464 3 video_buf_dvb,budget_ci,budget_core, Live 0xef914000
saa7146 16264 2 budget_ci,budget_core, Live 0xef8f4000
ttpci_eeprom 2304 1 budget_core, Live 0xef81d000
stv0299 8964 1 budget_ci, Live 0xef8b9000
i2c_sis96x 5445 0 - Live 0xef837000
i2c_core 21953 12 
mt352,cx88xx,i2c_algo_bit,tveeprom,or51132,cx22702,budget_ci,tda1004x,bu
dget_core,ttpci_eeprom,stv0299,i2c_sis96x, Live 0xef8cb000
snd_intel8x0 34049 1 - Live 0xef8c1000
snd_ac97_codec 71097 1 snd_intel8x0, Live 0xef866000
snd_pcm 99657 3 snd_intel8x0,snd_ac97_codec, Live 0xef8d3000
snd_timer 33093 1 snd_pcm, Live 0xef8ab000
snd 56741 5 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer, Live 0xef879000
soundcore 10785 1 snd, Live 0xef862000
snd_page_alloc 9669 2 snd_intel8x0,snd_pcm, Live 0xef845000
b44 26053 0 - Live 0xef83d000
mii 4929 1 b44, Live 0xef831000
ext3 131145 2 - Live 0xef889000
jbd 82777 1 ext3, Live 0xef84c000

-------------------/var/log/messages---------------------------

Apr  8 00:01:48 hilly kernel: ------------[ cut here ]------------
Apr  8 00:01:48 hilly kernel: kernel BUG at mm/rmap.c:482!
Apr  8 00:01:48 hilly kernel: invalid operand: 0000 [#1]
Apr  8 00:01:48 hilly kernel: PREEMPT DEBUG_PAGEALLOC
Apr  8 00:01:48 hilly kernel: Modules linked in: autofs4 video button battery ac 
md5 ipv6 ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd 
ehci_hcd cx8800 v4l1_compat v4l2_common cx88_dvb cx8802 mt352 cx88xx 
i2c_algo_bit ir_common btcx_risc tveeprom videodev or51132 video_buf_dvb 
video_buf cx22702 dvb_pll budget_ci tda1004x budget_core dvb_core saa7146 
ttpci_eeprom stv0299 i2c_sis96x i2c_core snd_intel8x0 snd_ac97_codec snd_pcm 
snd_timer snd soundcore snd_page_alloc b44 mii
Apr  8 00:01:48 hilly kernel: CPU:    0
Apr  8 00:01:48 hilly kernel: EIP:    0060:[<c016c2e7>]    Not tainted VLI
Apr  8 00:01:48 hilly kernel: EFLAGS: 00010282   (2.6.11.2-kraxel1)
Apr  8 00:01:48 hilly kernel: EIP is at page_remove_rmap+0x2c/0x40
Apr  8 00:01:48 hilly kernel: eax: fffffff8   ebx: 00000000   ecx: c1056040 
edx: c1056040
Apr  8 00:01:48 hilly kernel: esi: c2a92c58   edi: 00008000   ebp: c1056040 
esp: e6ca1e5c
Apr  8 00:01:48 hilly kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 00:01:48 hilly kernel: Process mlnet (pid: 3832, threadinfo=e6ca1000 
task=e4214a80)
Apr  8 00:01:48 hilly kernel: Stack: c01623db 00000000 00000000 f2089471 
e6ca1e94 02b02067 00000000 b6f16000
Apr  8 00:01:48 hilly kernel:        c0483020 b7316000 e54e3b70 b6f1e000 
c0483020 c0162556 00008000 00000000
Apr  8 00:01:48 hilly kernel:        c0119c9a 00001000 b6f16000 e54e3b70 
b6f1e000 c0483020 c01625a2 00008000
Apr  8 00:01:48 hilly kernel: Call Trace:
Apr  8 00:01:48 hilly kernel:  [<c01623db>] zap_pte_range+0x14b/0x27f
Apr  8 00:01:48 hilly kernel:  [<c0162556>] zap_pmd_range+0x47/0x65
Apr  8 00:01:48 hilly kernel:  [<c0119c9a>] __change_page_attr+0x21/0x17f
Apr  8 00:01:48 hilly kernel:  [<c01625a2>] zap_pud_range+0x2e/0x52
Apr  8 00:01:48 hilly kernel:  [<c016262c>] unmap_page_range+0x66/0x83
Apr  8 00:01:48 hilly kernel:  [<c016274c>] unmap_vmas+0x103/0x39c
Apr  8 00:01:48 hilly kernel:  [<c01677f4>] vma_adjust+0x2dd/0x5b6
Apr  8 00:01:48 hilly kernel:  [<c0157873>] poison_obj+0x1c/0x38
Apr  8 00:01:48 hilly kernel:  [<c0168d4f>] unmap_region+0x72/0xdc
Apr  8 00:01:48 hilly kernel:  [<c0169019>] do_munmap+0x13c/0x26d
Apr  8 00:01:48 hilly kernel:  [<c017b915>] vfs_read+0xc0/0x108
Apr  8 00:01:48 hilly kernel:  [<c016918b>] sys_munmap+0x41/0x58
Apr  8 00:01:48 hilly kernel:  [<c0103921>] sysenter_past_esp+0x52/0x75
Apr  8 00:01:48 hilly kernel: Code: c2 8b 00 f6 c4 08 75 2d 83 42 08 ff 0f 98 c0 
84 c0 74 17 8b 42 08 83 c0 01 78 10 ba ff ff ff ff b8 10 00 00 00 e9 67 7a fe ff 
c3 <0f> 0b e2 01 2f 42 3b c0 eb e6 0f 0b df 01 2f 42 3b c0 eb c9 55
Apr  8 00:01:48 hilly kernel:  <6>note: mlnet[3832] exited with preempt_count 2
Apr  8 00:01:48 hilly kernel: Debug: sleeping function called from invalid 
context at kernel/fork.c:419
Apr  8 00:01:48 hilly kernel: in_atomic():1, irqs_disabled():0
Apr  8 00:01:48 hilly kernel:  [<c011d76e>] __might_sleep+0x9c/0xa4
Apr  8 00:01:48 hilly kernel:  [<c011e0c4>] mm_release+0x5d/0xb2
Apr  8 00:01:48 hilly kernel:  [<c01240cc>] exit_mm+0x12/0x29b
Apr  8 00:01:48 hilly kernel:  [<c0125415>] do_exit+0x6dc/0x75c
Apr  8 00:01:48 hilly kernel:  [<c0124ddd>] do_exit+0xa4/0x75c
Apr  8 00:01:48 hilly kernel:  [<c0121b0b>] printk+0x17/0x1b
Apr  8 00:01:48 hilly kernel:  [<c01044f7>] do_trap+0x0/0xab
Apr  8 00:01:48 hilly kernel:  [<c0104720>] do_invalid_op+0x0/0x99
Apr  8 00:01:48 hilly kernel:  [<c01047b0>] do_invalid_op+0x90/0x99
Apr  8 00:01:48 hilly kernel:  [<c016c2e7>] page_remove_rmap+0x2c/0x40
Apr  8 00:01:48 hilly kernel:  [<c0156f55>] blockable_page_cache_readahead+0x34/0x41
Apr  8 00:01:48 hilly kernel:  [<c012813e>] current_fs_time+0x44/0x4e
Apr  8 00:01:48 hilly kernel:  [<c0119c9a>] __change_page_attr+0x21/0x17f
Apr  8 00:01:48 hilly kernel:  [<c0119efd>] change_page_attr+0x105/0x1bd
Apr  8 00:01:48 hilly kernel:  [<c0103ae6>] common_interrupt+0x1a/0x20
Apr  8 00:01:48 hilly kernel:  [<c0103b1f>] error_code+0x2b/0x30
Apr  8 00:01:49 hilly kernel:  [<c016c2e7>] page_remove_rmap+0x2c/0x40
Apr  8 00:01:49 hilly kernel:  [<c01623db>] zap_pte_range+0x14b/0x27f
Apr  8 00:01:49 hilly kernel:  [<c0162556>] zap_pmd_range+0x47/0x65
Apr  8 00:01:49 hilly kernel:  [<c0119c9a>] __change_page_attr+0x21/0x17f
Apr  8 00:01:49 hilly kernel:  [<c01625a2>] zap_pud_range+0x2e/0x52
Apr  8 00:01:49 hilly kernel:  [<c016262c>] unmap_page_range+0x66/0x83
Apr  8 00:01:49 hilly kernel:  [<c016274c>] unmap_vmas+0x103/0x39c
Apr  8 00:01:49 hilly kernel:  [<c01677f4>] vma_adjust+0x2dd/0x5b6
Apr  8 00:01:49 hilly kernel:  [<c0157873>] poison_obj+0x1c/0x38
Apr  8 00:01:49 hilly kernel:  [<c0168d4f>] unmap_region+0x72/0xdc
Apr  8 00:01:49 hilly kernel:  [<c0169019>] do_munmap+0x13c/0x26d
Apr  8 00:01:49 hilly kernel:  [<c017b915>] vfs_read+0xc0/0x108
Apr  8 00:01:49 hilly kernel:  [<c016918b>] sys_munmap+0x41/0x58
Apr  8 00:01:49 hilly kernel:  [<c0103921>] sysenter_past_esp+0x52/0x75
Apr  8 00:01:49 hilly kernel: scheduling while atomic: mlnet/0x00000002/3832
Apr  8 00:01:49 hilly kernel:  [<c039b427>] schedule+0x567/0x656
Apr  8 00:01:49 hilly kernel:  [<c028b90c>] vt_console_print+0x57/0x302
Apr  8 00:01:49 hilly kernel:  [<c039d4a7>] rwsem_down_read_failed+0x137/0x2b5
Apr  8 00:01:49 hilly kernel:  [<c0121837>] __call_console_drivers+0x41/0x4d
Apr  8 00:01:49 hilly kernel:  [<c0141af8>] .text.lock.futex+0x7/0xdb
Apr  8 00:01:49 hilly kernel:  [<c0121cd5>] vprintk+0x1c6/0x336
Apr  8 00:01:49 hilly kernel:  [<c01419dd>] do_futex+0x5b/0x7c
Apr  8 00:01:49 hilly kernel:  [<c0103ee1>] show_trace+0x2c/0x78
Apr  8 00:01:49 hilly kernel:  [<c0141a5f>] sys_futex+0x61/0xdf
Apr  8 00:01:49 hilly kernel:  [<c011e112>] mm_release+0xab/0xb2
Apr  8 00:01:49 hilly kernel:  [<c01240cc>] exit_mm+0x12/0x29b
Apr  8 00:01:49 hilly kernel:  [<c0125415>] do_exit+0x6dc/0x75c
Apr  8 00:01:49 hilly kernel:  [<c0124ddd>] do_exit+0xa4/0x75c
Apr  8 00:01:49 hilly kernel:  [<c0121b0b>] printk+0x17/0x1b
Apr  8 00:01:49 hilly kernel:  [<c01044f7>] do_trap+0x0/0xab
Apr  8 00:01:49 hilly kernel:  [<c0104720>] do_invalid_op+0x0/0x99
Apr  8 00:01:49 hilly kernel:  [<c01047b0>] do_invalid_op+0x90/0x99
Apr  8 00:01:49 hilly kernel:  [<c016c2e7>] page_remove_rmap+0x2c/0x40
Apr  8 00:01:49 hilly kernel:  [<c0156f55>] blockable_page_cache_readahead+0x34/0x41
Apr  8 00:01:49 hilly kernel:  [<c012813e>] current_fs_time+0x44/0x4e
Apr  8 00:01:49 hilly kernel:  [<c0119c9a>] __change_page_attr+0x21/0x17f
Apr  8 00:01:49 hilly kernel:  [<c0119efd>] change_page_attr+0x105/0x1bd
Apr  8 00:01:49 hilly kernel:  [<c0103ae6>] common_interrupt+0x1a/0x20
Apr  8 00:01:49 hilly kernel:  [<c0103b1f>] error_code+0x2b/0x30
Apr  8 00:01:49 hilly kernel:  [<c016c2e7>] page_remove_rmap+0x2c/0x40
Apr  8 00:01:49 hilly kernel:  [<c01623db>] zap_pte_range+0x14b/0x27f
Apr  8 00:01:49 hilly kernel:  [<c0162556>] zap_pmd_range+0x47/0x65
Apr  8 00:01:49 hilly kernel:  [<c0119c9a>] __change_page_attr+0x21/0x17f
Apr  8 00:01:49 hilly kernel:  [<c01625a2>] zap_pud_range+0x2e/0x52
Apr  8 00:01:49 hilly kernel:  [<c016262c>] unmap_page_range+0x66/0x83
Apr  8 00:01:49 hilly kernel:  [<c016274c>] unmap_vmas+0x103/0x39c
Apr  8 00:01:49 hilly kernel:  [<c01677f4>] vma_adjust+0x2dd/0x5b6
Apr  8 00:01:49 hilly kernel:  [<c0157873>] poison_obj+0x1c/0x38
Apr  8 00:01:49 hilly kernel:  [<c0168d4f>] unmap_region+0x72/0xdc
Apr  8 00:01:49 hilly kernel:  [<c0169019>] do_munmap+0x13c/0x26d
Apr  8 00:01:49 hilly kernel:  [<c017b915>] vfs_read+0xc0/0x108
Apr  8 00:01:49 hilly kernel:  [<c016918b>] sys_munmap+0x41/0x58
Apr  8 00:01:49 hilly kernel:  [<c0103921>] sysenter_past_esp+0x52/0x75



Apr  8 00:08:08 hilly kernel: ------------[ cut here ]------------
Apr  8 00:08:08 hilly kernel: kernel BUG at mm/rmap.c:482!
Apr  8 00:08:08 hilly kernel: invalid operand: 0000 [#2]
Apr  8 00:08:08 hilly kernel: PREEMPT DEBUG_PAGEALLOC
Apr  8 00:08:08 hilly kernel: Modules linked in: autofs4 video button battery ac 
md5 ipv6 ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core ohci_hcd 
ehci_hcd cx8800 v4l1_compat v4l2_common cx88_dvb cx8802 mt352 cx88xx 
i2c_algo_bit ir_common btcx_risc tveeprom videodev or51132 video_buf_dvb 
video_buf cx22702 dvb_pll budget_ci tda1004x budget_core dvb_core saa7146 
ttpci_eeprom stv0299 i2c_sis96x i2c_core snd_intel8x0 snd_ac97_codec snd_pcm 
snd_timer snd soundcore snd_page_alloc b44 mii
Apr  8 00:08:08 hilly kernel: CPU:    0
Apr  8 00:08:08 hilly kernel: EIP:    0060:[<c016c2e7>]    Not tainted VLI
Apr  8 00:08:08 hilly kernel: EFLAGS: 00210286   (2.6.11.2-kraxel1)
Apr  8 00:08:08 hilly kernel: EIP is at page_remove_rmap+0x2c/0x40
Apr  8 00:08:08 hilly kernel: eax: ffffffff   ebx: 00003000   ecx: c10c6ce0 
edx: c10c6ce0
Apr  8 00:08:08 hilly kernel: esi: c6543fd0   edi: 00008000   ebp: c10c6ce0 
esp: c7279e5c
Apr  8 00:08:08 hilly kernel: ds: 007b   es: 007b   ss: 0068
Apr  8 00:08:08 hilly kernel: Process mythfrontend (pid: 6473, 
threadinfo=c7279000 task=c5ab8a80)
Apr  8 00:08:08 hilly kernel: Stack: c01623db d46b0a80 00000000 df7c7440 
c7279e94 06367067 00000000 b33f1000
Apr  8 00:08:08 hilly kernel:        c0483020 b37f1000 d6c80b34 b33f9000 
c0483020 c0162556 00008000 00000000
Apr  8 00:08:08 hilly kernel:        000d092b 1d244b3c b33f1000 d6c80b34 
b33f9000 c0483020 c01625a2 00008000
Apr  8 00:08:08 hilly kernel: Call Trace:
Apr  8 00:08:08 hilly kernel:  [<c01623db>] zap_pte_range+0x14b/0x27f
Apr  8 00:08:08 hilly kernel:  [<c0162556>] zap_pmd_range+0x47/0x65
Apr  8 00:08:08 hilly kernel:  [<c01625a2>] zap_pud_range+0x2e/0x52
Apr  8 00:08:08 hilly kernel:  [<c016262c>] unmap_page_range+0x66/0x83
Apr  8 00:08:08 hilly kernel:  [<c016274c>] unmap_vmas+0x103/0x39c
Apr  8 00:08:08 hilly kernel:  [<c01677f4>] vma_adjust+0x2dd/0x5b6
Apr  8 00:08:08 hilly kernel:  [<c0157873>] poison_obj+0x1c/0x38
Apr  8 00:08:08 hilly kernel:  [<c0168d4f>] unmap_region+0x72/0xdc
Apr  8 00:08:08 hilly kernel:  [<c0169019>] do_munmap+0x13c/0x26d
Apr  8 00:08:08 hilly kernel:  [<c016918b>] sys_munmap+0x41/0x58
Apr  8 00:08:08 hilly kernel:  [<c0103921>] sysenter_past_esp+0x52/0x75
Apr  8 00:08:08 hilly kernel: Code: c2 8b 00 f6 c4 08 75 2d 83 42 08 ff 0f 98 c0 
84 c0 74 17 8b 42 08 83 c0 01 78 10 ba ff ff ff ff b8 10 00 00 00 e9 67 7a fe ff 
c3 <0f> 0b e2 01 2f 42 3b c0 eb e6 0f 0b df 01 2f 42 3b c0 eb c9 55
Apr  8 00:08:08 hilly kernel:  <6>note: mythfrontend[6473] exited with 
preempt_count 2
Apr  8 00:08:08 hilly kernel: Debug: sleeping function called from invalid 
context at kernel/fork.c:419
Apr  8 00:08:08 hilly kernel: in_atomic():1, irqs_disabled():0
Apr  8 00:08:08 hilly kernel:  [<c011d76e>] __might_sleep+0x9c/0xa4
Apr  8 00:08:08 hilly kernel:  [<c011e0c4>] mm_release+0x5d/0xb2
Apr  8 00:08:08 hilly kernel:  [<c01240cc>] exit_mm+0x12/0x29b
Apr  8 00:08:08 hilly kernel:  [<c0124ddd>] do_exit+0xa4/0x75c
Apr  8 00:08:08 hilly kernel:  [<c0121b0b>] printk+0x17/0x1b
Apr  8 00:08:08 hilly kernel:  [<c01044f7>] do_trap+0x0/0xab
Apr  8 00:08:08 hilly kernel:  [<c0104720>] do_invalid_op+0x0/0x99
Apr  8 00:08:08 hilly kernel:  [<c01047b0>] do_invalid_op+0x90/0x99
Apr  8 00:08:08 hilly kernel:  [<c016c2e7>] page_remove_rmap+0x2c/0x40
Apr  8 00:08:08 hilly kernel:  [<c01054cb>] do_IRQ+0x54/0x85
Apr  8 00:08:08 hilly kernel:  [<c0103ae6>] common_interrupt+0x1a/0x20
Apr  8 00:08:08 hilly kernel:  [<c0119c9a>] __change_page_attr+0x21/0x17f
Apr  8 00:08:08 hilly kernel:  [<c0119efd>] change_page_attr+0x105/0x1bd
Apr  8 00:08:08 hilly kernel:  [<c0103ae6>] common_interrupt+0x1a/0x20
Apr  8 00:08:08 hilly kernel:  [<c0103b1f>] error_code+0x2b/0x30
Apr  8 00:08:08 hilly kernel:  [<c016c2e7>] page_remove_rmap+0x2c/0x40
Apr  8 00:08:08 hilly kernel:  [<c01623db>] zap_pte_range+0x14b/0x27f
Apr  8 00:08:08 hilly kernel:  [<c0162556>] zap_pmd_range+0x47/0x65
Apr  8 00:08:08 hilly kernel:  [<c01625a2>] zap_pud_range+0x2e/0x52
Apr  8 00:08:08 hilly kernel:  [<c016262c>] unmap_page_range+0x66/0x83
Apr  8 00:08:08 hilly kernel:  [<c016274c>] unmap_vmas+0x103/0x39c
Apr  8 00:08:08 hilly kernel:  [<c01677f4>] vma_adjust+0x2dd/0x5b6
Apr  8 00:08:08 hilly kernel:  [<c0157873>] poison_obj+0x1c/0x38
Apr  8 00:08:08 hilly kernel:  [<c0168d4f>] unmap_region+0x72/0xdc
Apr  8 00:08:08 hilly kernel:  [<c0169019>] do_munmap+0x13c/0x26d
Apr  8 00:08:08 hilly kernel:  [<c016918b>] sys_munmap+0x41/0x58
Apr  8 00:08:08 hilly kernel:  [<c0103921>] sysenter_past_esp+0x52/0x75
Apr  8 00:08:08 hilly kernel: scheduling while atomic: mythfrontend/0x00000002/6473
Apr  8 00:08:08 hilly kernel:  [<c039b427>] schedule+0x567/0x656
Apr  8 00:08:08 hilly kernel:  [<c028b90c>] vt_console_print+0x57/0x302
Apr  8 00:08:08 hilly kernel:  [<c039d4a7>] rwsem_down_read_failed+0x137/0x2b5
Apr  8 00:08:08 hilly kernel:  [<c0121837>] __call_console_drivers+0x41/0x4d
Apr  8 00:08:08 hilly kernel:  [<c0141af8>] .text.lock.futex+0x7/0xdb
Apr  8 00:08:08 hilly kernel:  [<c0121cd5>] vprintk+0x1c6/0x336
Apr  8 00:08:08 hilly kernel:  [<c01419dd>] do_futex+0x5b/0x7c
Apr  8 00:08:08 hilly kernel:  [<c0103ee1>] show_trace+0x2c/0x78
Apr  8 00:08:08 hilly kernel:  [<c0141a5f>] sys_futex+0x61/0xdf
Apr  8 00:08:08 hilly kernel:  [<c011e112>] mm_release+0xab/0xb2
Apr  8 00:08:08 hilly kernel:  [<c01240cc>] exit_mm+0x12/0x29b
Apr  8 00:08:08 hilly kernel:  [<c0124ddd>] do_exit+0xa4/0x75c
Apr  8 00:08:08 hilly kernel:  [<c0121b0b>] printk+0x17/0x1b
Apr  8 00:08:08 hilly kernel:  [<c01044f7>] do_trap+0x0/0xab
Apr  8 00:08:08 hilly kernel:  [<c0104720>] do_invalid_op+0x0/0x99
Apr  8 00:08:08 hilly kernel:  [<c01047b0>] do_invalid_op+0x90/0x99
Apr  8 00:08:08 hilly kernel:  [<c016c2e7>] page_remove_rmap+0x2c/0x40
Apr  8 00:08:08 hilly kernel:  [<c01054cb>] do_IRQ+0x54/0x85
Apr  8 00:08:08 hilly kernel:  [<c0103ae6>] common_interrupt+0x1a/0x20
Apr  8 00:08:08 hilly kernel:  [<c0119c9a>] __change_page_attr+0x21/0x17f
Apr  8 00:08:08 hilly kernel:  [<c0119efd>] change_page_attr+0x105/0x1bd
Apr  8 00:08:08 hilly kernel:  [<c0103ae6>] common_interrupt+0x1a/0x20
Apr  8 00:08:08 hilly kernel:  [<c0103b1f>] error_code+0x2b/0x30
Apr  8 00:08:08 hilly kernel:  [<c016c2e7>] page_remove_rmap+0x2c/0x40
Apr  8 00:08:08 hilly kernel:  [<c01623db>] zap_pte_range+0x14b/0x27f
Apr  8 00:08:08 hilly kernel:  [<c0162556>] zap_pmd_range+0x47/0x65
Apr  8 00:08:09 hilly kernel:  [<c01625a2>] zap_pud_range+0x2e/0x52
Apr  8 00:08:09 hilly kernel:  [<c016262c>] unmap_page_range+0x66/0x83
Apr  8 00:08:09 hilly kernel:  [<c016274c>] unmap_vmas+0x103/0x39c
Apr  8 00:08:09 hilly kernel:  [<c01677f4>] vma_adjust+0x2dd/0x5b6
Apr  8 00:08:09 hilly kernel:  [<c0157873>] poison_obj+0x1c/0x38
Apr  8 00:08:09 hilly kernel:  [<c0168d4f>] unmap_region+0x72/0xdc
Apr  8 00:08:09 hilly kernel:  [<c0169019>] do_munmap+0x13c/0x26d
Apr  8 00:08:09 hilly kernel:  [<c016918b>] sys_munmap+0x41/0x58
Apr  8 00:08:09 hilly kernel:  [<c0103921>] sysenter_past_esp+0x52/0x75







Apr  9 10:32:00 hilly kernel: ------------[ cut here ]------------
Apr  9 10:32:00 hilly kernel: kernel BUG at mm/rmap.c:482!
Apr  9 10:32:00 hilly kernel: invalid operand: 0000 [#1]
Apr  9 10:32:00 hilly kernel: DEBUG_PAGEALLOC
Apr  9 10:32:00 hilly kernel: Modules linked in: snd_pcm_oss snd_mixer_oss 
autofs4 dm_mod video button battery ac md5 ipv6 ohci1394 ieee1394 yenta_socket 
rsrc_nonstatic pcmcia_core ohci_hcd ehci_hcd cx8800 v4l1_compat v4l2_common 
cx8802 cx88xx i2c_algo_bit video_buf ir_common btcx_risc tveeprom videodev 
budget_ci tda1004x budget_core dvb_core saa7146 ttpci_eeprom stv0299 i2c_sis96x 
i2c_core snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore 
snd_page_alloc b44 mii
Apr  9 10:32:00 hilly kernel: CPU:    0
Apr  9 10:32:00 hilly kernel: EIP:    0060:[<c01650a9>]    Not tainted VLI
Apr  9 10:32:00 hilly kernel: EFLAGS: 00210282   (2.6.11.2-kraxel1)
Apr  9 10:32:00 hilly kernel: EIP is at page_remove_rmap+0x2c/0x40
Apr  9 10:32:00 hilly kernel: eax: fffffff8   ebx: 00000000   ecx: c1056040 
edx: c1056040
Apr  9 10:32:00 hilly kernel: esi: c3156f34   edi: 00001000   ebp: c1056040 
esp: d0878e58
Apr  9 10:32:00 hilly kernel: ds: 007b   es: 007b   ss: 0068
Apr  9 10:32:00 hilly kernel: Process modpost (pid: 8811, threadinfo=d0878000 
task=cbc8da80)
Apr  9 10:32:00 hilly kernel: Stack: c015bb2a dedb6f24 00000000 c3156f30 
00000000 02b02067 00000000 b7fcd000
Apr  9 10:32:00 hilly kernel:        c046a020 b83cd000 d5f0eb80 b7fce000 
c046a020 c015bca5 00001000 00000000
Apr  9 10:32:00 hilly kernel:        c011880e 00000000 b7fcd000 d5f0eb80 
b7fce000 c046a020 c015bcf1 00001000
Apr  9 10:32:00 hilly kernel: Call Trace:
Apr  9 10:32:00 hilly kernel:  [<c015bb2a>] zap_pte_range+0x14b/0x27f
Apr  9 10:32:00 hilly kernel:  [<c015bca5>] zap_pmd_range+0x47/0x65
Apr  9 10:32:00 hilly kernel:  [<c011880e>] __change_page_attr+0x21/0x17f
Apr  9 10:32:00 hilly kernel:  [<c015bcf1>] zap_pud_range+0x2e/0x52
Apr  9 10:32:00 hilly kernel:  [<c015bd7b>] unmap_page_range+0x66/0x83
Apr  9 10:32:00 hilly kernel:  [<c015be9b>] unmap_vmas+0x103/0x36a
Apr  9 10:32:00 hilly kernel:  [<c018ee69>] dput+0x109/0x663
Apr  9 10:32:00 hilly kernel:  [<c015402e>] kmem_cache_free+0x39/0x4f
Apr  9 10:32:00 hilly kernel:  [<c0161e52>] unmap_region+0x72/0xdc
Apr  9 10:32:00 hilly kernel:  [<c0162112>] do_munmap+0x132/0x23a
Apr  9 10:32:00 hilly kernel:  [<c0162265>] sys_munmap+0x4b/0x63
Apr  9 10:32:00 hilly kernel:  [<c0103695>] sysenter_past_esp+0x52/0x75
Apr  9 10:32:00 hilly kernel: Code: c2 8b 00 f6 c4 08 75 2d 83 42 08 ff 0f 98 c0 
84 c0 74 17 8b 42 08 83 c0 01 78 10 ba ff ff ff ff b8 10 00 00 00 e9 25 93 fe ff 
c3 <0f> 0b e2 01 1b 7c 39 c0 eb e6 0f 0b df 01 1b 7c 39 c0 eb c9 55
Apr  9 10:32:00 hilly kernel:  <3>Debug: sleeping function called from invalid 
context at include/linux/rwsem.h:43
Apr  9 10:32:00 hilly kernel: in_atomic():1, irqs_disabled():0
Apr  9 10:32:00 hilly kernel:  [<c011bd8c>] __might_sleep+0x9c/0xa4
Apr  9 10:32:00 hilly kernel:  [<c0120728>] profile_task_exit+0x18/0x43
Apr  9 10:32:00 hilly kernel:  [<c0122a82>] do_exit+0x19/0x66b
Apr  9 10:32:00 hilly kernel:  [<c0103e31>] show_registers+0x123/0x1ba
Apr  9 10:32:00 hilly kernel:  [<c0276a24>] do_unblank_screen+0x36/0x12f
Apr  9 10:32:00 hilly kernel:  [<c011fa15>] printk+0x17/0x1b
Apr  9 10:32:00 hilly kernel:  [<c01041fb>] do_trap+0x0/0xac
Apr  9 10:32:00 hilly kernel:  [<c0104425>] do_invalid_op+0x0/0x99
Apr  9 10:32:00 hilly kernel:  [<c01044b5>] do_invalid_op+0x90/0x99
Apr  9 10:32:00 hilly kernel:  [<c02a5615>] __generic_unplug_device+0x31/0x33
Apr  9 10:32:00 hilly kernel:  [<c02a568c>] generic_unplug_device+0x75/0x151
Apr  9 10:32:00 hilly kernel:  [<c01650a9>] page_remove_rmap+0x2c/0x40
Apr  9 10:32:00 hilly kernel:  [<c0380ac8>] __wait_on_bit_lock+0x54/0x5e
Apr  9 10:32:00 hilly kernel:  [<c014800a>] sync_page+0x0/0x45
Apr  9 10:32:00 hilly kernel:  [<c01487ff>] __lock_page+0x90/0x98
Apr  9 10:32:00 hilly kernel:  [<c013bc4a>] wake_bit_function+0x0/0x3c
Apr  9 10:32:00 hilly kernel:  [<c014886e>] find_get_page+0x67/0x14a
Apr  9 10:32:01 hilly kernel:  [<c0103893>] error_code+0x2b/0x30
Apr  9 10:32:01 hilly kernel:  [<c015007b>] test_set_page_writeback+0x1b4/0x1f1
Apr  9 10:32:01 hilly kernel:  [<c01650a9>] page_remove_rmap+0x2c/0x40
Apr  9 10:32:01 hilly kernel:  [<c015bb2a>] zap_pte_range+0x14b/0x27f
Apr  9 10:32:01 hilly kernel:  [<c015bca5>] zap_pmd_range+0x47/0x65
Apr  9 10:32:01 hilly kernel:  [<c011880e>] __change_page_attr+0x21/0x17f
Apr  9 10:32:01 hilly kernel:  [<c015bcf1>] zap_pud_range+0x2e/0x52
Apr  9 10:32:01 hilly kernel:  [<c015bd7b>] unmap_page_range+0x66/0x83
Apr  9 10:32:01 hilly kernel:  [<c015be9b>] unmap_vmas+0x103/0x36a
Apr  9 10:32:01 hilly kernel:  [<c018ee69>] dput+0x109/0x663
Apr  9 10:32:01 hilly kernel:  [<c015402e>] kmem_cache_free+0x39/0x4f
Apr  9 10:32:01 hilly kernel:  [<c0161e52>] unmap_region+0x72/0xdc
Apr  9 10:32:01 hilly kernel:  [<c0162112>] do_munmap+0x132/0x23a
Apr  9 10:32:01 hilly kernel:  [<c0162265>] sys_munmap+0x4b/0x63
Apr  9 10:32:01 hilly kernel:  [<c0103695>] sysenter_past_esp+0x52/0x75
Apr  9 10:32:01 hilly kernel: note: modpost[8811] exited with preempt_count 1
Apr  9 10:32:01 hilly kernel: scheduling while atomic: modpost/0x00000001/8811
Apr  9 10:32:01 hilly kernel:  [<c037efff>] schedule+0x4ef/0x5de
Apr  9 10:32:01 hilly kernel:  [<c0275b35>] vt_console_print+0x0/0x302
Apr  9 10:32:01 hilly kernel:  [<c011f741>] __call_console_drivers+0x41/0x4d
Apr  9 10:32:01 hilly kernel:  [<c0380c85>] rwsem_down_read_failed+0x115/0x285
Apr  9 10:32:01 hilly kernel:  [<c01249d9>] .text.lock.exit+0x27/0x8e
Apr  9 10:32:01 hilly kernel:  [<c0122b14>] do_exit+0xab/0x66b
Apr  9 10:32:01 hilly kernel:  [<c011fa15>] printk+0x17/0x1b
Apr  9 10:32:01 hilly kernel:  [<c01041fb>] do_trap+0x0/0xac
Apr  9 10:32:01 hilly kernel:  [<c0104425>] do_invalid_op+0x0/0x99
Apr  9 10:32:01 hilly kernel:  [<c01044b5>] do_invalid_op+0x90/0x99
Apr  9 10:32:01 hilly kernel:  [<c02a5615>] __generic_unplug_device+0x31/0x33
Apr  9 10:32:01 hilly kernel:  [<c02a568c>] generic_unplug_device+0x75/0x151
Apr  9 10:32:01 hilly kernel:  [<c01650a9>] page_remove_rmap+0x2c/0x40
Apr  9 10:32:01 hilly kernel:  [<c0380ac8>] __wait_on_bit_lock+0x54/0x5e
Apr  9 10:32:01 hilly kernel:  [<c014800a>] sync_page+0x0/0x45
Apr  9 10:32:02 hilly kernel:  [<c01487ff>] __lock_page+0x90/0x98
Apr  9 10:32:02 hilly kernel:  [<c013bc4a>] wake_bit_function+0x0/0x3c
Apr  9 10:32:02 hilly kernel:  [<c014886e>] find_get_page+0x67/0x14a
Apr  9 10:32:02 hilly kernel:  [<c0103893>] error_code+0x2b/0x30
Apr  9 10:32:02 hilly kernel:  [<c015007b>] test_set_page_writeback+0x1b4/0x1f1
Apr  9 10:32:02 hilly kernel:  [<c01650a9>] page_remove_rmap+0x2c/0x40
Apr  9 10:32:02 hilly kernel:  [<c015bb2a>] zap_pte_range+0x14b/0x27f
Apr  9 10:32:02 hilly kernel:  [<c015bca5>] zap_pmd_range+0x47/0x65
Apr  9 10:32:02 hilly kernel:  [<c011880e>] __change_page_attr+0x21/0x17f
Apr  9 10:32:02 hilly kernel:  [<c015bcf1>] zap_pud_range+0x2e/0x52
Apr  9 10:32:02 hilly kernel:  [<c015bd7b>] unmap_page_range+0x66/0x83
Apr  9 10:32:02 hilly kernel:  [<c015be9b>] unmap_vmas+0x103/0x36a
Apr  9 10:32:02 hilly kernel:  [<c018ee69>] dput+0x109/0x663
Apr  9 10:32:02 hilly kernel:  [<c015402e>] kmem_cache_free+0x39/0x4f
Apr  9 10:32:02 hilly kernel:  [<c0161e52>] unmap_region+0x72/0xdc
Apr  9 10:32:02 hilly kernel:  [<c0162112>] do_munmap+0x132/0x23a
Apr  9 10:32:02 hilly kernel:  [<c0162265>] sys_munmap+0x4b/0x63
Apr  9 10:32:02 hilly kernel:  [<c0103695>] sysenter_past_esp+0x52/0x75




Apr 30 10:55:11 hilly kernel: ------------[ cut here ]------------
Apr 30 10:55:11 hilly kernel: kernel BUG at mm/rmap.c:482!
Apr 30 10:55:11 hilly kernel: invalid operand: 0000 [#1]
Apr 30 10:55:11 hilly kernel: Modules linked in: md5 ipv6 autofs4 pcmcia dm_mod 
video button battery ac ohci1394 ieee1394 yenta_socket rsrc_nonstatic 
pcmcia_core ohci_hcd ehci_hcd cx8800(U) v4l1_compat(U) v4l2_common(U) 
cx88_dvb(U) cx8802(U) mt352(U) cx88xx(U) i2c_algo_bit ir_common(U) btcx_risc(U) 
tveeprom(U) videodev or51132(U) video_buf_dvb(U) video_buf(U) cx22702(U) 
dvb_pll(U) budget_ci(U) tda1004x(U) budget_core(U) dvb_core(U) saa7146(U) 
ttpci_eeprom(U) stv0299(U) i2c_sis96x i2c_core snd_intel8x0 snd_ac97_codec 
snd_pcm snd_timer snd soundcore snd_page_alloc b44 mii ext3 jbd
Apr 30 10:55:11 hilly kernel: CPU:    0
Apr 30 10:55:11 hilly kernel: EIP:    0060:[<c0167202>]    Tainted: GF     VLI
Apr 30 10:55:11 hilly kernel: EFLAGS: 00210282   (2.6.11-1.14_FC3)
Apr 30 10:55:11 hilly kernel: EIP is at page_remove_rmap+0x2c/0x40
Apr 30 10:55:11 hilly kernel: eax: fffffff8   ebx: 0000a000   ecx: c1056040 
edx: c1056040
Apr 30 10:55:11 hilly kernel: esi: c22ac028   edi: 00085000   ebp: c1056040 
esp: d43cae50
Apr 30 10:55:11 hilly kernel: ds: 007b   es: 007b   ss: 0068
Apr 30 10:55:11 hilly kernel: Process mythfrontend (pid: 11953, 
threadinfo=d43ca000 task=d425b6b0)
Apr 30 10:55:11 hilly kernel: Stack: c015d9e4 d05de930 fb3e1dc0 d43cae74 
c011ada0 02b02067 00000000 b3800000
Apr 30 10:55:11 hilly kernel:        c044a028 b3c00000 e4c05b3c b3885000 
c044a028 c015db64 00085000 00000000
Apr 30 10:55:11 hilly kernel:        c013e7c9 00000001 b3800000 e4c05b3c 
b3885000 c044a028 c015dbb0 00085000
Apr 30 10:55:11 hilly kernel: Call Trace:
Apr 30 10:55:11 hilly kernel:  [<c015d9e4>] zap_pte_range+0x14b/0x284
Apr 30 10:55:11 hilly kernel:  [<c011ada0>] activate_task+0x56/0x65
Apr 30 10:55:11 hilly kernel:  [<c015db64>] zap_pmd_range+0x47/0x65
Apr 30 10:55:11 hilly kernel:  [<c013e7c9>] queue_me+0x8f/0x1ca
Apr 30 10:55:11 hilly kernel:  [<c015dbb0>] zap_pud_range+0x2e/0x52
Apr 30 10:55:11 hilly kernel:  [<c015dc3a>] unmap_page_range+0x66/0x83
Apr 30 10:55:11 hilly kernel:  [<c015dd5a>] unmap_vmas+0x103/0x37c
Apr 30 10:55:11 hilly kernel:  [<c01627d9>] vma_adjust+0x238/0x556
Apr 30 10:55:11 hilly kernel:  [<c0163f01>] unmap_region+0x72/0xdc
Apr 30 10:55:11 hilly kernel:  [<c01641c5>] do_munmap+0x113/0x24f
Apr 30 10:55:11 hilly kernel:  [<c0204e81>] copy_from_user+0x4d/0x7c
Apr 30 10:55:11 hilly kernel:  [<c016434c>] sys_munmap+0x4b/0x63
Apr 30 10:55:11 hilly kernel:  [<c0103903>] syscall_call+0x7/0xb
Apr 30 10:55:11 hilly kernel: Code: c2 8b 00 f6 c4 08 75 2d 83 42 08 ff 0f 98 c0 
84 c0 74 17 8b 42 08 83 c0 01 78 10 ba ff ff ff ff b8 10 00 00 00 e9 ac a1 fe ff 
c3 <0f> 0b e2 01 16 b6 37 c0 eb e6 0f 0b df 01 16 b6 37 c0 eb c9 55
Apr 30 10:55:11 hilly kernel:  <3>Debug: sleeping function called from invalid 
context at include/linux/rwsem.h:43
Apr 30 10:55:11 hilly kernel: in_atomic():1, irqs_disabled():0
Apr 30 10:55:11 hilly kernel:  [<c011cfbe>] __might_sleep+0x9c/0xa4
Apr 30 10:55:11 hilly kernel:  [<c0105656>] do_IRQ+0x53/0x85
Apr 30 10:55:11 hilly kernel:  [<c0121978>] profile_task_exit+0x18/0x43
Apr 30 10:55:11 hilly kernel:  [<c0123cb7>] do_exit+0x19/0x4f4
Apr 30 10:55:11 hilly kernel:  [<c01043a4>] die+0x222/0x2ba
Apr 30 10:55:11 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
Apr 30 10:55:11 hilly kernel:  [<c0104665>] do_invalid_op+0x0/0x99
Apr 30 10:55:11 hilly kernel:  [<c01046f5>] do_invalid_op+0x90/0x99
Apr 30 10:55:11 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
Apr 30 10:55:11 hilly kernel:  [<c013d4de>] autoremove_wake_function+0x15/0x37
Apr 30 10:55:11 hilly kernel:  [<c02f7028>] __kfree_skb+0xa7/0x153
Apr 30 10:55:11 hilly kernel:  [<c0105656>] do_IRQ+0x53/0x85
Apr 30 10:55:11 hilly kernel:  [<c0103aab>] error_code+0x2b/0x30
Apr 30 10:55:11 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
Apr 30 10:55:11 hilly kernel:  [<c015d9e4>] zap_pte_range+0x14b/0x284
Apr 30 10:55:11 hilly kernel:  [<c011ada0>] activate_task+0x56/0x65
Apr 30 10:55:11 hilly kernel:  [<c015db64>] zap_pmd_range+0x47/0x65
Apr 30 10:55:11 hilly kernel:  [<c013e7c9>] queue_me+0x8f/0x1ca
Apr 30 10:55:11 hilly kernel:  [<c015dbb0>] zap_pud_range+0x2e/0x52
Apr 30 10:55:11 hilly kernel:  [<c015dc3a>] unmap_page_range+0x66/0x83
Apr 30 10:55:11 hilly kernel:  [<c015dd5a>] unmap_vmas+0x103/0x37c
Apr 30 10:55:11 hilly kernel:  [<c01627d9>] vma_adjust+0x238/0x556
Apr 30 10:55:11 hilly kernel:  [<c0163f01>] unmap_region+0x72/0xdc
Apr 30 10:55:11 hilly kernel:  [<c01641c5>] do_munmap+0x113/0x24f
Apr 30 10:55:11 hilly kernel:  [<c0204e81>] copy_from_user+0x4d/0x7c
Apr 30 10:55:11 hilly kernel:  [<c016434c>] sys_munmap+0x4b/0x63
Apr 30 10:55:11 hilly kernel:  [<c0103903>] syscall_call+0x7/0xb
Apr 30 10:55:11 hilly kernel: note: mythfrontend[11953] exited with preempt_count 1
Apr 30 10:55:11 hilly kernel: scheduling while atomic: mythfrontend/0x00000001/11953
Apr 30 10:55:11 hilly kernel:  [<c036373a>] schedule+0x47a/0x5f5
Apr 30 10:55:11 hilly kernel:  [<c03650de>] rwsem_down_read_failed+0xce/0x28b
Apr 30 10:55:11 hilly kernel:  [<c013f05a>] .text.lock.futex+0x7/0xd9
Apr 30 10:55:11 hilly kernel:  [<c012097f>] __call_console_drivers+0x41/0x4d
Apr 30 10:55:11 hilly kernel:  [<c0120ab5>] call_console_drivers+0xcb/0xe8
Apr 30 10:55:11 hilly kernel:  [<c013ef3f>] do_futex+0x5b/0x7c
Apr 30 10:55:11 hilly kernel:  [<c025adc5>] vt_console_print+0x0/0x302
Apr 30 10:55:11 hilly kernel:  [<c013efc1>] sys_futex+0x61/0xdf
Apr 30 10:55:11 hilly kernel:  [<c011d8f2>] mm_release+0xab/0xb2
Apr 30 10:55:11 hilly kernel:  [<c01230c9>] exit_mm+0x12/0x26f
Apr 30 10:55:11 hilly kernel:  [<c011cfbe>] __might_sleep+0x9c/0xa4
Apr 30 10:55:11 hilly kernel:  [<c0105656>] do_IRQ+0x53/0x85
Apr 30 10:55:11 hilly kernel:  [<c0123d50>] do_exit+0xb2/0x4f4
Apr 30 10:55:11 hilly kernel:  [<c01043a4>] die+0x222/0x2ba
Apr 30 10:55:11 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
Apr 30 10:55:11 hilly kernel:  [<c0104665>] do_invalid_op+0x0/0x99
Apr 30 10:55:11 hilly kernel:  [<c01046f5>] do_invalid_op+0x90/0x99
Apr 30 10:55:11 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
Apr 30 10:55:11 hilly kernel:  [<c013d4de>] autoremove_wake_function+0x15/0x37
Apr 30 10:55:11 hilly kernel:  [<c02f7028>] __kfree_skb+0xa7/0x153
Apr 30 10:55:11 hilly kernel:  [<c0105656>] do_IRQ+0x53/0x85
Apr 30 10:55:11 hilly kernel:  [<c0103aab>] error_code+0x2b/0x30
Apr 30 10:55:11 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
Apr 30 10:55:11 hilly kernel:  [<c015d9e4>] zap_pte_range+0x14b/0x284
Apr 30 10:55:11 hilly kernel:  [<c011ada0>] activate_task+0x56/0x65
Apr 30 10:55:11 hilly kernel:  [<c015db64>] zap_pmd_range+0x47/0x65
Apr 30 10:55:11 hilly kernel:  [<c013e7c9>] queue_me+0x8f/0x1ca
Apr 30 10:55:11 hilly kernel:  [<c015dbb0>] zap_pud_range+0x2e/0x52
Apr 30 10:55:11 hilly kernel:  [<c015dc3a>] unmap_page_range+0x66/0x83
Apr 30 10:55:11 hilly kernel:  [<c015dd5a>] unmap_vmas+0x103/0x37c
Apr 30 10:55:11 hilly kernel:  [<c01627d9>] vma_adjust+0x238/0x556
Apr 30 10:55:11 hilly kernel:  [<c0163f01>] unmap_region+0x72/0xdc
Apr 30 10:55:11 hilly kernel:  [<c01641c5>] do_munmap+0x113/0x24f
Apr 30 10:55:11 hilly kernel:  [<c0204e81>] copy_from_user+0x4d/0x7c
Apr 30 10:55:11 hilly kernel:  [<c016434c>] sys_munmap+0x4b/0x63
Apr 30 10:55:11 hilly kernel:  [<c0103903>] syscall_call+0x7/0xb









May  2 02:04:52 hilly kernel: ------------[ cut here ]------------
May  2 02:04:52 hilly kernel: kernel BUG at mm/rmap.c:482!
May  2 02:04:52 hilly kernel: invalid operand: 0000 [#1]
May  2 02:04:52 hilly kernel: Modules linked in: autofs4 dm_mod video button 
battery ac md5 ipv6 ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core 
ohci_hcd ehci_hcd cx8800(U) v4l1_compat(U) v4l2_common(U) cx88_dvb(U) cx8802(U) 
mt352(U) cx88xx(U) i2c_algo_bit ir_common(U) btcx_risc(U) tveeprom(U) videodev 
or51132(U) video_buf_dvb(U) video_buf(U) cx22702(U) dvb_pll(U) budget_ci(U) 
tda1004x(U) budget_core(U) dvb_core(U) saa7146(U) ttpci_eeprom(U) stv0299(U) 
i2c_sis96x i2c_core snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore 
snd_page_alloc b44 mii ext3 jbd
May  2 02:04:52 hilly kernel: CPU:    0
May  2 02:04:52 hilly kernel: EIP:    0060:[<c0167202>]    Tainted: GF     VLI
May  2 02:04:52 hilly kernel: EFLAGS: 00010286   (2.6.11-1.14_FC3)
May  2 02:04:52 hilly kernel: EIP is at page_remove_rmap+0x2c/0x40
May  2 02:04:52 hilly kernel: eax: ffffffff   ebx: 00030000   ecx: c10c6ce0 
edx: c10c6ce0
May  2 02:04:52 hilly kernel: esi: e7d23ef8   edi: 0003e000   ebp: c10c6ce0 
esp: e8bf0e50
May  2 02:04:52 hilly kernel: ds: 007b   es: 007b   ss: 0068
May  2 02:04:52 hilly kernel: Process mlnet (pid: 3920, threadinfo=e8bf0000 
task=eea319b0)
May  2 02:04:52 hilly kernel: Stack: c015d9e4 00000006 00000008 00000010 
00000020 06367067 00000000 b6f8e000
May  2 02:04:52 hilly kernel:        c044a028 b738e000 eacecb70 b6fcc000 
c044a028 c015db64 0003e000 00000000
May  2 02:04:52 hilly kernel:        c014c74f 00000000 b6f8e000 eacecb70 
b6fcc000 c044a028 c015dbb0 0003e000
May  2 02:04:52 hilly kernel: Call Trace:
May  2 02:04:52 hilly kernel:  [<c015d9e4>] zap_pte_range+0x14b/0x284
May  2 02:04:52 hilly kernel:  [<c015db64>] zap_pmd_range+0x47/0x65
May  2 02:04:52 hilly kernel:  [<c014c74f>] file_read_actor+0x0/0xe3
May  2 02:04:52 hilly kernel:  [<c015dbb0>] zap_pud_range+0x2e/0x52
May  2 02:04:52 hilly kernel:  [<c015dc3a>] unmap_page_range+0x66/0x83
May  2 02:04:52 hilly kernel:  [<c015dd5a>] unmap_vmas+0x103/0x37c
May  2 02:04:52 hilly kernel:  [<c01627d9>] vma_adjust+0x238/0x556
May  2 02:04:52 hilly kernel:  [<c0163f01>] unmap_region+0x72/0xdc
May  2 02:04:52 hilly kernel:  [<c01641c5>] do_munmap+0x113/0x24f
May  2 02:04:52 hilly kernel:  [<c016434c>] sys_munmap+0x4b/0x63
May  2 02:04:52 hilly kernel:  [<c0103903>] syscall_call+0x7/0xb
May  2 02:04:52 hilly kernel: Code: c2 8b 00 f6 c4 08 75 2d 83 42 08 ff 0f 98 c0 
84 c0 74 17 8b 42 08 83 c0 01 78 10 ba ff ff ff ff b8 10 00 00 00 e9 ac a1 fe ff 
c3 <0f> 0b e2 01 16 b6 37 c0 eb e6 0f 0b df 01 16 b6 37 c0 eb c9 55
May  2 02:04:52 hilly kernel:  <3>Debug: sleeping function called from invalid 
context at include/linux/rwsem.h:43
May  2 02:04:52 hilly kernel: in_atomic():1, irqs_disabled():0
May  2 02:04:52 hilly kernel:  [<c011cfbe>] __might_sleep+0x9c/0xa4
May  2 02:04:52 hilly kernel:  [<c0105656>] do_IRQ+0x53/0x85
May  2 02:04:52 hilly kernel:  [<c0121978>] profile_task_exit+0x18/0x43
May  2 02:04:52 hilly kernel:  [<c0123cb7>] do_exit+0x19/0x4f4
May  2 02:04:52 hilly kernel:  [<c01043a4>] die+0x222/0x2ba
May  2 02:04:52 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 02:04:52 hilly kernel:  [<c0104665>] do_invalid_op+0x0/0x99
May  2 02:04:52 hilly kernel:  [<c01046f5>] do_invalid_op+0x90/0x99
May  2 02:04:52 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 02:04:52 hilly kernel:  [<c015418b>] blockable_page_cache_readahead+0x34/0x41
May  2 02:04:52 hilly kernel:  [<c0126ba8>] current_fs_time+0x44/0x4e
May  2 02:04:52 hilly kernel:  [<c019823d>] update_atime+0x36/0x99
May  2 02:04:52 hilly kernel:  [<c0103aab>] error_code+0x2b/0x30
May  2 02:04:52 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 02:04:52 hilly kernel:  [<c015d9e4>] zap_pte_range+0x14b/0x284
May  2 02:04:52 hilly kernel:  [<c015db64>] zap_pmd_range+0x47/0x65
May  2 02:04:52 hilly kernel:  [<c014c74f>] file_read_actor+0x0/0xe3
May  2 02:04:52 hilly kernel:  [<c015dbb0>] zap_pud_range+0x2e/0x52
May  2 02:04:52 hilly kernel:  [<c015dc3a>] unmap_page_range+0x66/0x83
May  2 02:04:52 hilly kernel:  [<c015dd5a>] unmap_vmas+0x103/0x37c
May  2 02:04:52 hilly kernel:  [<c01627d9>] vma_adjust+0x238/0x556
May  2 02:04:52 hilly kernel:  [<c0163f01>] unmap_region+0x72/0xdc
May  2 02:04:52 hilly kernel:  [<c01641c5>] do_munmap+0x113/0x24f
May  2 02:04:52 hilly kernel:  [<c016434c>] sys_munmap+0x4b/0x63
May  2 02:04:52 hilly kernel:  [<c0103903>] syscall_call+0x7/0xb
May  2 02:04:52 hilly kernel: note: mlnet[3920] exited with preempt_count 1
May  2 02:04:52 hilly kernel: scheduling while atomic: mlnet/0x00000001/3920
May  2 02:04:52 hilly kernel:  [<c036373a>] schedule+0x47a/0x5f5
May  2 02:04:52 hilly kernel:  [<c03650de>] rwsem_down_read_failed+0xce/0x28b
May  2 02:04:52 hilly kernel:  [<c013f05a>] .text.lock.futex+0x7/0xd9
May  2 02:04:52 hilly kernel:  [<c012097f>] __call_console_drivers+0x41/0x4d
May  2 02:04:52 hilly kernel:  [<c0120ab5>] call_console_drivers+0xcb/0xe8
May  2 02:04:52 hilly kernel:  [<c013ef3f>] do_futex+0x5b/0x7c
May  2 02:04:52 hilly kernel:  [<c025adc5>] vt_console_print+0x0/0x302
May  2 02:04:52 hilly kernel:  [<c013efc1>] sys_futex+0x61/0xdf
May  2 02:04:52 hilly kernel:  [<c011d8f2>] mm_release+0xab/0xb2
May  2 02:04:52 hilly kernel:  [<c01230c9>] exit_mm+0x12/0x26f
May  2 02:04:52 hilly kernel:  [<c011cfbe>] __might_sleep+0x9c/0xa4
May  2 02:04:52 hilly kernel:  [<c0123d50>] do_exit+0xb2/0x4f4
May  2 02:04:52 hilly kernel:  [<c01043a4>] die+0x222/0x2ba
May  2 02:04:52 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 02:04:52 hilly kernel:  [<c0104665>] do_invalid_op+0x0/0x99
May  2 02:04:52 hilly kernel:  [<c01046f5>] do_invalid_op+0x90/0x99
May  2 02:04:52 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 02:04:52 hilly kernel:  [<c015418b>] blockable_page_cache_readahead+0x34/0x41
May  2 02:04:52 hilly kernel:  [<c0126ba8>] current_fs_time+0x44/0x4e
May  2 02:04:52 hilly kernel:  [<c019823d>] update_atime+0x36/0x99
May  2 02:04:52 hilly kernel:  [<c0103aab>] error_code+0x2b/0x30
May  2 02:04:52 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 02:04:52 hilly kernel:  [<c015d9e4>] zap_pte_range+0x14b/0x284
May  2 02:04:52 hilly kernel:  [<c015db64>] zap_pmd_range+0x47/0x65
May  2 02:04:52 hilly kernel:  [<c014c74f>] file_read_actor+0x0/0xe3
May  2 02:04:52 hilly kernel:  [<c015dbb0>] zap_pud_range+0x2e/0x52
May  2 02:04:52 hilly kernel:  [<c015dc3a>] unmap_page_range+0x66/0x83
May  2 02:04:52 hilly kernel:  [<c015dd5a>] unmap_vmas+0x103/0x37c
May  2 02:04:52 hilly kernel:  [<c01627d9>] vma_adjust+0x238/0x556
May  2 02:04:52 hilly kernel:  [<c0163f01>] unmap_region+0x72/0xdc
May  2 02:04:52 hilly kernel:  [<c01641c5>] do_munmap+0x113/0x24f
May  2 02:04:52 hilly kernel:  [<c016434c>] sys_munmap+0x4b/0x63
May  2 02:04:52 hilly kernel:  [<c0103903>] syscall_call+0x7/0xb




May  2 12:00:50 hilly kernel: ------------[ cut here ]------------
May  2 12:00:50 hilly kernel: kernel BUG at mm/rmap.c:482!
May  2 12:00:50 hilly kernel: invalid operand: 0000 [#1]
May  2 12:00:50 hilly kernel: Modules linked in: autofs4 dm_mod video button 
battery ac md5 ipv6 ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core 
ohci_hcd ehci_hcd cx8800(U) v4l1_compat(U) v4l2_common(U) cx88_dvb(U) cx8802(U) 
mt352(U) cx88xx(U) i2c_algo_bit ir_common(U) btcx_risc(U) tveeprom(U) videodev 
or51132(U) video_buf_dvb(U) video_buf(U) cx22702(U) dvb_pll(U) budget_ci(U) 
tda1004x(U) budget_core(U) dvb_core(U) saa7146(U) ttpci_eeprom(U) stv0299(U) 
i2c_sis96x i2c_core snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore 
snd_page_alloc b44 mii ext3 jbd
May  2 12:00:50 hilly kernel: CPU:    0
May  2 12:00:50 hilly kernel: EIP:    0060:[<c0167202>]    Tainted: GF     VLI
May  2 12:00:50 hilly kernel: EFLAGS: 00010282   (2.6.11-1.14_FC3)
May  2 12:00:50 hilly kernel: EIP is at page_remove_rmap+0x2c/0x40
May  2 12:00:50 hilly kernel: eax: fffffff8   ebx: 00063000   ecx: c1056040 
edx: c1056040
May  2 12:00:50 hilly kernel: esi: c250e528   edi: 000cf000   ebp: c1056040 
esp: c50c6e50
May  2 12:00:50 hilly kernel: ds: 007b   es: 007b   ss: 0068
May  2 12:00:50 hilly kernel: Process synaptic (pid: 5875, threadinfo=c50c6000 
task=c50bd830)
May  2 12:00:50 hilly kernel: Stack: c015d9e4 00000002 00000105 00001860 
00000000 02b02067 00000000 b78e7000
May  2 12:00:50 hilly kernel:        c044a028 b7ce7000 cf467b7c b79b6000 
c044a028 c015db64 000cf000 00000000
May  2 12:00:50 hilly kernel:        c50c6f40 c50c6ebc b78e7000 cf467b7c 
b79b6000 c044a028 c015dbb0 000cf000
May  2 12:00:50 hilly kernel: Call Trace:
May  2 12:00:50 hilly kernel:  [<c015d9e4>] zap_pte_range+0x14b/0x284
May  2 12:00:50 hilly kernel:  [<c015db64>] zap_pmd_range+0x47/0x65
May  2 12:00:50 hilly kernel:  [<c015dbb0>] zap_pud_range+0x2e/0x52
May  2 12:00:50 hilly kernel:  [<c015dc3a>] unmap_page_range+0x66/0x83
May  2 12:00:50 hilly kernel:  [<c015dd5a>] unmap_vmas+0x103/0x37c
May  2 12:00:50 hilly kernel:  [<c0163f01>] unmap_region+0x72/0xdc
May  2 12:00:50 hilly kernel:  [<c01641c5>] do_munmap+0x113/0x24f
May  2 12:00:50 hilly kernel:  [<c0174ff9>] vfs_read+0xc0/0x108
May  2 12:00:50 hilly kernel:  [<c016434c>] sys_munmap+0x4b/0x63
May  2 12:00:50 hilly kernel:  [<c0103903>] syscall_call+0x7/0xb
May  2 12:00:50 hilly kernel: Code: c2 8b 00 f6 c4 08 75 2d 83 42 08 ff 0f 98 c0 
84 c0 74 17 8b 42 08 83 c0 01 78 10 ba ff ff ff ff b8 10 00 00 00 e9 ac a1 fe ff 
c3 <0f> 0b e2 01 16 b6 37 c0 eb e6 0f 0b df 01 16 b6 37 c0 eb c9 55
May  2 12:00:50 hilly kernel:  <3>Debug: sleeping function called from invalid 
context at include/linux/rwsem.h:43
May  2 12:00:50 hilly kernel: in_atomic():1, irqs_disabled():0
May  2 12:00:50 hilly kernel:  [<c011cfbe>] __might_sleep+0x9c/0xa4
May  2 12:00:50 hilly kernel:  [<c0121978>] profile_task_exit+0x18/0x43
May  2 12:00:50 hilly kernel:  [<c0123cb7>] do_exit+0x19/0x4f4
May  2 12:00:50 hilly kernel:  [<c025bcdf>] do_unblank_screen+0x36/0x135
May  2 12:00:50 hilly kernel:  [<c0120c53>] printk+0x17/0x1b
May  2 12:00:50 hilly kernel:  [<c01043a4>] die+0x222/0x2ba
May  2 12:00:50 hilly kernel:  [<c011ada0>] activate_task+0x56/0x65
May  2 12:00:50 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 12:00:50 hilly kernel:  [<c0104665>] do_invalid_op+0x0/0x99
May  2 12:00:50 hilly kernel:  [<c01046f5>] do_invalid_op+0x90/0x99
May  2 12:00:50 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 12:00:50 hilly kernel:  [<c0150ba2>] buffered_rmqueue+0x1a0/0x2e2
May  2 12:00:50 hilly kernel:  [<c0126ba8>] current_fs_time+0x44/0x4e
May  2 12:00:50 hilly kernel:  [<c019823d>] update_atime+0x36/0x99
May  2 12:00:50 hilly kernel:  [<c014c61d>] do_generic_mapping_read+0x50b/0x63d
May  2 12:00:50 hilly kernel:  [<c0103a72>] common_interrupt+0x1a/0x20
May  2 12:00:50 hilly kernel:  [<c0103aab>] error_code+0x2b/0x30
May  2 12:00:50 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 12:00:50 hilly kernel:  [<c015d9e4>] zap_pte_range+0x14b/0x284
May  2 12:00:50 hilly kernel:  [<c015db64>] zap_pmd_range+0x47/0x65
May  2 12:00:50 hilly kernel:  [<c015dbb0>] zap_pud_range+0x2e/0x52
May  2 12:00:50 hilly kernel:  [<c015dc3a>] unmap_page_range+0x66/0x83
May  2 12:00:50 hilly kernel:  [<c015dd5a>] unmap_vmas+0x103/0x37c
May  2 12:00:50 hilly kernel:  [<c0163f01>] unmap_region+0x72/0xdc
May  2 12:00:50 hilly kernel:  [<c01641c5>] do_munmap+0x113/0x24f
May  2 12:00:50 hilly kernel:  [<c0174ff9>] vfs_read+0xc0/0x108
May  2 12:00:50 hilly kernel:  [<c016434c>] sys_munmap+0x4b/0x63
May  2 12:00:50 hilly kernel:  [<c0103903>] syscall_call+0x7/0xb
May  2 12:00:50 hilly kernel: note: synaptic[5875] exited with preempt_count 1
May  2 12:00:50 hilly kernel: scheduling while atomic: synaptic/0x00000001/5875
May  2 12:00:50 hilly kernel:  [<c036373a>] schedule+0x47a/0x5f5
May  2 12:00:50 hilly kernel:  [<c0120ab5>] call_console_drivers+0xcb/0xe8
May  2 12:00:50 hilly kernel:  [<c025ae1c>] vt_console_print+0x57/0x302
May  2 12:00:50 hilly kernel:  [<c025adc5>] vt_console_print+0x0/0x302
May  2 12:00:50 hilly kernel:  [<c03650de>] rwsem_down_read_failed+0xce/0x28b
May  2 12:00:50 hilly kernel:  [<c0120ab5>] call_console_drivers+0xcb/0xe8
May  2 12:00:50 hilly kernel:  [<c0125a99>] .text.lock.exit+0x27/0x8e
May  2 12:00:50 hilly kernel:  [<c011cfbe>] __might_sleep+0x9c/0xa4
May  2 12:00:50 hilly kernel:  [<c0123d50>] do_exit+0xb2/0x4f4
May  2 12:00:50 hilly kernel:  [<c0120c53>] printk+0x17/0x1b
May  2 12:00:50 hilly kernel:  [<c01043a4>] die+0x222/0x2ba
May  2 12:00:50 hilly kernel:  [<c011ada0>] activate_task+0x56/0x65
May  2 12:00:50 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 12:00:50 hilly kernel:  [<c0104665>] do_invalid_op+0x0/0x99
May  2 12:00:50 hilly kernel:  [<c01046f5>] do_invalid_op+0x90/0x99
May  2 12:00:50 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 12:00:50 hilly kernel:  [<c0150ba2>] buffered_rmqueue+0x1a0/0x2e2
May  2 12:00:50 hilly kernel:  [<c0126ba8>] current_fs_time+0x44/0x4e
May  2 12:00:50 hilly kernel:  [<c019823d>] update_atime+0x36/0x99
May  2 12:00:50 hilly kernel:  [<c014c61d>] do_generic_mapping_read+0x50b/0x63d
May  2 12:00:50 hilly kernel:  [<c0103a72>] common_interrupt+0x1a/0x20
May  2 12:00:50 hilly kernel:  [<c0103aab>] error_code+0x2b/0x30
May  2 12:00:50 hilly kernel:  [<c0167202>] page_remove_rmap+0x2c/0x40
May  2 12:00:50 hilly kernel:  [<c015d9e4>] zap_pte_range+0x14b/0x284
May  2 12:00:50 hilly kernel:  [<c015db64>] zap_pmd_range+0x47/0x65
May  2 12:00:50 hilly kernel:  [<c015dbb0>] zap_pud_range+0x2e/0x52
May  2 12:00:50 hilly kernel:  [<c015dc3a>] unmap_page_range+0x66/0x83
May  2 12:00:50 hilly kernel:  [<c015dd5a>] unmap_vmas+0x103/0x37c
May  2 12:00:50 hilly kernel:  [<c0163f01>] unmap_region+0x72/0xdc
May  2 12:00:50 hilly kernel:  [<c01641c5>] do_munmap+0x113/0x24f
May  2 12:00:50 hilly kernel:  [<c0174ff9>] vfs_read+0xc0/0x108
May  2 12:00:50 hilly kernel:  [<c016434c>] sys_munmap+0x4b/0x63
May  2 12:00:50 hilly kernel:  [<c0103903>] syscall_call+0x7/0xb

-- 
         Charlie Brej
APT Group, Dept. Computer Science, University of Manchester
Web: http://www.cs.man.ac.uk/~brejc8/ Tel: +44 161 275 6844
Mail: IT302, Manchester University, Manchester, M13 9PL, UK
