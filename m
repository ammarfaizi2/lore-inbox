Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280210AbRJaNpQ>; Wed, 31 Oct 2001 08:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280214AbRJaNpJ>; Wed, 31 Oct 2001 08:45:09 -0500
Received: from mail008.mail.bellsouth.net ([205.152.58.28]:38850 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280210AbRJaNox>; Wed, 31 Oct 2001 08:44:53 -0500
Message-ID: <3BE00078.FF088117@mandrakesoft.com>
Date: Wed, 31 Oct 2001 08:45:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: pre6 oom killer oops
Content-Type: multipart/mixed;
 boundary="------------5C3403B0A6DEFA3BC279B984"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5C3403B0A6DEFA3BC279B984
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

2.4.14-pre6 on alpha.  three oops attached, an oops right after oom
killer kicked in, and two hits on this BUG:  kernel BUG at buffer.c:498!

attachments:
dmesg.txt, dmesg output
oops.txt, ksymoops output
sysrqm.txt, sysrq-m output
meminfo.txt, /proc/meminfo output

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------5C3403B0A6DEFA3BC279B984
Content-Type: text/plain; charset=us-ascii;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

39B'
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability 40a1.
do_wp_page: bogus page at address 2000002dbc0 (page 0xfffffc173ab13b00)
VM: killing process cc1(29719)
Unable to handle kernel paging request at virtual address 0031003100303036
cc1(29719): Oops 0
pc = [<fffffc0000833d9c>]  ra = [<fffffc0000833b18>]  ps = 0000    Tainted: P 
v0 = fffffc0011869200  t0 = 0000000000000000  t1 = 0031003100303036
t2 = 0000000000000240  t3 = 00008c3400063301  t4 = fffffc0007256000
t5 = 000000012026bf00  t6 = fffffc0017576000  t7 = fffffc0006048000
s0 = 000000012026bf00  s1 = fffffc00009f72b0  s2 = fffffc0011869200
s3 = 000000012026bf00  s4 = 0000000000000001  s5 = 0000000000000001
s6 = 000000012026bf00
a0 = fffffc0001741dc0  a1 = fffffc0011869200  a2 = 000000012026bf00
a3 = 0000000000000001  a4 = fffffc0017577cf0  a5 = 0000000000000077
t8 = 000000011ffff537  t9 = 000000012026bf00  t10= 0000000000000000
t11= 0000000000000200  pv = fffffc0000833d60  at = fffffc000086adb0
gp = fffffc0000a355f8  sp = fffffc000604b8c8
Trace:fffffc0000833b18 fffffc000081d2d8 fffffc00008103fc fffffc000086c198 fffffc0000984770 fffffc000086adb0 fffffc00009847d0 fffffc0000856220 fffffc000086b690 fffffc00008565c0 fffffc0000856568 fffffc00008128f4 fffffc0000810b20 
Code: b55e0010  a42b0000  f4200030  a55d8b70  a44a0010  e4400006 <a4220000> b42a0010 
swap_free: Bad swap file entry 3539393100320030
swap_free: Bad swap file entry 310031004c3630
swap_free: Bad swap file entry 3931003000310032
swap_free: Bad swap file entry 3630353939310030
swap_free: Bad swap file entry 3000310031004c
swap_free: Bad swap offset entry 3100310031003100
swap_free: Bad swap file entry 2e66656464747368
memory.c:105: bad pmd 0000000000000003.
memory.c:105: bad pmd 000000011ffff2c8.
memory.c:105: bad pmd 000000012006ba80.
memory.c:105: bad pmd 000000012006bc20.
memory.c:105: bad pmd 0000000000000003.
memory.c:105: bad pmd 000002000027c2a8.
memory.c:105: bad pmd 0000000000000001.
swap_free: Bad swap file entry 1201140c0
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 120114060
swap_free: Bad swap file entry 120114040
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 12012f760
swap_free: Bad swap file entry 120113f60
swap_free: Bad swap file entry 120113f60
swap_free: Bad swap file entry 1201a6b40
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 12012f1f8
swap_free: Bad swap file entry 120113f60
swap_free: Bad swap file entry 12012f230
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 12012f470
swap_free: Unused swap offset entry 200000edee8
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 1201308a0
swap_free: Bad swap file entry 120113f60
swap_free: Bad swap file entry 1201308a8
swap_free: Bad swap file entry 120131810
swap_free: Bad swap file entry 1e00000030
swap_free: Bad swap file entry 120114610
swap_free: Bad swap file entry 1201142e8
swap_free: Bad swap file entry 120131850
swap_free: Bad swap file entry 120114448
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 1201143e8
swap_free: Bad swap file entry 1201143c8
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 120131810
swap_free: Bad swap file entry 1201142e8
swap_free: Bad swap file entry 100000808
swap_free: Bad swap file entry 1201142e8
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 120130930
swap_free: Bad swap file entry 1201142e8
swap_free: Bad swap file entry 120130960
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 120130a88
swap_free: Bad swap file entry 1201142e8
swap_free: Bad swap file entry 120130a90
swap_free: Bad swap file entry 1201328d0
swap_free: Bad swap file entry 120133ec0
swap_free: Bad swap file entry 120114610
swap_free: Bad swap file entry 120186150
swap_free: Bad swap file entry 120132920
swap_free: Bad swap file entry 120114770
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 120114710
swap_free: Bad swap file entry 1201146f0
swap_free: Bad swap file entry 12006cc60
swap_free: Bad swap file entry 1201328d0
swap_free: Bad swap file entry 120114610
swap_free: Bad swap file entry 120114610
swap_free: Bad swap file entry 40000086a
swap_free: Bad swap file entry 1201a6bb8
swap_free: Bad swap file entry 3900000038
swap_free: Bad swap file entry 1201158c8
swap_free: Bad swap file entry 120112900
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120113770
swap_free: Bad swap file entry 120114960
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 1201149d0
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120114ab0
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 3234334548454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120114a40
swap_free: Bad swap file entry 3532334548454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120114a78
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120112e70
swap_free: Bad swap file entry 120114b20
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 1201111f0
swap_free: Bad swap file entry 120114b90
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120112e70
swap_free: Bad swap file entry 120114c00
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120114c70
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120114dc8
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 3835334248454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120114ce0
swap_free: Bad swap file entry 6e6972745374375a
swap_free: Bad swap file entry 120113a80
swap_free: Bad swap file entry 120115758
swap_free: Bad swap file entry 120113770
swap_free: Bad swap file entry 120138a88
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120114d48
swap_free: Bad swap file entry 120114e38
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 1201111f0
swap_free: Bad swap file entry 120114ea8
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120114d48
swap_free: Bad swap file entry 120114f18
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120114f88
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120114ff8
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115068
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115140
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 3537334248454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 1201150d8
swap_free: Bad swap file entry 3033394c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120115110
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 1201151b0
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120113770
swap_free: Bad swap file entry 120115220
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 1201111f0
swap_free: Bad swap file entry 120115290
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120113770
swap_free: Bad swap file entry 120115300
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115370
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115450
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 3537334548454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 1201153e0
swap_free: Bad swap file entry 3835334548454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120115418
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120112e70
swap_free: Bad swap file entry 1201154c0
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 1201111f0
swap_free: Bad swap file entry 120115530
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120112e70
swap_free: Bad swap file entry 1201155a0
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115610
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 1201156b8
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 3139334248454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120115680
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 12010e338
swap_free: Bad swap file entry 1201157d8
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 5f63435f3831415a
swap_free: Bad swap file entry 6e69727453743752
swap_free: Bad swap file entry 120113ae0
swap_free: Bad swap file entry 120116420
swap_free: Bad swap file entry 120114d48
swap_free: Bad swap file entry 120132a08
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120115758
swap_free: Bad swap file entry 120115848
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 1201111f0
swap_free: Bad swap file entry 1201158e0
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 1201168b8
swap_free: Bad swap file entry 1201148e0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120115758
swap_free: Bad swap file entry 120115950
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 1201159c0
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115a30
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115aa0
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115b78
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 3830344248454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120115b10
swap_free: Bad swap file entry 3133394c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120115b48
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120115be8
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120113770
swap_free: Bad swap file entry 120115c58
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 1201111f0
swap_free: Bad swap file entry 120115cc8
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120113770
swap_free: Bad swap file entry 120115d38
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115da8
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120115e48
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 3732374c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120115e18
swap_free: Bad swap file entry 120111998
swap_free: Bad swap file entry 120115f28
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 3830344548454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120115eb8
swap_free: Bad swap file entry 3139334548454c24
swap_free: Bad swap file entry 12010a210
swap_free: Bad swap file entry 120115ef0
swap_free: Bad swap file entry 120111c20
swap_free: Bad swap file entry 120115f98
swap_free: Bad swap file entry 120046ef0
swap_free: Bad swap file entry 120111c20
swap_free: Bad swap file entry 120170ce8
swap_free: Bad swap file entry 120116008
swap_free: Bad swap file entry 120046ef0
kernel BUG at buffer.c:498!
ld(31453): Kernel Bug 1
pc = [<fffffc000084ca78>]  ra = [<fffffc000084ca6c>]  ps = 0000    Tainted: P 
v0 = 000000000000001c  t0 = 0000000000000001  t1 = fffffc0016cdbec8
t2 = 0000000000000023  t3 = 0000000000000001  t4 = fffffc0000a3a5d8
t5 = fffffc0001741dc0  t6 = 0000000000000065  t7 = fffffc0015b6c000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 00000000000000a0  a5 = 0000000000000002
t8 = fffffc0000a3b080  t9 = 0000000000004000  t10= fffffc0000a3b088
t11= fffffc0000a3b098  pv = fffffc000081e1b0  at = 0000000000000000
gp = fffffc0000a355f8  sp = fffffc0015b6fd88
Trace:fffffc000084db44 fffffc000084ea4c fffffc000084f3d0 fffffc000083af70 fffffc000084aad4 fffffc0000810b20 
Code: e4200005  a77da768  6b5b54bd  27ba001f  23bd8b8c  00000081 <a42a0000> f4200003 
kernel BUG at buffer.c:498!
kupdated(6): Kernel Bug 1
pc = [<fffffc000084ca78>]  ra = [<fffffc000084ca6c>]  ps = 0000    Tainted: P 
v0 = 000000000000001c  t0 = 0000000000000001  t1 = fffffc0016cdbec8
t2 = 0000000000000066  t3 = 0000000000000001  t4 = fffffc0000a3a5d8
t5 = fffffc00017415c0  t6 = 0000000000000065  t7 = fffffc0017f20000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 00000000000000a0  a5 = 0000000000000002
t8 = fffffc0000a3b080  t9 = 0000000000004000  t10= fffffc0000a3b088
t11= fffffc0000a3b098  pv = fffffc000081e1b0  at = 0000000000000000
gp = fffffc0000a355f8  sp = fffffc0017f238e0
Trace:fffffc000084c170 fffffc0000850be8 fffffc000084db44 fffffc000084dc14 fffffc000087b29c fffffc00008653ac fffffc000087de90 fffffc000087def8 fffffc0000851b28 fffffc0000850ba4 fffffc0000851028 fffffc0000810690 fffffc0000850ea0 
Code: e4200005  a77da768  6b5b54bd  27ba001f  23bd8b8c  00000081 <a42a0000> f4200003 

--------------5C3403B0A6DEFA3BC279B984
Content-Type: text/plain; charset=us-ascii;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

ksymoops 2.4.1 on alpha 2.4.14-pre6.  Options used
     -v /home/jgarzik/cvs/linux_2_4/vmlinux (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.14-pre6 (specified)
     -m /boot/System.map-2.4.14-pre6 (specified)

Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says fffffffc002c2584, /lib/modules/2.4.14-pre6/kernel/net/packet/af_packet.o says fffffffc002be004.  Ignoring /lib/modules/2.4.14-pre6/kernel/net/packet/af_packet.o entry
Unable to handle kernel paging request at virtual address 0031003100303036
cc1(29719): Oops 0
pc = [<fffffc0000833d9c>]  ra = [<fffffc0000833b18>]  ps = 0000    Tainted: P 
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = fffffc0011869200  t0 = 0000000000000000  t1 = 0031003100303036
t2 = 0000000000000240  t3 = 00008c3400063301  t4 = fffffc0007256000
t5 = 000000012026bf00  t6 = fffffc0017576000  t7 = fffffc0006048000
s0 = 000000012026bf00  s1 = fffffc00009f72b0  s2 = fffffc0011869200
s3 = 000000012026bf00  s4 = 0000000000000001  s5 = 0000000000000001
s6 = 000000012026bf00
a0 = fffffc0001741dc0  a1 = fffffc0011869200  a2 = 000000012026bf00
a3 = 0000000000000001  a4 = fffffc0017577cf0  a5 = 0000000000000077
t8 = 000000011ffff537  t9 = 000000012026bf00  t10= 0000000000000000
t11= 0000000000000200  pv = fffffc0000833d60  at = fffffc000086adb0
gp = fffffc0000a355f8  sp = fffffc000604b8c8
Trace:fffffc0000833b18 fffffc000081d2d8 fffffc00008103fc fffffc000086c198 fffffc0000984770 fffffc000086adb0 fffffc00009847d0 fffffc0000856220 fffffc000086b690 fffffc00008565c0 fffffc0000856568 fffffc00008128f4 fffffc0000810b20 
Code: b55e0010  a42b0000  f4200030  a55d8b70  a44a0010  e4400006 <a4220000> b42a0010 

>>PC;  fffffc0000833d9c <pte_alloc+3c/130>   <=====
Trace; fffffc0000833b18 <handle_mm_fault+98/1c0>
Trace; fffffc000081d2d8 <do_page_fault+208/4c0>
Trace; fffffc00008103fc <entMM+9c/c0>
Trace; fffffc000086c198 <load_elf_binary+b08/cc0>
Trace; fffffc0000984770 <__do_clear_user+0/150>
Trace; fffffc000086adb0 <padzero+40/50>
Trace; fffffc00009847d0 <__do_clear_user+60/150>
Trace; fffffc0000856220 <search_binary_handler+140/310>
Trace; fffffc000086b690 <load_elf_binary+0/cc0>
Trace; fffffc00008565c0 <do_execve+1d0/280>
Trace; fffffc0000856568 <do_execve+178/280>
Trace; fffffc00008128f4 <sys_execve+64/b0>
Trace; fffffc0000810b20 <entSys+a8/c0>
Code;  fffffc0000833d84 <pte_alloc+24/130>
0000000000000000 <_PC>:
Code;  fffffc0000833d84 <pte_alloc+24/130>
   0:   10 00 5e b5       stq  s1,16(sp)
Code;  fffffc0000833d88 <pte_alloc+28/130>
   4:   00 00 2b a4       ldq  t0,0(s2)
Code;  fffffc0000833d8c <pte_alloc+2c/130>
   8:   30 00 20 f4       bne  t0,cc <_PC+0xcc> fffffc0000833e50 <pte_alloc+f0/130>
Code;  fffffc0000833d90 <pte_alloc+30/130>
   c:   70 8b 5d a5       ldq  s1,-29840(gp)
Code;  fffffc0000833d94 <pte_alloc+34/130>
  10:   10 00 4a a4       ldq  t1,16(s1)
Code;  fffffc0000833d98 <pte_alloc+38/130>
  14:   06 00 40 e4       beq  t1,30 <_PC+0x30> fffffc0000833db4 <pte_alloc+54/130>
Code;  fffffc0000833d9c <pte_alloc+3c/130>   <=====
  18:   00 00 22 a4       ldq  t0,0(t1)   <=====
Code;  fffffc0000833da0 <pte_alloc+40/130>
  1c:   10 00 2a b4       stq  t0,16(s1)

kernel BUG at buffer.c:498!
ld(31453): Kernel Bug 1
pc = [<fffffc000084ca78>]  ra = [<fffffc000084ca6c>]  ps = 0000    Tainted: P 
v0 = 000000000000001c  t0 = 0000000000000001  t1 = fffffc0016cdbec8
t2 = 0000000000000023  t3 = 0000000000000001  t4 = fffffc0000a3a5d8
t5 = fffffc0001741dc0  t6 = 0000000000000065  t7 = fffffc0015b6c000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 00000000000000a0  a5 = 0000000000000002
t8 = fffffc0000a3b080  t9 = 0000000000004000  t10= fffffc0000a3b088
t11= fffffc0000a3b098  pv = fffffc000081e1b0  at = 0000000000000000
gp = fffffc0000a355f8  sp = fffffc0015b6fd88
Trace:fffffc000084db44 fffffc000084ea4c fffffc000084f3d0 fffffc000083af70 fffffc000084aad4 fffffc0000810b20 
Code: e4200005  a77da768  6b5b54bd  27ba001f  23bd8b8c  00000081 <a42a0000> f4200003 

>>PC;  fffffc000084ca78 <__insert_into_lru_list+68/f0>   <=====
Trace; fffffc000084db44 <refile_buffer+14/20>
Trace; fffffc000084ea4c <__block_commit_write+fc/180>
Trace; fffffc000084f3d0 <generic_commit_write+40/80>
Trace; fffffc000083af70 <generic_file_write+550/740>
Trace; fffffc000084aad4 <sys_write+e4/160>
Trace; fffffc0000810b20 <entSys+a8/c0>
Code;  fffffc000084ca60 <__insert_into_lru_list+50/f0>
0000000000000000 <_PC>:
Code;  fffffc000084ca60 <__insert_into_lru_list+50/f0>
   0:   05 00 20 e4       beq  t0,18 <_PC+0x18> fffffc000084ca78 <__insert_into_lru_list+68/f0>
Code;  fffffc000084ca64 <__insert_into_lru_list+54/f0>
   4:   68 a7 7d a7       ldq  t12,-22680(gp)
Code;  fffffc000084ca68 <__insert_into_lru_list+58/f0>
   8:   bd 54 5b 6b       jsr  ra,(t12),5300 <_PC+0x5300> fffffc0000851d60 <alloc_super+20/170>
Code;  fffffc000084ca6c <__insert_into_lru_list+5c/f0>
   c:   1f 00 ba 27       ldah gp,31(ra)
Code;  fffffc000084ca70 <__insert_into_lru_list+60/f0>
  10:   8c 8b bd 23       lda  gp,-29812(gp)
Code;  fffffc000084ca74 <__insert_into_lru_list+64/f0>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc000084ca78 <__insert_into_lru_list+68/f0>   <=====
  18:   00 00 2a a4       ldq  t0,0(s1)   <=====
Code;  fffffc000084ca7c <__insert_into_lru_list+6c/f0>
  1c:   03 00 20 f4       bne  t0,2c <_PC+0x2c> fffffc000084ca8c <__insert_into_lru_list+7c/f0>

kernel BUG at buffer.c:498!
kupdated(6): Kernel Bug 1
pc = [<fffffc000084ca78>]  ra = [<fffffc000084ca6c>]  ps = 0000    Tainted: P 
v0 = 000000000000001c  t0 = 0000000000000001  t1 = fffffc0016cdbec8
t2 = 0000000000000066  t3 = 0000000000000001  t4 = fffffc0000a3a5d8
t5 = fffffc00017415c0  t6 = 0000000000000065  t7 = fffffc0017f20000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 00000000000000a0  a5 = 0000000000000002
t8 = fffffc0000a3b080  t9 = 0000000000004000  t10= fffffc0000a3b088
t11= fffffc0000a3b098  pv = fffffc000081e1b0  at = 0000000000000000
gp = fffffc0000a355f8  sp = fffffc0017f238e0
Trace:fffffc000084c170 fffffc0000850be8 fffffc000084db44 fffffc000084dc14 fffffc000087b29c fffffc00008653ac fffffc000087de90 fffffc000087def8 fffffc0000851b28 fffffc0000850ba4 fffffc0000851028 fffffc0000810690 fffffc0000850ea0 
Code: e4200005  a77da768  6b5b54bd  27ba001f  23bd8b8c  00000081 <a42a0000> f4200003 

>>PC;  fffffc000084ca78 <__insert_into_lru_list+68/f0>   <=====
Trace; fffffc000084c170 <write_some_buffers+b0/160>
Trace; fffffc0000850be8 <sync_old_buffers+78/b0>
Trace; fffffc000084db44 <refile_buffer+14/20>
Trace; fffffc000084dc14 <bread+14/90>
Trace; fffffc000087b29c <ext2_update_inode+16c/4c0>
Trace; fffffc00008653ac <sync_unlocked_inodes+1bc/200>
Trace; fffffc000087de90 <ext2_commit_super+30/50>
Trace; fffffc000087def8 <ext2_write_super+48/60>
Trace; fffffc0000851b28 <sync_supers+218/250>
Trace; fffffc0000850ba4 <sync_old_buffers+34/b0>
Trace; fffffc0000851028 <kupdate+188/190>
Trace; fffffc0000810690 <kernel_thread+58/70>
Trace; fffffc0000850ea0 <kupdate+0/190>
Code;  fffffc000084ca60 <__insert_into_lru_list+50/f0>
0000000000000000 <_PC>:
Code;  fffffc000084ca60 <__insert_into_lru_list+50/f0>
   0:   05 00 20 e4       beq  t0,18 <_PC+0x18> fffffc000084ca78 <__insert_into_lru_list+68/f0>
Code;  fffffc000084ca64 <__insert_into_lru_list+54/f0>
   4:   68 a7 7d a7       ldq  t12,-22680(gp)
Code;  fffffc000084ca68 <__insert_into_lru_list+58/f0>
   8:   bd 54 5b 6b       jsr  ra,(t12),5300 <_PC+0x5300> fffffc0000851d60 <alloc_super+20/170>
Code;  fffffc000084ca6c <__insert_into_lru_list+5c/f0>
   c:   1f 00 ba 27       ldah gp,31(ra)
Code;  fffffc000084ca70 <__insert_into_lru_list+60/f0>
  10:   8c 8b bd 23       lda  gp,-29812(gp)
Code;  fffffc000084ca74 <__insert_into_lru_list+64/f0>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc000084ca78 <__insert_into_lru_list+68/f0>   <=====
  18:   00 00 2a a4       ldq  t0,0(s1)   <=====
Code;  fffffc000084ca7c <__insert_into_lru_list+6c/f0>
  1c:   03 00 20 f4       bne  t0,2c <_PC+0x2c> fffffc000084ca8c <__insert_into_lru_list+7c/f0>


1 warning issued.  Results may not be reliable.

--------------5C3403B0A6DEFA3BC279B984
Content-Type: text/plain; charset=us-ascii;
 name="sysrqm.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysrqm.txt"

SysRq : Show Memory

Mem-info:
Free pages:       86776kB (     0kB HighMem)
Zone:DMA freepages:  1912kB min:   512KB low:  1024kB high:  1536kB
Zone:Normal freepages: 84864kB min:  2040KB low:  4080kB high:  6120kB
Zone:HighMem freepages:     0kB min:     0KB low:     0kB high:     0kB
Free pages:       86776kB (     0kB HighMem)
( Active: 9813, inactive: 19020, free: 10847 )
85*8kB 13*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1912kB)
780*8kB 2760*16kB 725*32kB 82*64kB 13*128kB 3*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 84864kB)
= 0kB)
Swap cache: add 111, delete 13, find 19/20, race 0+0
Free swap:       408368kB
49074 pages of RAM
11317 free pages
1299 reserved pages
23424 pages shared
98 pages swap cached
49 pages in page table cache
Buffer memory:    33344kB

--------------5C3403B0A6DEFA3BC279B984
Content-Type: text/plain; charset=us-ascii;
 name="meminfo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="meminfo.txt"

        total:    used:    free:  shared: buffers:  cached:
Mem:  391372800 302718976 88653824        0 34152448 187908096
Swap: 418996224   827392 418168832
MemTotal:       382200 kB
MemFree:         86576 kB
MemShared:           0 kB
Buffers:         33352 kB
Cached:         182720 kB
SwapCached:        784 kB
Active:          78520 kB
Inactive:       152320 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       382200 kB
LowFree:         86576 kB
SwapTotal:      409176 kB
SwapFree:       408368 kB

--------------5C3403B0A6DEFA3BC279B984--


