Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272103AbRH2WT5>; Wed, 29 Aug 2001 18:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272108AbRH2WTs>; Wed, 29 Aug 2001 18:19:48 -0400
Received: from ace.ulyssis.student.kuleuven.ac.be ([193.190.253.36]:38360 "EHLO
	ace.ulyssis.org") by vger.kernel.org with ESMTP id <S272103AbRH2WTf>;
	Wed, 29 Aug 2001 18:19:35 -0400
Date: Thu, 30 Aug 2001 00:19:52 +0200 (CEST)
From: Jean-Francois Beleyn <gianfranco@ulyssis.org>
X-X-Sender: <gianfranco@ace>
To: <linux-kernel@vger.kernel.org>
Subject: Oops with 2.4.8-ac7 (qlogic isp)
Message-ID: <Pine.LNX.4.33.0108291359080.4832-100000@ace>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel crash frequently, uptime can vary from 5 min to 2 days ...
crash can happen when there is high disk-activity (kernel compile) or
almost none (only irc-client and ssh-client open). Tried several kernels,
most recent are 2.4.7-ac1 / 2.4.8-aa1 / 2.4.8-ac7.

kernel: 2.4.8-ac7
arch: alpha (ev56)
detail: i use software raid 0 on 2 disks, on the qlogic isp controller
(scsi).

i wrote the oops by hand, so it may not be accurate:


ksymoops 2.4.1 on alpha 2.4.8-ac7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-ac7/ (default)
     -m /boot/System.map-2.4.8-ac7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says fffffc0000438800, System.map says fffffc000037b600.  Ignoring
ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd
says fffffffc004e3820, /lib/modules/2.4.8-ac7/kernel/fs/lockd/lockd.o says
fffffffc004e41e8.  Ignoring /lib/modules/2.4.8-ac7/kernel/fs/lockd/lockd.o
entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says
fffffffc004e3818, /lib/modules/2.4.8-ac7/kernel/fs/lockd/lockd.o says
fffffffc004e41e0.  Ignoring /lib/modules/2.4.8-ac7/kernel/fs/lockd/lockd.o
entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says
fffffffc004e3828, /lib/modules/2.4.8-ac7/kernel/fs/lockd/lockd.o says
fffffffc004e41f0.
 Ignoring /lib/modules/2.4.8-ac7/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says
fffffffc004cbd4c, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd54.
Ignoring /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says
fffffffc004cbd50, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd58.
 Ignoring /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says
fffffffc004cbd54, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd5c.
Ignoring /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says
fffffffc004cbd48, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd50.
Ignoring /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says
fffffffc004cbd1c, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd24.  Ignoring
/lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says
fffffffc004cbd0c, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd14.  Ignoring
/lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says
fffffffc004cbd20, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd28.  Ignoring
/lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says
fffffffc004cbd04, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd0c.  Ignoring
/lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says
fffffffc004cbd08, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd10.  Ignoring
/lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says
fffffffc004cbd00, /lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o says
fffffffc004ccd08.  Ignoring
/lib/modules/2.4.8-ac7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol ide_devfs_handle  , ide-mod
says fffffffc001efe08, /lib/modules/2.4.8-ac7/kernel/drivers/ide/ide-mod.o
says fffffffc001da038.  Ignoring
/lib/modules/2.4.8-ac7/kernel/drivers/ide/ide-mod.o entry
Warning (compare_maps): mismatch on symbol ide_probe  , ide-mod says
fffffffc001efe00, /lib/modules/2.4.8-ac7/kernel/drivers/ide/ide-mod.o says
fffffffc001da030.  Ignoring
/lib/modules/2.4.8-ac7/kernel/drivers/ide/ide-mod.o entry
Warning (compare_maps): mismatch on symbol loadtime  , lvm-mod says
fffffffc001d15ec, /lib/modules/2.4.8-ac7/kernel/drivers/md/lvm-mod.o says
fffffffc001d1fcc.
 Ignoring /lib/modules/2.4.8-ac7/kernel/drivers/md/lvm-mod.o entry
Warning (compare_maps): mismatch on symbol lvm_iop_version  , lvm-mod says
fffffffc001d15e8, /lib/modules/2.4.8-ac7/kernel/drivers/md/lvm-mod.o says
fffffffc001d1fc8.  Ignoring
/lib/modules/2.4.8-ac7/kernel/drivers/md/lvm-mod.o entry
Warning (compare_maps): mismatch on symbol lvm_short_version  , lvm-mod
says fffffffc001d15e0, /lib/modules/2.4.8-ac7/kernel/drivers/md/lvm-mod.o
says fffffffc001d1fc0.  Ignoring
/lib/modules/2.4.8-ac7/kernel/drivers/md/lvm-mod.o entry
Warning (compare_maps): mismatch on symbol lvm_version  , lvm-mod says
fffffffc001d15d8, /lib/modules/2.4.8-ac7/kernel/drivers/md/lvm-mod.o says
fffffffc001d1fb8.  Ignoring
/lib/modules/2.4.8-ac7/kernel/drivers/md/lvm-mod.o entry
Warning (compare_maps): mismatch on symbol tulip_debug  , tulip says
fffffffc001c3b14, /lib/modules/2.4.8-ac7/kernel/drivers/net/tulip/tulip.o
says fffffffc001c4504.  Ignoring
/lib/modules/2.4.8-ac7/kernel/drivers/net/tulip/tulip.o entry
Warning (compare_maps): mismatch on symbol tulip_max_interrupt_work  ,
tulip says fffffffc001c3b00,
/lib/modules/2.4.8-ac7/kernel/drivers/net/tulip/tulip.o says
fffffffc001c44f0.  Ignoring
/lib/modules/2.4.8-ac7/kernel/drivers/net/tulip/tulip.o entry
Warning (compare_maps): mismatch on symbol tulip_rx_copybreak  , tulip
says fffffffc001c3b04,
/lib/modules/2.4.8-ac7/kernel/drivers/net/tulip/tulip.o says
fffffffc001c44f4.  Ignoring
/lib/modules/2.4.8-ac7/kernel/drivers/net/tulip/tulip.o entry
Unable to handle kernel paging request at virtual adress 0000000000000190
hdparm(858): Oops 1
pc=[<fffffc000041e8f4>] ra=[<fffffc000041e9a8>] ps=0007
Using defaults from ksymoops -t elf64-alpha -a alpha
v0=0000000000000000 t0=0000000000070000 t1=fffffc0000000001
t2=0000000000000008 t3=fffffc000001e9d0 t4=fffffc0000001d2b
t5=0000000000000000 t6=0000000000000000 t7=fffffc0000748000
s0=0000000000000000 s1=0000000000000000 s2=fffffc00001e800d
s3=fffffc000001e8c0 s4=0000000000000005 s5=fffffc00005429e0
s6=000000000009c000
a0=fffffc00001d4ec0 a1=0000000000000000 a2=0000000000000003
a3=0000000000000002 a4=fffffc0000538610 a5=ffffffffffffffff
t8=000000000000001f t9=000000000000002b t10=0000000000000002
t11=0000000000001fff pv=fffffc000031b120 at=ffffffffffffffff
gp=fffffc0000588d60 sp=fffffc00074cb890
Trace: fffffc000041e56c fffffc000031585c fffffc0000316260 fffffc000031d710
fffffc0000316884 fffffc0000310b78 fffffc000035a750 fffffc00004abdc0
fffffc000035a734
fffffc00004abec8 fffffc000034e94e fffffc0000310b60
Code: 2ef60000 b0090218 c3e00004 47ff041f 2fe00000 243f0007 <b0290218>
324900db

>>PC;  fffffc000041e8f4 <isp1020_intr_handler+354/460>   <=====
Code;  fffffc000041e8dc <isp1020_intr_handler+33c/460>
0000000000000000 <_PC>:
Code;  fffffc000041e8dc <isp1020_intr_handler+33c/460>
   0:   00 00 f6 2e       ldq_u        t9,0(t8)
Code;  fffffc000041e8e0 <isp1020_intr_handler+340/460>
   4:   18 02 09 b0       stl  v0,536(s0)
Code;  fffffc000041e8e4 <isp1020_intr_handler+344/460>
   8:   04 00 e0 c3       br   1c <_PC+0x1c> fffffc000041e8f8
<isp1020_intr_handler+358/460>
Code;  fffffc000041e8e8 <isp1020_intr_handler+348/460>
   c:   1f 04 ff 47       nop
Code;  fffffc000041e8ec <isp1020_intr_handler+34c/460>
  10:   00 00 e0 2f       unop
Code;  fffffc000041e8f0 <isp1020_intr_handler+350/460>
  14:   07 00 3f 24       ldah t0,7(zero)
>>PC;  fffffc000041e8f4 <isp1020_intr_handler+354/460>   <=====
Code;  fffffc000041e8dc <isp1020_intr_handler+33c/460>
0000000000000000 <_PC>:
Code;  fffffc000041e8dc <isp1020_intr_handler+33c/460>
   0:   00 00 f6 2e       ldq_u        t9,0(t8)
Code;  fffffc000041e8e0 <isp1020_intr_handler+340/460>
   4:   18 02 09 b0       stl  v0,536(s0)
Code;  fffffc000041e8e4 <isp1020_intr_handler+344/460>
   8:   04 00 e0 c3       br   1c <_PC+0x1c> fffffc000041e8f8
<isp1020_intr_handler+358/460>
Code;  fffffc000041e8e8 <isp1020_intr_handler+348/460>
   c:   1f 04 ff 47       nop
Code;  fffffc000041e8ec <isp1020_intr_handler+34c/460>
  10:   00 00 e0 2f       unop
Code;  fffffc000041e8f0 <isp1020_intr_handler+350/460>
  14:   07 00 3f 24       ldah t0,7(zero)
Code;  fffffc000041e8f4 <isp1020_intr_handler+354/460>   <=====
  18:   18 02 29 b0       stl  t0,536(s0)   <=====
Code;  fffffc000041e8f8 <isp1020_intr_handler+358/460>
  1c:   db 00 49 32       ldwu a2,219(s0)

Kernel panic: Aiee, killing interrupt handle !

24 warnings issued.  Results may not be reliable.



I tried to compile the qlogic-isp-driver with and without RELOAD_FIRMWARE
and USE_NVRAM_DEFAULTS ...

i think i have the isp1040 controller, but i'm nor sure, /proc/pci says
it's a isp1020 ...



and this is a similar oops i got with 2.4.7-ac1 :

Unable to handle kernel paging request at virtual adress 0000000000000190
sh(2214): Oops 1
pc=[<fffffc000042a728>] ra=[<fffffc000042a40c>] ps=0000000000000007
Using defaults from ksymoops -t elf64-alpha -a alpha
v0=000000000000001e t0=0000000040b35000 t1=0000000000001000
t2=0000000000000000 t3=0000000000000000 t4=0000000000000000
t5=0000000000000000 t6=0000000000000000 t7=fffffc000a034000
s0=0000000000000000 s1=0000000000000007 s2=fffffc0000013c00
s3=fffffc0000013cc0 s4=0000000000000007 s5=fffffc000055dc00
s6=000000011ffff798
a0=fffffc00000f2180 a1=fffffc0000013c00 a2=fffffc000a037f18
a3=0000000000000000 a4=00000000000000ff a5=0000000000000000
t8=0000000000000000 t9=0000000000000103 t10=000000000000000f
t11=0000000000000000 pv=fffffc000042a3c0 at=0000000000015f00
gp=fffffc00005a5940 sp=fffffc000a037e38
Trace: fffffc000042a40c fffffc000031583c fffffc0000316240 fffffc000031d6f0
fffffc0000316864 fffffc0000310b78
Code: a3300048 a390004c a0100050 a2b00054 a2900058 a270005c <b0290190>
b0490194


>>PC;  fffffc000042a728 <isp1020_intr_handler+2e8/460>   <=====
Code;  fffffc000042a710 <isp1020_intr_handler+2d0/460>
0000000000000000 <_PC>:
Code;  fffffc000042a710 <isp1020_intr_handler+2d0/460>
   0:   48 00 30 a3       ldl  t11,72(a0)
Code;  fffffc000042a714 <isp1020_intr_handler+2d4/460>
   4:   4c 00 90 a3       ldl  at,76(a0)
Code;  fffffc000042a718 <isp1020_intr_handler+2d8/460>
   8:   50 00 10 a0       ldl  v0,80(a0)
Code;  fffffc000042a71c <isp1020_intr_handler+2dc/460>
   c:   54 00 b0 a2       ldl  a5,84(a0)
Code;  fffffc000042a720 <isp1020_intr_handler+2e0/460>
  10:   58 00 90 a2       ldl  a4,88(a0)
Code;  fffffc000042a724 <isp1020_intr_handler+2e4/460>
  14:   5c 00 70 a2       ldl  a3,92(a0)
Code;  fffffc000042a728 <isp1020_intr_handler+2e8/460>   <=====
  18:   90 01 29 b0       stl  t0,400(s0)   <=====
Code;  fffffc000042a72c <isp1020_intr_handler+2ec/460>
  1c:   94 01 49 b0       stl  t1,404(s0)

Kernel panic: Aiee, killing interrupt handle !



greetings
gianfranco

