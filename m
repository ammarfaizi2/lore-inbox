Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUACN7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 08:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbUACN7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 08:59:23 -0500
Received: from elpis.telenet-ops.be ([195.130.132.40]:3729 "EHLO
	elpis.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262353AbUACN7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 08:59:04 -0500
Date: Sat, 3 Jan 2004 14:38:13 -0100
From: Gert De Keersmaecker <gertdek@pandora.be>
To: linux-kernel@vger.kernel.org
Subject: [2.6.1-rc1] : in_atomic():1, irqs_disabled():0
Message-ID: <20040103153813.GA16197@Gert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get this every few minutes in my logs.


Jan  3 14:28:18 RADON kernel: in_atomic():1, irqs_disabled():0
Jan  3 14:28:18 RADON kernel: Call Trace:
Jan  3 14:28:18 RADON kernel:  [__might_sleep+171/201]
__might_sleep+0xab/0xc9
Jan  3 14:28:18 RADON kernel:  [__kmalloc+147/154] __kmalloc+0x93/0x9a
Jan  3 14:28:18 RADON kernel:  [_end+276383904/1069260696]
os_alloc_mem+0x77/0x87 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274897336/1069260696]
_nv001308rm+0x10/0x28 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+276046165/1069260696]
_nv001518rm+0x7c9/0xb34 [nvidia]
Jan  3 14:28:18 RADON kernel:  [__wake_up_common+49/80]
__wake_up_common+0x31/0x50
Jan  3 14:28:18 RADON kernel:  [_end+274792733/1069260696]
_nv005601rm+0xd/0x34 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274794723/1069260696]
_nv005593rm+0x13/0x34 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274794424/1069260696]
_nv005594rm+0x14/0x58 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274797867/1069260696]
_nv005596rm+0x1f/0x50 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274823168/1069260696]
_nv000858rm+0x300/0xe14 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274907862/1069260696]
_nv000897rm+0x4e/0x70 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+276375614/1069260696]
nv_kern_isr+0x25/0x5b [nvidia]
Jan  3 14:28:18 RADON kernel:  [handle_IRQ_event+57/98]
handle_IRQ_event+0x39/0x62
Jan  3 14:28:18 RADON kernel:  [do_IRQ+196/324] do_IRQ+0xc4/0x144
Jan  3 14:28:18 RADON kernel:  [_end+274807477/1069260696]
_nv002962rm+0x2c5/0x3b8 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274916465/1069260696]
_nv000899rm+0x4c9/0xf70 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274916484/1069260696]
_nv000899rm+0x4dc/0xf70 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+276029532/1069260696]
_nv001823rm+0x2c/0x38 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274853030/1069260696]
_nv001370rm+0x2e/0xcc [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+275730964/1069260696]
_nv001534rm+0x20/0x28 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274942401/1069260696]
_nv004363rm+0x59/0x90 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274853030/1069260696]
_nv001370rm+0x2e/0xcc [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+275730964/1069260696]
_nv001534rm+0x20/0x28 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+275731043/1069260696]
_nv001532rm+0x1f/0x28 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+275731043/1069260696]
_nv001532rm+0x1f/0x28 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+275733065/1069260696]
_nv003619rm+0x19/0x20 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+276029532/1069260696]
_nv001823rm+0x2c/0x38 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274854818/1069260696]
_nv001344rm+0x22/0x6c [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274854818/1069260696]
_nv001344rm+0x22/0x6c [nvidia]
Jan  3 14:28:18 RADON kernel:  [recalc_task_prio+144/426]
recalc_task_prio+0x90/0x1aa
Jan  3 14:28:18 RADON kernel:  [try_to_wake_up+173/357]
try_to_wake_up+0xad/0x165
Jan  3 14:28:18 RADON kernel:  [__wake_up_common+49/80]
__wake_up_common+0x31/0x50
Jan  3 14:28:18 RADON kernel:  [try_to_wake_up+173/357]
try_to_wake_up+0xad/0x165
Jan  3 14:28:18 RADON kernel:  [queue_work+156/175] queue_work+0x9c/0xaf
Jan  3 14:28:18 RADON kernel:  [__wake_up_common+49/80]
__wake_up_common+0x31/0x50
Jan  3 14:28:18 RADON kernel:  [add_mouse_randomness+25/29]
add_mouse_randomness+0x19/0x1d
Jan  3 14:28:18 RADON kernel:  [input_event+218/962]
input_event+0xda/0x3c2
Jan  3 14:28:18 RADON kernel:  [atkbd_report_key+91/149]
atkbd_report_key+0x5b/0x95
Jan  3 14:28:18 RADON kernel:  [atkbd_interrupt+423/914]
atkbd_interrupt+0x1a7/0x392
Jan  3 14:28:18 RADON kernel:  [serio_interrupt+90/92]
serio_interrupt+0x5a/0x5c
Jan  3 14:28:18 RADON kernel:  [i8042_interrupt+273/412]
i8042_interrupt+0x111/0x19c
Jan  3 14:28:18 RADON kernel:  [_end+275090759/1069260696]
_nv004739rm+0x2b/0x34 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274942529/1069260696]
_nv004385rm+0x49/0x90 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+275090966/1069260696]
_nv004703rm+0x2e/0x38 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274940611/1069260696]
_nv004737rm+0x6f/0x80 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+274853030/1069260696]
_nv001370rm+0x2e/0xcc [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+275730964/1069260696]
_nv001534rm+0x20/0x28 [nvidia]
Jan  3 14:28:18 RADON kernel:  [tasklet_action+67/101]
tasklet_action+0x43/0x65
Jan  3 14:28:18 RADON kernel:  [recalc_task_prio+144/426]
recalc_task_prio+0x90/0x1aa
Jan  3 14:28:18 RADON kernel:  [alloc_skb+72/225] alloc_skb+0x48/0xe1
Jan  3 14:28:18 RADON kernel:  [sock_alloc_send_pskb+192/477]
sock_alloc_send_pskb+0xc0/0x1dd
Jan  3 14:28:18 RADON kernel:  [unix_write_space+139/141]
unix_write_space+0x8b/0x8d
Jan  3 14:28:18 RADON kernel:  [kfree_skbmem+37/44]
kfree_skbmem+0x25/0x2c
Jan  3 14:28:18 RADON kernel:  [__kfree_skb+79/174]
__kfree_skb+0x4f/0xae
Jan  3 14:28:18 RADON kernel:  [sock_aio_read+190/209]
sock_aio_read+0xbe/0xd1
Jan  3 14:28:18 RADON kernel:  [do_sync_read+137/180]
do_sync_read+0x89/0xb4
Jan  3 14:28:18 RADON kernel:  [_end+274914169/1069260696]
rm_ioctl+0x19/0x20 [nvidia]
Jan  3 14:28:18 RADON kernel:  [_end+276374604/1069260696]
nv_kern_ioctl+0x7c/0x449 [nvidia]
Jan  3 14:28:18 RADON kernel:  [sys_select+539/1228]
sys_select+0x21b/0x4cc
Jan  3 14:28:18 RADON kernel:  [sys_ioctl+262/656] sys_ioctl+0x106/0x290
Jan  3 14:28:18 RADON kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan  3 14:28:18 RADON kernel: 



VERSION

Linux version 2.6.1-rc1 (root@RADON) (gcc version 3.3.3 20031206
(prerelease) (Debian)) #1 Sat Jan 3 01:27:25 GMT+1 2004


VER_LINUX

Linux RADON 2.6.1-rc1 #1 Sat Jan 3 01:27:25 GMT+1 2004 i686 GNU/Linux
 
 Gnu C                  3.3.3
 Gnu make               3.80
 util-linux             2.12
 mount                  2.12
 module-init-tools      3.0-pre2
 e2fsprogs              1.35-WIP
 pcmcia-cs              3.2.5
 Linux C Library        2.3.2
 Dynamic linker (ldd)   2.3.2
 Procps                 3.1.15
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               5.0.91
 Modules Loaded         psmouse loop processor snd_intel8x0
 snd_ac97_codec snd_mpu401_uart snd_rawmidi nvidia dummy



CPU INFO


processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.53GHz
stepping        : 4
cpu MHz         : 2571.285
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4980.73

MODULES

psmouse 17932 0 - Live 0xd0848000
loop 13960 0 - Live 0xd0843000
processor 18212 0 - Live 0xd083d000
snd_intel8x0 21796 2 - Live 0xd0828000
snd_ac97_codec 50692 1 snd_intel8x0, Live 0xd082f000
snd_mpu401_uart 6144 1 snd_intel8x0, Live 0xd0812000
snd_rawmidi 20512 1 snd_mpu401_uart, Live 0xd0817000
nvidia 2069992 12 - Live 0xd0a54000
dummy 1668 0 - Live 0xd080d000



IOPORTS

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0                
03f8-03ff : serial              
0cf8-0cff : PCI conf1           
1000-100f : 0000:00:02.5        
1080-10ff : 0000:00:02.7        
  1080-10bf : SiS SI7012 - Controller
  1400-14ff : 0000:00:02.7        
    1400-14ff : SiS SI7012 - AC'97
    1800-18ff : 0000:00:08.0        
      1800-18ff : 8139too           
      8100-811f : 0000:00:02.1    


IOMEM


00000000-0009f3ff : System RAM  
0009f400-0009ffff : reserved    
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM   
000d0000-000d7fff : reserved    
000f0000-000fffff : System ROM  
00100000-0fdeffff : System RAM  
  00100000-0032d45a : Kernel code
    0032d45b-003da57f : Kernel data
    0fdf0000-0fdfefff : ACPI Tables 
    0fdff000-0fdfffff : ACPI Non-volatile Storage
    0fe00000-0fffffff : reserved    
    10000000-10000fff : 0000:00:0c.0
    d0000000-dfffffff : 0000:00:00.0
    e0000000-e0000fff : 0000:00:03.0
    e0001000-e0001fff : 0000:00:03.1
    e0002000-e0002fff : 0000:00:03.2
    e0003000-e0003fff : 0000:00:03.3
    e0004000-e00040ff : 0000:00:08.0
      e0004000-e00040ff : 8139too   
      e0005000-e0005fff : 0000:00:0d.0
      e0400000-e07fffff : 0000:00:06.0
      e1000000-e1ffffff : PCI Bus #01 
        e1000000-e1ffffff : 0000:01:00.0
	e2000000-efffffff : PCI Bus #01 
	  e2000000-e207ffff : 0000:01:00.0
	    e8000000-efffffff : 0000:01:00.0
	    fff00000-ffffffff : reserved  






-- 
2 * 3 * 3 * 37 : The prime factorization of The Beast
Gert De Keersmaecker

