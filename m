Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbSJJV6W>; Thu, 10 Oct 2002 17:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbSJJV6W>; Thu, 10 Oct 2002 17:58:22 -0400
Received: from xdsl-213-168-107-42.netcologne.de ([213.168.107.42]:52686 "HELO
	torres.office.sevenval.de") by vger.kernel.org with SMTP
	id <S262389AbSJJVy4>; Thu, 10 Oct 2002 17:54:56 -0400
Subject: Kernel crashes on athlon with reiserfs while dselect does its work.
From: wilfried Goesgens <willi@7val.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-IpxFohRu5UNydibvIiyw"
Message-Id: <1034173322.4781.97.camel@torres.home.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Oct 2002 23:58:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IpxFohRu5UNydibvIiyw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello everbudy...
First I noticed apache crashing my machine. I've recompiled the kernel
to have all that debugging stuff, now it just says for the apache:
 apache.crashes -t
Inconsistency detected by ld.so: dynamic-link.h: 62:
elf_get_dynamic_info: Assertion `! "bad dynamic tag"' failed!

I've tried to poke around a bit with reiserfsck, but it didn't improve
anything.

After recompiling the kernel with the debugging stuff, I also added
serial console support to get the dumps.
Entering deselect/install, after saying yes to start installing
(downloading is already done) the machine crashes with three different
behaviours: 
* reboot instantly
* create the crashdump one and hang
* create the crashdump two and hang

If I can provide you with any more information, please let me know.
please cc me, as I'm not subscribed.
Willi

cat /proc/version 
Linux version 2.4.19 (root@castaway.home.sv) (gcc version 2.95.4
20011002 (Debian prerelease)) #3 Wed Oct 9 13:30:38 CEST 2002

cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1002.307
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1998.84

mount
/dev/ide/host0/bus0/target0/lun0/part7 on / type reiserfs
(rw,errors=remount-ro)
proc on /proc type proc (rw)
/dev/ide/host0/bus0/target0/lun0/part6 on /boot type ext2 (rw)

cat /proc/modules 
floppy                 46076   0 (autoclean)
rd                      3008   0 (unused)
nfs                    45440   0 (unused)
lockd                  37072   0 [nfs]
sunrpc                 58396   0 [nfs lockd]
isdnloop               12888   0 (unused)
i2o_proc               41244   0 (unused)
i2o_lan                10960   0 (unused)
i2o_config              7240   0 (unused)
i2o_block              51520   0 (unused)
i2o_core               33648   0 [i2o_proc i2o_lan i2o_config i2o_block]
matroxfb_Ti3026          464   0 (unused)
matroxfb_base          17316  63
matroxfb_DAC1064        6548   0 [matroxfb_base]
matroxfb_accel          9096   0 [matroxfb_base matroxfb_DAC1064]
fbcon-cfb4              2440   0 [matroxfb_accel]
fbcon-cfb24             5480   0 [matroxfb_accel]
fbcon-cfb8              3944   0 [matroxfb_accel]
fbcon-cfb32             5736   0 [matroxfb_accel]
fbcon-cfb16             5192   0 [matroxfb_accel]
g450_pll                3568   0 [matroxfb_DAC1064]
matroxfb_misc          14988   0 [matroxfb_base matroxfb_DAC1064
matroxfb_accel g450_pll]
via82cxxx_audio        18584   0
uart401                 6340   0 [via82cxxx_audio]
ac97_codec             10056   0 [via82cxxx_audio]
usbmouse                1816   0 (unused)
sound                  54860   0 [via82cxxx_audio uart401]
usbcore                34720   0 [usbmouse]
aic7xxx_old           129952   0 (unused)
loop                    8408   0 (unused)
serial                 44292   2
isa-pnp                28580   0 [serial]
sg                     24860   0 (unused)
ide-cd                 27364   0
soundcore               3460   5 [via82cxxx_audio sound]
ipip                    6052   0 (unused)
ip_gre                  7936   0 (unused)
mousedev                3864   1
input                   3264   0 [usbmouse mousedev]
i2c-algo-pcf            4924   0 (unused)
i2c-core               12388   0 [i2c-algo-pcf]
nvram                   3700   0 (unused)
parport_pc             25288   1 (autoclean)
lp                      6560   0 (unused)
parport                22432   1 [parport_pc lp]
sr_mod                 13264   0 (unused)
scsi_mod               82216   3 [aic7xxx_old sg sr_mod]
cdrom                  28832   0 [ide-cd sr_mod]
hisax                 144512   0 (unused)
isdn                  119072   0 [isdnloop hisax]
slhc                    4560   0 [isdn]


--=-IpxFohRu5UNydibvIiyw
Content-Disposition: attachment; filename=catProcPci
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=catProcPci; charset=UTF-8

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3).
      Master Capable.  Latency=3D8. =20
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0=
).
      Master Capable.  No bursts.  Min Gnt=3D12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 6=
4).
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 22).
      IRQ 10.
      Master Capable.  Latency=3D32. =20
      I/O at 0x9400 [0x941f].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
      IRQ 14.
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio=
 Controller (rev 80).
      IRQ 11.
      I/O at 0x9c00 [0x9cff].
      I/O at 0xa000 [0xa003].
      I/O at 0xa400 [0xa403].
  Bus  0, device   9, function  0:
    SCSI storage controller: Adaptec AHA-2940/2940W / AIC-7871 (rev 0).
      IRQ 5.
      Master Capable.  Latency=3D32.  Min Gnt=3D8.Max Lat=3D8.
      I/O at 0xa800 [0xa8ff].
      Non-prefetchable 32 bit memory at 0xda000000 [0xda000fff].
  Bus  0, device  10, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 116=
).
      IRQ 11.
      Master Capable.  Latency=3D32.  Min Gnt=3D10.Max Lat=3D10.
      I/O at 0xac00 [0xac7f].
      Non-prefetchable 32 bit memory at 0xda001000 [0xda00107f].
  Bus  0, device  14, function  0:
    Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HP=
T370 (rev 4).
      IRQ 5.
      Master Capable.  Latency=3D120.  Min Gnt=3D8.Max Lat=3D8.
      I/O at 0xb000 [0xb007].
      I/O at 0xb400 [0xb403].
      I/O at 0xb800 [0xb807].
      I/O at 0xbc00 [0xbc03].
      I/O at 0xc000 [0xc0ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 4).
      IRQ 15.
      Master Capable.  Latency=3D32.  Min Gnt=3D16.Max Lat=3D32.
      Prefetchable 32 bit memory at 0xd4000000 [0xd5ffffff].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6003fff].
      Non-prefetchable 32 bit memory at 0xd7000000 [0xd77fffff].

--=-IpxFohRu5UNydibvIiyw
Content-Disposition: attachment; filename=chrash.ksymoops
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=chrash.ksymoops; charset=UTF-8

ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address d0000000
c0220b64
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0220b64>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000014   ebx: 03f79a97   ecx: cde79647   edx: 80050033
esi: cc094a2c   edi: cfffffc7   ebp: c9fcda08   esp: c9fcd9f8
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 607, stackpage=3Dc9fcd000)
Stack: 0000f647 00000001 cde79647 cde79647 c9fcda58 c0182d8f cfffffc7 c9f0e=
0ac=20
       ffff0f54 00000001 c9fcdac4 00000000 ffff0f54 00000018 00100001 00000=
002=20
       00000010 00000001 cde6a000 0000059b 0000000f 00000403 0000000f cde87=
c8c=20
Call Trace:    [<c0182d8f>] [<c018335c>] [<c01835ec>] [<c0183657>] [<c0172d=
90>]
  [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868ed>] [<c0188e=
2f>]
  [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c013122a>] [<c01315=
76>]
  [<c010897f>]
Code: 0f 7f 5f 38 83 c6 40 83 c7 40 89 7d 08 4b 83 fb 05 7f a9 eb=20


>>EIP; c0220b64 <_mmx_memcpy+c4/160>   <=3D=3D=3D=3D=3D

>>ecx; cde79647 <_end+db99f4f/10618968>
>>esi; cc094a2c <_end+bdb5334/10618968>
>>edi; cfffffc7 <_end+fd208cf/10618968>
>>ebp; c9fcda08 <_end+9cee310/10618968>
>>esp; c9fcd9f8 <_end+9cee300/10618968>

Trace; c0182d8f <leaf_copy_items_entirely+1cf/250>
Trace; c018335c <leaf_copy_items+5c/120>
Trace; c01835ec <leaf_move_items+3c/80>
Trace; c0183657 <leaf_shift_left+27/90>
Trace; c0172d90 <balance_leaf+2a0/20e0>
Trace; c017da09 <dc_check_balance_internal+289/4d0>
Trace; c017e1d2 <clear_all_dirty_bits+12/20>
Trace; c017e337 <wait_tb_buffers_until_unlocked+157/310>
Trace; c0174f70 <do_balance+80/100>
Trace; c01868ed <search_by_key+97d/eb0>
Trace; c0188e2f <reiserfs_insert_item+8f/e0>
Trace; c0179c28 <reiserfs_new_inode+3e8/4b0>
Trace; c0175d25 <reiserfs_create+85/160>
Trace; c013b4a3 <vfs_create+73/b0>
Trace; c013b62c <open_namei+14c/510>
Trace; c013122a <filp_open+3a/60>
Trace; c0131576 <sys_open+36/90>
Trace; c010897f <system_call+33/38>

Code;  c0220b64 <_mmx_memcpy+c4/160>
00000000 <_EIP>:
Code;  c0220b64 <_mmx_memcpy+c4/160>   <=3D=3D=3D=3D=3D
   0:   0f 7f 5f 38               movq   %mm3,0x38(%edi)   <=3D=3D=3D=3D=3D
Code;  c0220b68 <_mmx_memcpy+c8/160>
   4:   83 c6 40                  add    $0x40,%esi
Code;  c0220b6b <_mmx_memcpy+cb/160>
   7:   83 c7 40                  add    $0x40,%edi
Code;  c0220b6e <_mmx_memcpy+ce/160>
   a:   89 7d 08                  mov    %edi,0x8(%ebp)
Code;  c0220b71 <_mmx_memcpy+d1/160>
   d:   4b                        dec    %ebx
Code;  c0220b72 <_mmx_memcpy+d2/160>
   e:   83 fb 05                  cmp    $0x5,%ebx
Code;  c0220b75 <_mmx_memcpy+d5/160>
  11:   7f a9                     jg     ffffffbc <_EIP+0xffffffbc> c0220b2=
0 <_mmx_memcpy+80/160>
Code;  c0220b77 <_mmx_memcpy+d7/160>
  13:   eb 00                     jmp    15 <_EIP+0x15> c0220b79 <_mmx_memc=
py+d9/160>

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00114
c012408c
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012408c>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: ca772eac   ecx: c12c6148   edx: c12c6148
esi: cbe25814   edi: 40000000   ebp: c9fcd8c8   esp: c9fcd8b4
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 607, stackpage=3Dc9fcd000)
Stack: cbe25814 c9fcd9c4 c9fcc000 00012000 ca772e60 c9fcd8d8 c0113d0b cbe25=
814=20
       cbe25814 c9fcd8f0 c0117f62 cbe25814 00000002 c9fcd9c4 c0111e20 c9fcd=
904=20
       c0108f66 0000000b 00000000 00000002 c9fcd9b4 c01121a3 c0229a5e c9fcd=
9c4=20
Call Trace:    [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121=
a3>]
  [<c0111e20>] [<c011c60b>] [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e=
8d>]
  [<c0108a70>] [<c0220b64>] [<c0182d8f>] [<c018335c>] [<c01835ec>] [<c01836=
57>]
  [<c0172d90>] [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868=
ed>]
  [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c01312=
2a>]
  [<c0131576>] [<c010897f>]
Code: ff 80 14 01 00 00 8b 53 28 85 d2 74 06 8b 43 2c 89 42 2c 8b=20


>>EIP; c012408c <exit_mmap+8c/120>   <=3D=3D=3D=3D=3D

>>ebx; ca772eac <_end+a4937b4/10618968>
>>ecx; c12c6148 <_end+fe6a50/10618968>
>>edx; c12c6148 <_end+fe6a50/10618968>
>>esi; cbe25814 <_end+bb4611c/10618968>
>>ebp; c9fcd8c8 <_end+9cee1d0/10618968>
>>esp; c9fcd8b4 <_end+9cee1bc/10618968>

Trace; c0113d0b <mmput+3b/60>
Trace; c0117f62 <do_exit+82/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c011c60b <timer_bh+23b/360>
Trace; c011964c <bh_action+1c/50>
Trace; c0119569 <tasklet_hi_action+49/70>
Trace; c011934b <do_softirq+4b/a0>
Trace; c0109e8d <do_IRQ+9d/b0>
Trace; c0108a70 <error_code+34/3c>
Trace; c0220b64 <_mmx_memcpy+c4/160>
Trace; c0182d8f <leaf_copy_items_entirely+1cf/250>
Trace; c018335c <leaf_copy_items+5c/120>
Trace; c01835ec <leaf_move_items+3c/80>
Trace; c0183657 <leaf_shift_left+27/90>
Trace; c0172d90 <balance_leaf+2a0/20e0>
Trace; c017da09 <dc_check_balance_internal+289/4d0>
Trace; c017e1d2 <clear_all_dirty_bits+12/20>
Trace; c017e337 <wait_tb_buffers_until_unlocked+157/310>
Trace; c0174f70 <do_balance+80/100>
Trace; c01868ed <search_by_key+97d/eb0>
Trace; c0188e2f <reiserfs_insert_item+8f/e0>
Trace; c0179c28 <reiserfs_new_inode+3e8/4b0>
Trace; c0175d25 <reiserfs_create+85/160>
Trace; c013b4a3 <vfs_create+73/b0>
Trace; c013b62c <open_namei+14c/510>
Trace; c013122a <filp_open+3a/60>
Trace; c0131576 <sys_open+36/90>
Trace; c010897f <system_call+33/38>

Code;  c012408c <exit_mmap+8c/120>
00000000 <_EIP>:
Code;  c012408c <exit_mmap+8c/120>   <=3D=3D=3D=3D=3D
   0:   ff 80 14 01 00 00         incl   0x114(%eax)   <=3D=3D=3D=3D=3D
Code;  c0124092 <exit_mmap+92/120>
   6:   8b 53 28                  mov    0x28(%ebx),%edx
Code;  c0124095 <exit_mmap+95/120>
   9:   85 d2                     test   %edx,%edx
Code;  c0124097 <exit_mmap+97/120>
   b:   74 06                     je     13 <_EIP+0x13> c012409f <exit_mmap=
+9f/120>
Code;  c0124099 <exit_mmap+99/120>
   d:   8b 43 2c                  mov    0x2c(%ebx),%eax
Code;  c012409c <exit_mmap+9c/120>
  10:   89 42 2c                  mov    %eax,0x2c(%edx)
Code;  c012409f <exit_mmap+9f/120>
  13:   8b 00                     mov    (%eax),%eax

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9fcc0a8   ebx: 00000000   ecx: c12c7e98   edx: cffe4000
esi: cffe4000   edi: c9fcc000   ebp: c9fcd798   esp: c9fcd78c
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 607, stackpage=3Dc9fcd000)
Stack: cffee1ec c9fcd880 c9fcc000 c9fcd7ac c01180f6 00000002 c9fcd880 c0111=
e20=20
       c9fcd7c0 c0108f66 0000000b 00000000 00000002 c9fcd870 c01121a3 c0229=
a5e=20
       c9fcd880 00000002 c9fcc000 00000002 c0111e20 62613938 66656463 00000=
114=20
Call Trace:    [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c012c3ae>] [<c012c7d5>] [<c01217b2>] [<c0108a70>] [<c012408c>] [<c0113d=
0b>]
  [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e20>] [<c011c6=
0b>]
  [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e8d>] [<c0108a70>] [<c0220b=
64>]
  [<c0182d8f>] [<c018335c>] [<c01835ec>] [<c0183657>] [<c0172d90>] [<c017da=
09>]
  [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868ed>] [<c0188e2f>] [<c0179c=
28>]
  [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c013122a>] [<c0131576>] [<c01089=
7f>]
Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20


>>EIP; c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D

>>eax; c9fcc0a8 <_end+9cec9b0/10618968>
>>ecx; c12c7e98 <_end+fe87a0/10618968>
>>edx; cffe4000 <_end+fd04908/10618968>
>>esi; cffe4000 <_end+fd04908/10618968>
>>edi; c9fcc000 <_end+9cec908/10618968>
>>ebp; c9fcd798 <_end+9cee0a0/10618968>
>>esp; c9fcd78c <_end+9cee094/10618968>

Trace; c01180f6 <do_exit+216/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c012c3ae <__free_pages+1e/30>
Trace; c012c7d5 <free_page_and_swap_cache+35/40>
Trace; c01217b2 <__free_pte+42/50>
Trace; c0108a70 <error_code+34/3c>
Trace; c012408c <exit_mmap+8c/120>
Trace; c0113d0b <mmput+3b/60>
Trace; c0117f62 <do_exit+82/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c011c60b <timer_bh+23b/360>
Trace; c011964c <bh_action+1c/50>
Trace; c0119569 <tasklet_hi_action+49/70>
Trace; c011934b <do_softirq+4b/a0>
Trace; c0109e8d <do_IRQ+9d/b0>
Trace; c0108a70 <error_code+34/3c>
Trace; c0220b64 <_mmx_memcpy+c4/160>
Trace; c0182d8f <leaf_copy_items_entirely+1cf/250>
Trace; c018335c <leaf_copy_items+5c/120>
Trace; c01835ec <leaf_move_items+3c/80>
Trace; c0183657 <leaf_shift_left+27/90>
Trace; c0172d90 <balance_leaf+2a0/20e0>
Trace; c017da09 <dc_check_balance_internal+289/4d0>
Trace; c017e1d2 <clear_all_dirty_bits+12/20>
Trace; c017e337 <wait_tb_buffers_until_unlocked+157/310>
Trace; c0174f70 <do_balance+80/100>
Trace; c01868ed <search_by_key+97d/eb0>
Trace; c0188e2f <reiserfs_insert_item+8f/e0>
Trace; c0179c28 <reiserfs_new_inode+3e8/4b0>
Trace; c0175d25 <reiserfs_create+85/160>
Trace; c013b4a3 <vfs_create+73/b0>
Trace; c013b62c <open_namei+14c/510>
Trace; c013122a <filp_open+3a/60>
Trace; c0131576 <sys_open+36/90>
Trace; c010897f <system_call+33/38>

Code;  c0117cb1 <exit_notify+41/270>
00000000 <_EIP>:
Code;  c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D
   0:   39 bb 94 00 00 00         cmp    %edi,0x94(%ebx)   <=3D=3D=3D=3D=3D
Code;  c0117cb7 <exit_notify+47/270>
   6:   75 37                     jne    3f <_EIP+0x3f> c0117cf0 <exit_noti=
fy+80/270>
Code;  c0117cb9 <exit_notify+49/270>
   8:   c7 43 6c 11 00 00 00      movl   $0x11,0x6c(%ebx)
Code;  c0117cc0 <exit_notify+50/270>
   f:   ff 83 94 05 00 00         incl   0x594(%ebx)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9fcc0a8   ebx: 00000000   ecx: 00000000   edx: cffe4000
esi: cffe4000   edi: c9fcc000   ebp: c9fcd670   esp: c9fcd664
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 607, stackpage=3Dc9fcd000)
Stack: 00000000 c9fcd758 c9fcc000 c9fcd684 c01180f6 00000000 c9fcd758 c0111=
e20=20
       c9fcd698 c0108f66 0000000b 00000000 00000000 c9fcd748 c01121a3 c0229=
a5e=20
       c9fcd758 00000000 c9fcc000 00000000 c0111e20 c02b5800 c0263862 00000=
094=20
Call Trace:    [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c01ddfa5>] [<c0108a70>] [<c0117cb1>] [<c01180f6>] [<c0111e20>] [<c0108f=
66>]
  [<c01121a3>] [<c0111e20>] [<c012c3ae>] [<c012c7d5>] [<c01217b2>] [<c0108a=
70>]
  [<c012408c>] [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121=
a3>]
  [<c0111e20>] [<c011c60b>] [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e=
8d>]
  [<c0108a70>] [<c0220b64>] [<c0182d8f>] [<c018335c>] [<c01835ec>] [<c01836=
57>]
  [<c0172d90>] [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868=
ed>]
  [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c01312=
2a>]
  [<c0131576>] [<c010897f>]
Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20


>>EIP; c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D

>>eax; c9fcc0a8 <_end+9cec9b0/10618968>
>>edx; cffe4000 <_end+fd04908/10618968>
>>esi; cffe4000 <_end+fd04908/10618968>
>>edi; c9fcc000 <_end+9cec908/10618968>
>>ebp; c9fcd670 <_end+9cedf78/10618968>
>>esp; c9fcd664 <_end+9cedf6c/10618968>

Trace; c01180f6 <do_exit+216/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c01ddfa5 <cursor_timer_handler+25/30>
Trace; c0108a70 <error_code+34/3c>
Trace; c0117cb1 <exit_notify+41/270>
Trace; c01180f6 <do_exit+216/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c012c3ae <__free_pages+1e/30>
Trace; c012c7d5 <free_page_and_swap_cache+35/40>
Trace; c01217b2 <__free_pte+42/50>
Trace; c0108a70 <error_code+34/3c>
Trace; c012408c <exit_mmap+8c/120>
Trace; c0113d0b <mmput+3b/60>
Trace; c0117f62 <do_exit+82/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c011c60b <timer_bh+23b/360>
Trace; c011964c <bh_action+1c/50>
Trace; c0119569 <tasklet_hi_action+49/70>
Trace; c011934b <do_softirq+4b/a0>
Trace; c0109e8d <do_IRQ+9d/b0>
Trace; c0108a70 <error_code+34/3c>
Trace; c0220b64 <_mmx_memcpy+c4/160>
Trace; c0182d8f <leaf_copy_items_entirely+1cf/250>
Trace; c018335c <leaf_copy_items+5c/120>
Trace; c01835ec <leaf_move_items+3c/80>
Trace; c0183657 <leaf_shift_left+27/90>
Trace; c0172d90 <balance_leaf+2a0/20e0>
Trace; c017da09 <dc_check_balance_internal+289/4d0>
Trace; c017e1d2 <clear_all_dirty_bits+12/20>
Trace; c017e337 <wait_tb_buffers_until_unlocked+157/310>
Trace; c0174f70 <do_balance+80/100>
Trace; c01868ed <search_by_key+97d/eb0>
Trace; c0188e2f <reiserfs_insert_item+8f/e0>
Trace; c0179c28 <reiserfs_new_inode+3e8/4b0>
Trace; c0175d25 <reiserfs_create+85/160>
Trace; c013b4a3 <vfs_create+73/b0>
Trace; c013b62c <open_namei+14c/510>
Trace; c013122a <filp_open+3a/60>
Trace; c0131576 <sys_open+36/90>
Trace; c010897f <system_call+33/38>

Code;  c0117cb1 <exit_notify+41/270>
00000000 <_EIP>:
Code;  c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D
   0:   39 bb 94 00 00 00         cmp    %edi,0x94(%ebx)   <=3D=3D=3D=3D=3D
Code;  c0117cb7 <exit_notify+47/270>
   6:   75 37                     jne    3f <_EIP+0x3f> c0117cf0 <exit_noti=
fy+80/270>
Code;  c0117cb9 <exit_notify+49/270>
   8:   c7 43 6c 11 00 00 00      movl   $0x11,0x6c(%ebx)
Code;  c0117cc0 <exit_notify+50/270>
   f:   ff 83 94 05 00 00         incl   0x594(%ebx)


1 warning issued.  Results may not be reliable.

--=-IpxFohRu5UNydibvIiyw
Content-Disposition: attachment; filename=crash
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=crash; charset=UTF-8

Unable to handle kernel paging request at virtual address d0000000
 printing eip:
c0220b64
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0220b64>]    Not tainted
EFLAGS: 00010202
eax: 00000014   ebx: 03f79a97   ecx: cde79647   edx: 80050033
esi: cc094a2c   edi: cfffffc7   ebp: c9fcda08   esp: c9fcd9f8
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 607, stackpage=3Dc9fcd000)
Stack: 0000f647 00000001 cde79647 cde79647 c9fcda58 c0182d8f cfffffc7 c9f0e=
0ac=20
       ffff0f54 00000001 c9fcdac4 00000000 ffff0f54 00000018 00100001 00000=
002=20
       00000010 00000001 cde6a000 0000059b 0000000f 00000403 0000000f cde87=
c8c=20
Call Trace:    [<c0182d8f>] [<c018335c>] [<c01835ec>] [<c0183657>] [<c0172d=
90>]
  [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868ed>] [<c0188e=
2f>]
  [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c013122a>] [<c01315=
76>]
  [<c010897f>]

Code: 0f 7f 5f 38 83 c6 40 83 c7 40 89 7d 08 4b 83 fb 05 7f a9 eb=20
 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00114
 printing eip:
c012408c
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012408c>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: ca772eac   ecx: c12c6148   edx: c12c6148
esi: cbe25814   edi: 40000000   ebp: c9fcd8c8   esp: c9fcd8b4
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 607, stackpage=3Dc9fcd000)
Stack: cbe25814 c9fcd9c4 c9fcc000 00012000 ca772e60 c9fcd8d8 c0113d0b cbe25=
814=20
       cbe25814 c9fcd8f0 c0117f62 cbe25814 00000002 c9fcd9c4 c0111e20 c9fcd=
904=20
       c0108f66 0000000b 00000000 00000002 c9fcd9b4 c01121a3 c0229a5e c9fcd=
9c4=20
Call Trace:    [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121=
a3>]
  [<c0111e20>] [<c011c60b>] [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e=
8d>]
  [<c0108a70>] [<c0220b64>] [<c0182d8f>] [<c018335c>] [<c01835ec>] [<c01836=
57>]
  [<c0172d90>] [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868=
ed>]
  [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c01312=
2a>]
  [<c0131576>] [<c010897f>]

Code: ff 80 14 01 00 00 8b 53 28 85 d2 74 06 8b 43 2c 89 42 2c 8b=20
 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
 printing eip:
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9fcc0a8   ebx: 00000000   ecx: c12c7e98   edx: cffe4000
esi: cffe4000   edi: c9fcc000   ebp: c9fcd798   esp: c9fcd78c
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 607, stackpage=3Dc9fcd000)
Stack: cffee1ec c9fcd880 c9fcc000 c9fcd7ac c01180f6 00000002 c9fcd880 c0111=
e20=20
       c9fcd7c0 c0108f66 0000000b 00000000 00000002 c9fcd870 c01121a3 c0229=
a5e=20
       c9fcd880 00000002 c9fcc000 00000002 c0111e20 62613938 66656463 00000=
114=20
Call Trace:    [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c012c3ae>] [<c012c7d5>] [<c01217b2>] [<c0108a70>] [<c012408c>] [<c0113d=
0b>]
  [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e20>] [<c011c6=
0b>]
  [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e8d>] [<c0108a70>] [<c0220b=
64>]
  [<c0182d8f>] [<c018335c>] [<c01835ec>] [<c0183657>] [<c0172d90>] [<c017da=
09>]
  [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868ed>] [<c0188e2f>] [<c0179c=
28>]
  [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c013122a>] [<c0131576>] [<c01089=
7f>]

Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20
 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
 printing eip:
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9fcc0a8   ebx: 00000000   ecx: 00000000   edx: cffe4000
esi: cffe4000   edi: c9fcc000   ebp: c9fcd670   esp: c9fcd664
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 607, stackpage=3Dc9fcd000)
Stack: 00000000 c9fcd758 c9fcc000 c9fcd684 c01180f6 00000000 c9fcd758 c0111=
e20=20
       c9fcd698 c0108f66 0000000b 00000000 00000000 c9fcd748 c01121a3 c0229=
a5e=20
       c9fcd758 00000000 c9fcc000 00000000 c0111e20 c02b5800 c0263862 00000=
094=20
Call Trace:    [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c01ddfa5>] [<c0108a70>] [<c0117cb1>] [<c01180f6>] [<c0111e20>] [<c0108f=
66>]
  [<c01121a3>] [<c0111e20>] [<c012c3ae>] [<c012c7d5>] [<c01217b2>] [<c0108a=
70>]
  [<c012408c>] [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121=
a3>]
  [<c0111e20>] [<c011c60b>] [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e=
8d>]
  [<c0108a70>] [<c0220b64>] [<c0182d8f>] [<c018335c>] [<c01835ec>] [<c01836=
57>]
  [<c0172d90>] [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868=
ed>]
  [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c01312=
2a>]
  [<c0131576>] [<c010897f>]

Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20

--=-IpxFohRu5UNydibvIiyw
Content-Disposition: attachment; filename=crash2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=crash2; charset=UTF-8

Unable to handle kernel paging request at virtual address d0000000
 printing eip:
c01838f6
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01838f6>]    Not tainted
EFLAGS: 00010283
eax: 00000020   ebx: ce10b1c8   ecx: fe110f68   edx: 0000ff86
esi: d0000000   edi: cfffffe0   ebp: c9a75af4   esp: c9a75acc
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: 00000000 0000000f c9a75e18 ce10d194 00000a26 00005f68 ce10b000 0000f=
447=20
       00000a38 ce10d194 c9a75bc8 c0172dcf c9a75bb8 00000012 c9a75e44 c9a75=
e18=20
       00000000 c9a75c50 00000000 c9a75c50 00000004 ffffffff c9a75bfc c9a75=
bf4=20
Call Trace:    [<c0172dcf>] [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f=
70>]
  [<c01868ed>] [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b6=
2c>]
  [<c013122a>] [<c0131576>] [<c010897f>]

Code: f3 a4 eb 11 8d b6 00 00 00 00 8d 41 ff 01 c6 01 c7 fd f3 a4=20
 kernel BUG at file.c:32!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c017ab6b>]    Not tainted
EFLAGS: 00010a87
eax: 00000000   ebx: ca18a284   ecx: 40400000   edx: cffea8a0
esi: cffea8a0   edi: cffef368   ebp: c9a75960   esp: c9a75920
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: ca18a284 cffea8a0 cffef368 00001000 c9a75974 c0121bc2 099f1065 ca249=
e60=20
       cc14d814 40012000 c9a76404 40412000 c9a76404 40412000 00000001 ca18a=
284=20
       c9a75980 c01326e4 cffea8a0 ca18a284 ca249e60 cc14d814 40012000 cffea=
878=20
Call Trace:    [<c0121bc2>] [<c01326e4>] [<c01240ca>] [<c0113d0b>] [<c0117f=
62>]
  [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e20>] [<c011c1dd>] [<c011c3=
f6>]
  [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e8d>] [<c0108a70>] [<c01838=
f6>]
  [<c0172dcf>] [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868=
ed>]
  [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c01312=
2a>]
  [<c0131576>] [<c010897f>]

Code: 0f 0b 20 00 38 76 23 c0 8b 4d 08 8b 41 2c 83 f8 01 0f 8f 3a=20
 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
 printing eip:
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9a740a8   ebx: 00000000   ecx: c12c7e98   edx: cffe4000
esi: cffe4000   edi: c9a74000   ebp: c9a75818   esp: c9a7580c
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: cffee1ec c9a758ec c9a74000 c9a7582c c01180f6 00000000 c9a758ec c0109=
190=20
       c9a75840 c0108f66 0000000b c9a758ec 00000000 c9a758dc c010920c c0225=
aab=20
       c9a758ec 00000000 c9a74000 00000000 00000004 00000000 00030002 c017a=
b6b=20
Call Trace:    [<c01180f6>] [<c0109190>] [<c0108f66>] [<c010920c>] [<c017ab=
6b>]
  [<c012ade8>] [<c0108a70>] [<c017ab6b>] [<c0121bc2>] [<c01326e4>] [<c01240=
ca>]
  [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c011c1dd>] [<c011c3f6>] [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e=
8d>]
  [<c0108a70>] [<c01838f6>] [<c0172dcf>] [<c017da09>] [<c017e1d2>] [<c017e3=
37>]
  [<c0174f70>] [<c01868ed>] [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4=
a3>]
  [<c013b62c>] [<c013122a>] [<c0131576>] [<c010897f>]

Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20
 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
 printing eip:
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9a740a8   ebx: 00000000   ecx: 00000000   edx: cffe4000
esi: cffe4000   edi: c9a74000   ebp: c9a756f0   esp: c9a756e4
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: 00000000 c9a757d8 c9a74000 c9a75704 c01180f6 00000000 c9a757d8 c0111=
e20=20
       c9a75718 c0108f66 0000000b 00000000 00000000 c9a757c8 c01121a3 c0229=
a5e=20
       c9a757d8 00000000 c9a74000 00000000 c0111e20 c02b5700 c0263361 00000=
094=20
Call Trace:    [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c01ddfa5>] [<c0108a70>] [<c0117cb1>] [<c01180f6>] [<c0109190>] [<c0108f=
66>]
  [<c010920c>] [<c017ab6b>] [<c012ade8>] [<c0108a70>] [<c017ab6b>] [<c0121b=
c2>]
  [<c01326e4>] [<c01240ca>] [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f=
66>]
  [<c01121a3>] [<c0111e20>] [<c011c1dd>] [<c011c3f6>] [<c011964c>] [<c01195=
69>]
  [<c011934b>] [<c0109e8d>] [<c0108a70>] [<c01838f6>] [<c0172dcf>] [<c017da=
09>]
  [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868ed>] [<c0188e2f>] [<c0179c=
28>]
  [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c013122a>] [<c0131576>] [<c01089=
7f>]

Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20
 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
 printing eip:
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9a740a8   ebx: 00000000   ecx: 00000000   edx: cffe4000
esi: cffe4000   edi: c9a74000   ebp: c9a755c8   esp: c9a755bc
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: 00000000 c9a756b0 c9a74000 c9a755dc c01180f6 00000000 c9a756b0 c0111=
e20=20
       c9a755f0 c0108f66 0000000b 00000000 00000000 c9a756a0 c01121a3 c0229=
a5e=20
       c9a756b0 00000000 c9a74000 00000000 c0111e20 c02b5d00 c0263930 00000=
094=20
Call Trace:    [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c011c1dd>] [<c011c3f6>] [<c011964c>] [<c0119569>] [<c0108a70>] [<c0117c=
b1>]
  [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e20>] [<c01ddf=
a5>]
  [<c0108a70>] [<c0117cb1>] [<c01180f6>] [<c0109190>] [<c0108f66>] [<c01092=
0c>]
  [<c017ab6b>] [<c012ade8>] [<c0108a70>] [<c017ab6b>] [<c0121bc2>] [<c01326=
e4>]
  [<c01240ca>] [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121=
a3>]
  [<c0111e20>] [<c011c1dd>] [<c011c3f6>] [<c011964c>] [<c0119569>] [<c01193=
4b>]
  [<c0109e8d>] [<c0108a70>] [<c01838f6>] [<c0172dcf>] [<c017da09>] [<c017e1=
d2>]
  [<c017e337>] [<c0174f70>] [<c01868ed>] [<c0188e2f>] [<c0179c28>] [<c0175d=
25>]
  [<c013b4a3>] [<c013b62c>] [<c013122a>] [<c0131576>] [<c010897f>]

Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20
 <1>Unable to

--=-IpxFohRu5UNydibvIiyw
Content-Disposition: attachment; filename=crash2.ksymoops
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=crash2.ksymoops; charset=UTF-8

ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address d0000000
c01838f6
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01838f6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: 00000020   ebx: ce10b1c8   ecx: fe110f68   edx: 0000ff86
esi: d0000000   edi: cfffffe0   ebp: c9a75af4   esp: c9a75acc
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: 00000000 0000000f c9a75e18 ce10d194 00000a26 00005f68 ce10b000 0000f=
447=20
       00000a38 ce10d194 c9a75bc8 c0172dcf c9a75bb8 00000012 c9a75e44 c9a75=
e18=20
       00000000 c9a75c50 00000000 c9a75c50 00000004 ffffffff c9a75bfc c9a75=
bf4=20
Call Trace:    [<c0172dcf>] [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f=
70>]
  [<c01868ed>] [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b6=
2c>]
  [<c013122a>] [<c0131576>] [<c010897f>]
Code: f3 a4 eb 11 8d b6 00 00 00 00 8d 41 ff 01 c6 01 c7 fd f3 a4=20


>>EIP; c01838f6 <leaf_insert_into_buf+96/230>   <=3D=3D=3D=3D=3D

>>ebx; ce10b1c8 <_end+de2bad0/10618968>
>>esi; d0000000 <_end+fd20908/10618968>
>>edi; cfffffe0 <_end+fd208e8/10618968>
>>ebp; c9a75af4 <_end+97963fc/10618968>
>>esp; c9a75acc <_end+97963d4/10618968>

Trace; c0172dcf <balance_leaf+2df/20e0>
Trace; c017da09 <dc_check_balance_internal+289/4d0>
Trace; c017e1d2 <clear_all_dirty_bits+12/20>
Trace; c017e337 <wait_tb_buffers_until_unlocked+157/310>
Trace; c0174f70 <do_balance+80/100>
Trace; c01868ed <search_by_key+97d/eb0>
Trace; c0188e2f <reiserfs_insert_item+8f/e0>
Trace; c0179c28 <reiserfs_new_inode+3e8/4b0>
Trace; c0175d25 <reiserfs_create+85/160>
Trace; c013b4a3 <vfs_create+73/b0>
Trace; c013b62c <open_namei+14c/510>
Trace; c013122a <filp_open+3a/60>
Trace; c0131576 <sys_open+36/90>
Trace; c010897f <system_call+33/38>

Code;  c01838f6 <leaf_insert_into_buf+96/230>
00000000 <_EIP>:
Code;  c01838f6 <leaf_insert_into_buf+96/230>   <=3D=3D=3D=3D=3D
   0:   f3 a4                     repz movsb %ds:(%esi),%es:(%edi)   <=3D=
=3D=3D=3D=3D
Code;  c01838f8 <leaf_insert_into_buf+98/230>
   2:   eb 11                     jmp    15 <_EIP+0x15> c018390b <leaf_inse=
rt_into_buf+ab/230>
Code;  c01838fa <leaf_insert_into_buf+9a/230>
   4:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c0183900 <leaf_insert_into_buf+a0/230>
   a:   8d 41 ff                  lea    0xffffffff(%ecx),%eax
Code;  c0183903 <leaf_insert_into_buf+a3/230>
   d:   01 c6                     add    %eax,%esi
Code;  c0183905 <leaf_insert_into_buf+a5/230>
   f:   01 c7                     add    %eax,%edi
Code;  c0183907 <leaf_insert_into_buf+a7/230>
  11:   fd                        std   =20
Code;  c0183908 <leaf_insert_into_buf+a8/230>
  12:   f3 a4                     repz movsb %ds:(%esi),%es:(%edi)

 kernel BUG at file.c:32!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c017ab6b>]    Not tainted
EFLAGS: 00010a87
eax: 00000000   ebx: ca18a284   ecx: 40400000   edx: cffea8a0
esi: cffea8a0   edi: cffef368   ebp: c9a75960   esp: c9a75920
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: ca18a284 cffea8a0 cffef368 00001000 c9a75974 c0121bc2 099f1065 ca249=
e60=20
       cc14d814 40012000 c9a76404 40412000 c9a76404 40412000 00000001 ca18a=
284=20
       c9a75980 c01326e4 cffea8a0 ca18a284 ca249e60 cc14d814 40012000 cffea=
878=20
Call Trace:    [<c0121bc2>] [<c01326e4>] [<c01240ca>] [<c0113d0b>] [<c0117f=
62>]
  [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e20>] [<c011c1dd>] [<c011c3=
f6>]
  [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e8d>] [<c0108a70>] [<c01838=
f6>]
  [<c0172dcf>] [<c017da09>] [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868=
ed>]
  [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c01312=
2a>]
  [<c0131576>] [<c010897f>]
Code: 0f 0b 20 00 38 76 23 c0 8b 4d 08 8b 41 2c 83 f8 01 0f 8f 3a=20


>>EIP; c017ab6b <reiserfs_file_release+1b/360>   <=3D=3D=3D=3D=3D

>>ebx; ca18a284 <_end+9eaab8c/10618968>
>>edx; cffea8a0 <_end+fd0b1a8/10618968>
>>esi; cffea8a0 <_end+fd0b1a8/10618968>
>>edi; cffef368 <_end+fd0fc70/10618968>
>>ebp; c9a75960 <_end+9796268/10618968>
>>esp; c9a75920 <_end+9796228/10618968>

Trace; c0121bc2 <zap_page_range+182/230>
Trace; c01326e4 <fput+54/e0>
Trace; c01240ca <exit_mmap+ca/120>
Trace; c0113d0b <mmput+3b/60>
Trace; c0117f62 <do_exit+82/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c011c1dd <update_wall_time+d/40>
Trace; c011c3f6 <timer_bh+26/360>
Trace; c011964c <bh_action+1c/50>
Trace; c0119569 <tasklet_hi_action+49/70>
Trace; c011934b <do_softirq+4b/a0>
Trace; c0109e8d <do_IRQ+9d/b0>
Trace; c0108a70 <error_code+34/3c>
Trace; c01838f6 <leaf_insert_into_buf+96/230>
Trace; c0172dcf <balance_leaf+2df/20e0>
Trace; c017da09 <dc_check_balance_internal+289/4d0>
Trace; c017e1d2 <clear_all_dirty_bits+12/20>
Trace; c017e337 <wait_tb_buffers_until_unlocked+157/310>
Trace; c0174f70 <do_balance+80/100>
Trace; c01868ed <search_by_key+97d/eb0>
Trace; c0188e2f <reiserfs_insert_item+8f/e0>
Trace; c0179c28 <reiserfs_new_inode+3e8/4b0>
Trace; c0175d25 <reiserfs_create+85/160>
Trace; c013b4a3 <vfs_create+73/b0>
Trace; c013b62c <open_namei+14c/510>
Trace; c013122a <filp_open+3a/60>
Trace; c0131576 <sys_open+36/90>
Trace; c010897f <system_call+33/38>

Code;  c017ab6b <reiserfs_file_release+1b/360>
00000000 <_EIP>:
Code;  c017ab6b <reiserfs_file_release+1b/360>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c017ab6d <reiserfs_file_release+1d/360>
   2:   20 00                     and    %al,(%eax)
Code;  c017ab6f <reiserfs_file_release+1f/360>
   4:   38 76 23                  cmp    %dh,0x23(%esi)
Code;  c017ab72 <reiserfs_file_release+22/360>
   7:   c0 8b 4d 08 8b 41 2c      rorb   $0x2c,0x418b084d(%ebx)
Code;  c017ab79 <reiserfs_file_release+29/360>
   e:   83 f8 01                  cmp    $0x1,%eax
Code;  c017ab7c <reiserfs_file_release+2c/360>
  11:   0f 8f 3a 00 00 00         jg     51 <_EIP+0x51> c017abbc <reiserfs_=
file_release+6c/360>

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9a740a8   ebx: 00000000   ecx: c12c7e98   edx: cffe4000
esi: cffe4000   edi: c9a74000   ebp: c9a75818   esp: c9a7580c
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: cffee1ec c9a758ec c9a74000 c9a7582c c01180f6 00000000 c9a758ec c0109=
190=20
       c9a75840 c0108f66 0000000b c9a758ec 00000000 c9a758dc c010920c c0225=
aab=20
       c9a758ec 00000000 c9a74000 00000000 00000004 00000000 00030002 c017a=
b6b=20
Call Trace:    [<c01180f6>] [<c0109190>] [<c0108f66>] [<c010920c>] [<c017ab=
6b>]
  [<c012ade8>] [<c0108a70>] [<c017ab6b>] [<c0121bc2>] [<c01326e4>] [<c01240=
ca>]
  [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c011c1dd>] [<c011c3f6>] [<c011964c>] [<c0119569>] [<c011934b>] [<c0109e=
8d>]
  [<c0108a70>] [<c01838f6>] [<c0172dcf>] [<c017da09>] [<c017e1d2>] [<c017e3=
37>]
  [<c0174f70>] [<c01868ed>] [<c0188e2f>] [<c0179c28>] [<c0175d25>] [<c013b4=
a3>]
  [<c013b62c>] [<c013122a>] [<c0131576>] [<c010897f>]
Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20


>>EIP; c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D

>>eax; c9a740a8 <_end+97949b0/10618968>
>>ecx; c12c7e98 <_end+fe87a0/10618968>
>>edx; cffe4000 <_end+fd04908/10618968>
>>esi; cffe4000 <_end+fd04908/10618968>
>>edi; c9a74000 <_end+9794908/10618968>
>>ebp; c9a75818 <_end+9796120/10618968>
>>esp; c9a7580c <_end+9796114/10618968>

Trace; c01180f6 <do_exit+216/230>
Trace; c0109190 <do_invalid_op+0/90>
Trace; c0108f66 <die+56/60>
Trace; c010920c <do_invalid_op+7c/90>
Trace; c017ab6b <reiserfs_file_release+1b/360>
Trace; c012ade8 <lru_cache_del+8/10>
Trace; c0108a70 <error_code+34/3c>
Trace; c017ab6b <reiserfs_file_release+1b/360>
Trace; c0121bc2 <zap_page_range+182/230>
Trace; c01326e4 <fput+54/e0>
Trace; c01240ca <exit_mmap+ca/120>
Trace; c0113d0b <mmput+3b/60>
Trace; c0117f62 <do_exit+82/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c011c1dd <update_wall_time+d/40>
Trace; c011c3f6 <timer_bh+26/360>
Trace; c011964c <bh_action+1c/50>
Trace; c0119569 <tasklet_hi_action+49/70>
Trace; c011934b <do_softirq+4b/a0>
Trace; c0109e8d <do_IRQ+9d/b0>
Trace; c0108a70 <error_code+34/3c>
Trace; c01838f6 <leaf_insert_into_buf+96/230>
Trace; c0172dcf <balance_leaf+2df/20e0>
Trace; c017da09 <dc_check_balance_internal+289/4d0>
Trace; c017e1d2 <clear_all_dirty_bits+12/20>
Trace; c017e337 <wait_tb_buffers_until_unlocked+157/310>
Trace; c0174f70 <do_balance+80/100>
Trace; c01868ed <search_by_key+97d/eb0>
Trace; c0188e2f <reiserfs_insert_item+8f/e0>
Trace; c0179c28 <reiserfs_new_inode+3e8/4b0>
Trace; c0175d25 <reiserfs_create+85/160>
Trace; c013b4a3 <vfs_create+73/b0>
Trace; c013b62c <open_namei+14c/510>
Trace; c013122a <filp_open+3a/60>
Trace; c0131576 <sys_open+36/90>
Trace; c010897f <system_call+33/38>

Code;  c0117cb1 <exit_notify+41/270>
00000000 <_EIP>:
Code;  c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D
   0:   39 bb 94 00 00 00         cmp    %edi,0x94(%ebx)   <=3D=3D=3D=3D=3D
Code;  c0117cb7 <exit_notify+47/270>
   6:   75 37                     jne    3f <_EIP+0x3f> c0117cf0 <exit_noti=
fy+80/270>
Code;  c0117cb9 <exit_notify+49/270>
   8:   c7 43 6c 11 00 00 00      movl   $0x11,0x6c(%ebx)
Code;  c0117cc0 <exit_notify+50/270>
   f:   ff 83 94 05 00 00         incl   0x594(%ebx)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9a740a8   ebx: 00000000   ecx: 00000000   edx: cffe4000
esi: cffe4000   edi: c9a74000   ebp: c9a756f0   esp: c9a756e4
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: 00000000 c9a757d8 c9a74000 c9a75704 c01180f6 00000000 c9a757d8 c0111=
e20=20
       c9a75718 c0108f66 0000000b 00000000 00000000 c9a757c8 c01121a3 c0229=
a5e=20
       c9a757d8 00000000 c9a74000 00000000 c0111e20 c02b5700 c0263361 00000=
094=20
Call Trace:    [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c01ddfa5>] [<c0108a70>] [<c0117cb1>] [<c01180f6>] [<c0109190>] [<c0108f=
66>]
  [<c010920c>] [<c017ab6b>] [<c012ade8>] [<c0108a70>] [<c017ab6b>] [<c0121b=
c2>]
  [<c01326e4>] [<c01240ca>] [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f=
66>]
  [<c01121a3>] [<c0111e20>] [<c011c1dd>] [<c011c3f6>] [<c011964c>] [<c01195=
69>]
  [<c011934b>] [<c0109e8d>] [<c0108a70>] [<c01838f6>] [<c0172dcf>] [<c017da=
09>]
  [<c017e1d2>] [<c017e337>] [<c0174f70>] [<c01868ed>] [<c0188e2f>] [<c0179c=
28>]
  [<c0175d25>] [<c013b4a3>] [<c013b62c>] [<c013122a>] [<c0131576>] [<c01089=
7f>]
Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20


>>EIP; c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D

>>eax; c9a740a8 <_end+97949b0/10618968>
>>edx; cffe4000 <_end+fd04908/10618968>
>>esi; cffe4000 <_end+fd04908/10618968>
>>edi; c9a74000 <_end+9794908/10618968>
>>ebp; c9a756f0 <_end+9795ff8/10618968>
>>esp; c9a756e4 <_end+9795fec/10618968>

Trace; c01180f6 <do_exit+216/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c01ddfa5 <cursor_timer_handler+25/30>
Trace; c0108a70 <error_code+34/3c>
Trace; c0117cb1 <exit_notify+41/270>
Trace; c01180f6 <do_exit+216/230>
Trace; c0109190 <do_invalid_op+0/90>
Trace; c0108f66 <die+56/60>
Trace; c010920c <do_invalid_op+7c/90>
Trace; c017ab6b <reiserfs_file_release+1b/360>
Trace; c012ade8 <lru_cache_del+8/10>
Trace; c0108a70 <error_code+34/3c>
Trace; c017ab6b <reiserfs_file_release+1b/360>
Trace; c0121bc2 <zap_page_range+182/230>
Trace; c01326e4 <fput+54/e0>
Trace; c01240ca <exit_mmap+ca/120>
Trace; c0113d0b <mmput+3b/60>
Trace; c0117f62 <do_exit+82/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c011c1dd <update_wall_time+d/40>
Trace; c011c3f6 <timer_bh+26/360>
Trace; c011964c <bh_action+1c/50>
Trace; c0119569 <tasklet_hi_action+49/70>
Trace; c011934b <do_softirq+4b/a0>
Trace; c0109e8d <do_IRQ+9d/b0>
Trace; c0108a70 <error_code+34/3c>
Trace; c01838f6 <leaf_insert_into_buf+96/230>
Trace; c0172dcf <balance_leaf+2df/20e0>
Trace; c017da09 <dc_check_balance_internal+289/4d0>
Trace; c017e1d2 <clear_all_dirty_bits+12/20>
Trace; c017e337 <wait_tb_buffers_until_unlocked+157/310>
Trace; c0174f70 <do_balance+80/100>
Trace; c01868ed <search_by_key+97d/eb0>
Trace; c0188e2f <reiserfs_insert_item+8f/e0>
Trace; c0179c28 <reiserfs_new_inode+3e8/4b0>
Trace; c0175d25 <reiserfs_create+85/160>
Trace; c013b4a3 <vfs_create+73/b0>
Trace; c013b62c <open_namei+14c/510>
Trace; c013122a <filp_open+3a/60>
Trace; c0131576 <sys_open+36/90>
Trace; c010897f <system_call+33/38>

Code;  c0117cb1 <exit_notify+41/270>
00000000 <_EIP>:
Code;  c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D
   0:   39 bb 94 00 00 00         cmp    %edi,0x94(%ebx)   <=3D=3D=3D=3D=3D
Code;  c0117cb7 <exit_notify+47/270>
   6:   75 37                     jne    3f <_EIP+0x3f> c0117cf0 <exit_noti=
fy+80/270>
Code;  c0117cb9 <exit_notify+49/270>
   8:   c7 43 6c 11 00 00 00      movl   $0x11,0x6c(%ebx)
Code;  c0117cc0 <exit_notify+50/270>
   f:   ff 83 94 05 00 00         incl   0x594(%ebx)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 000=
00094
c0117cb1
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117cb1>]    Not tainted
EFLAGS: 00010207
eax: c9a740a8   ebx: 00000000   ecx: 00000000   edx: cffe4000
esi: cffe4000   edi: c9a74000   ebp: c9a755c8   esp: c9a755bc
ds: 0018   es: 0018   ss: 0018
Process apt-extracttemp (pid: 596, stackpage=3Dc9a75000)
Stack: 00000000 c9a756b0 c9a74000 c9a755dc c01180f6 00000000 c9a756b0 c0111=
e20=20
       c9a755f0 c0108f66 0000000b 00000000 00000000 c9a756a0 c01121a3 c0229=
a5e=20
       c9a756b0 00000000 c9a74000 00000000 c0111e20 c02b5d00 c0263930 00000=
094=20
Call Trace:    [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e=
20>]
  [<c011c1dd>] [<c011c3f6>] [<c011964c>] [<c0119569>] [<c0108a70>] [<c0117c=
b1>]
  [<c01180f6>] [<c0111e20>] [<c0108f66>] [<c01121a3>] [<c0111e20>] [<c01ddf=
a5>]
  [<c0108a70>] [<c0117cb1>] [<c01180f6>] [<c0109190>] [<c0108f66>] [<c01092=
0c>]
  [<c017ab6b>] [<c012ade8>] [<c0108a70>] [<c017ab6b>] [<c0121bc2>] [<c01326=
e4>]
  [<c01240ca>] [<c0113d0b>] [<c0117f62>] [<c0111e20>] [<c0108f66>] [<c01121=
a3>]
  [<c0111e20>] [<c011c1dd>] [<c011c3f6>] [<c011964c>] [<c0119569>] [<c01193=
4b>]
  [<c0109e8d>] [<c0108a70>] [<c01838f6>] [<c0172dcf>] [<c017da09>] [<c017e1=
d2>]
  [<c017e337>] [<c0174f70>] [<c01868ed>] [<c0188e2f>] [<c0179c28>] [<c0175d=
25>]
  [<c013b4a3>] [<c013b62c>] [<c013122a>] [<c0131576>] [<c010897f>]
Code: 39 bb 94 00 00 00 75 37 c7 43 6c 11 00 00 00 ff 83 94 05 00=20


>>EIP; c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D

>>eax; c9a740a8 <_end+97949b0/10618968>
>>edx; cffe4000 <_end+fd04908/10618968>
>>esi; cffe4000 <_end+fd04908/10618968>
>>edi; c9a74000 <_end+9794908/10618968>
>>ebp; c9a755c8 <_end+9795ed0/10618968>
>>esp; c9a755bc <_end+9795ec4/10618968>

Trace; c01180f6 <do_exit+216/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c011c1dd <update_wall_time+d/40>
Trace; c011c3f6 <timer_bh+26/360>
Trace; c011964c <bh_action+1c/50>
Trace; c0119569 <tasklet_hi_action+49/70>
Trace; c0108a70 <error_code+34/3c>
Trace; c0117cb1 <exit_notify+41/270>
Trace; c01180f6 <do_exit+216/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c01ddfa5 <cursor_timer_handler+25/30>
Trace; c0108a70 <error_code+34/3c>
Trace; c0117cb1 <exit_notify+41/270>
Trace; c01180f6 <do_exit+216/230>
Trace; c0109190 <do_invalid_op+0/90>
Trace; c0108f66 <die+56/60>
Trace; c010920c <do_invalid_op+7c/90>
Trace; c017ab6b <reiserfs_file_release+1b/360>
Trace; c012ade8 <lru_cache_del+8/10>
Trace; c0108a70 <error_code+34/3c>
Trace; c017ab6b <reiserfs_file_release+1b/360>
Trace; c0121bc2 <zap_page_range+182/230>
Trace; c01326e4 <fput+54/e0>
Trace; c01240ca <exit_mmap+ca/120>
Trace; c0113d0b <mmput+3b/60>
Trace; c0117f62 <do_exit+82/230>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c0108f66 <die+56/60>
Trace; c01121a3 <do_page_fault+383/4ce>
Trace; c0111e20 <do_page_fault+0/4ce>
Trace; c011c1dd <update_wall_time+d/40>
Trace; c011c3f6 <timer_bh+26/360>
Trace; c011964c <bh_action+1c/50>
Trace; c0119569 <tasklet_hi_action+49/70>
Trace; c011934b <do_softirq+4b/a0>
Trace; c0109e8d <do_IRQ+9d/b0>
Trace; c0108a70 <error_code+34/3c>
Trace; c01838f6 <leaf_insert_into_buf+96/230>
Trace; c0172dcf <balance_leaf+2df/20e0>
Trace; c017da09 <dc_check_balance_internal+289/4d0>
Trace; c017e1d2 <clear_all_dirty_bits+12/20>
Trace; c017e337 <wait_tb_buffers_until_unlocked+157/310>
Trace; c0174f70 <do_balance+80/100>
Trace; c01868ed <search_by_key+97d/eb0>
Trace; c0188e2f <reiserfs_insert_item+8f/e0>
Trace; c0179c28 <reiserfs_new_inode+3e8/4b0>
Trace; c0175d25 <reiserfs_create+85/160>
Trace; c013b4a3 <vfs_create+73/b0>
Trace; c013b62c <open_namei+14c/510>
Trace; c013122a <filp_open+3a/60>
Trace; c0131576 <sys_open+36/90>
Trace; c010897f <system_call+33/38>

Code;  c0117cb1 <exit_notify+41/270>
00000000 <_EIP>:
Code;  c0117cb1 <exit_notify+41/270>   <=3D=3D=3D=3D=3D
   0:   39 bb 94 00 00 00         cmp    %edi,0x94(%ebx)   <=3D=3D=3D=3D=3D
Code;  c0117cb7 <exit_notify+47/270>
   6:   75 37                     jne    3f <_EIP+0x3f> c0117cf0 <exit_noti=
fy+80/270>
Code;  c0117cb9 <exit_notify+49/270>
   8:   c7 43 6c 11 00 00 00      movl   $0x11,0x6c(%ebx)
Code;  c0117cc0 <exit_notify+50/270>
   f:   ff 83 94 05 00 00         incl   0x594(%ebx)


1 warning issued.  Results may not be reliable.

--=-IpxFohRu5UNydibvIiyw
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg; charset=UTF-8

Linux version 2.4.19 (root@castaway.home.sv) (gcc version 2.95.4 20011002 (=
Debian prerelease)) #3 Wed Oct 9 13:30:38 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=3Ddebug root=3D307 console=3DttyS0,115=
200
Initializing CPU#0
Detected 1002.307 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 256916k/262080k available (1170k kernel code, 4776k reserved, 298k =
data, 240k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor =3D 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb3f0, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
HPT370A: IDE controller on PCI bus 00 dev 70
PCI: Found IRQ 5 for device 00:0e.0
PCI: Sharing IRQ 5 with 00:09.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 34098H4, ATA DISK drive
ide0 at 0xb000-0xb007,0xb402 on irq 5
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=3D79408/16/63, UDMA(1=
00)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
PCI: Found IRQ 11 for device 00:0a.0
PCI: Sharing IRQ 11 with 00:07.5
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c905C Tornado at 0xac00. Vers LK1.1.16
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 03:07) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 31 transactions in 2 seconds
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 240k freed
Adding Swap: 393520k swap-space (priority -1)
reiserfs: Unrecognized mount option errors
reiserfs: Unrecognized mount option errors
8139too Fast Ethernet driver 0.9.25
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem Rev: 1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1/1.1.4.1 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 1.1.4.1
HiSax: Layer2 Revision 1.1.4.1
HiSax: TeiMgr Revision 1.1.4.1
HiSax: Layer3 Revision 1.1.4.1
HiSax: LinkLayer Revision 1.1.4.1
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=3DHiSax (0)
HiSax: AVM PCI driver Rev. 1.1.4.1
FritzPCI: No PCI card found
HiSax: Card AVM Fritz PnP/PCI not installed !
SCSI subsystem driver Revision: 1.00
parport0: PC-style at 0x378 [PCSPP,EPP]
parport_pc: Via 686A parallel port: io=3D0x378
lp0: using parport0 (polling).
Non-volatile memory driver v1.1
i2c-core.o: i2c core module
i2c-algo-pcf.o: i2c pcf8584 algorithm module
mice: PS/2 mouse device common for all mice
GRE over IPv4 tunneling driver
IPv4 over IPv4 tunneling driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
loop: loaded (max 8 devices)
PCI: Found IRQ 5 for device 00:09.0
PCI: Sharing IRQ 5 with 00:0e.0
(scsi0) <Adaptec AHA-294X SCSI host adapter> found at PCI 0/9/0
(scsi0) Narrow Channel, SCSI ID=3D7, 16/255 SCBs
(scsi0) Downloading sequencer code... 415 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
       <Adaptec AHA-294X SCSI host adapter>
  Vendor: TOSHIBA   Model: CD-ROM XM-5401TA  Rev: 3605
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:0:3:1) Synchronous at 4.0 Mbyte/sec, offset 15.
  Vendor: TEAC      Model: CD-R55S           Rev: 1.0L
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 5, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
(scsi0:0:5:0) Synchronous at 8.0 Mbyte/sec, offset 15.
sr1: scsi-1 drive
usb.c: registered new driver hub
cs46xx: Unable to detect valid cs46xx device
usb.c: registered new driver usb_mouse
usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
Via 686a audio driver 1.9.1
PCI: Found IRQ 11 for device 00:07.5
PCI: Sharing IRQ 11 with 00:0a.0
ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (ICE1232)
via82cxxx: board #1 at 0x9C00, IRQ 11
<MPU-401 (UART) MIDI> at 0x330 irq 11 dma 0,0
Enabled Via MIDI
matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xD4000000, mapped to 0xd0a44000, size 33554432
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 127
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
Terminating i2o threads...waiting...exiting...done.
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 129
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: registered device at major 80
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O LAN OSM (C) 1999 University of Helsinki.
isdnloop-ISDN-driver Rev 1.1.4.1=20
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
inserting floppy driver for 2.4.19
FDC 0 is a post-1991 82077
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: overridden by ACPI.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: overridden by ACPI.
eth0: Setting promiscuous mode.
device eth0 entered promiscuous mode

--=-IpxFohRu5UNydibvIiyw
Content-Disposition: attachment; filename=.config
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=.config; charset=UTF-8

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=3Dy
CONFIG_ISA=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=3Dy
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_X86_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_USE_3DNOW=3Dy
CONFIG_X86_PGE=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_MCE=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=3Dm
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_PM=3Dy
CONFIG_ACPI=3Dy
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUSMGR=3Dm
CONFIG_ACPI_SYS=3Dm
CONFIG_ACPI_CPU=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_EC=3Dm
CONFIG_ACPI_CMBATT=3Dm
CONFIG_ACPI_THERMAL=3Dm
CONFIG_APM=3Dm
CONFIG_APM_IGNORE_USER_SUSPEND=3Dy
CONFIG_APM_DO_ENABLE=3Dy
CONFIG_APM_CPU_IDLE=3Dy
CONFIG_APM_DISPLAY_BLANK=3Dy
CONFIG_APM_RTC_IS_GMT=3Dy
CONFIG_APM_ALLOW_INTS=3Dy
CONFIG_APM_REAL_MODE_POWER_OFF=3Dy

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
CONFIG_PARPORT_SERIAL=3Dm
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
CONFIG_PARPORT_OTHER=3Dy
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play configuration
#
CONFIG_PNP=3Dm
CONFIG_ISAPNP=3Dm

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=3Dm
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_FWMARK=3Dy
CONFIG_IP_ROUTE_NAT=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_TOS=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_LARGE_TABLES=3Dy
CONFIG_IP_PNP=3Dy
# CONFIG_IP_PNP_DHCP is not set
# CONFIG_IP_PNP_BOOTP is not set
CONFIG_IP_PNP_RARP=3Dy
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=3Dm

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_LIMIT=3Dm
CONFIG_IP6_NF_MATCH_MAC=3Dm
CONFIG_IP6_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP6_NF_MATCH_OWNER=3Dm
CONFIG_IP6_NF_MATCH_MARK=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_LOG=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
# CONFIG_IP6_NF_TARGET_MARK is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dm
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_BLK_DEV_OFFBOARD=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_IDEDMA_PCI_WIP=3Dy
CONFIG_BLK_DEV_IDEDMA_TIMEOUT=3Dy
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=3Dy
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
CONFIG_BLK_DEV_HPT34X=3Dy
CONFIG_HPT34X_AUTODMA=3Dy
CONFIG_BLK_DEV_HPT366=3Dy
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=3Dm
CONFIG_BLK_DEV_SD=3Dm
CONFIG_SD_EXTRA_DEVS=3D40
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_SR_EXTRA_DEVS=3D2
CONFIG_CHR_DEV_SG=3Dm
CONFIG_SCSI_DEBUG_QUEUES=3Dy
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=3Dm
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D253
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
CONFIG_AIC7XXX_PROBE_EISA_VL=3Dy
CONFIG_AIC7XXX_BUILD_FIRMWARE=3Dy
CONFIG_SCSI_AIC7XXX_OLD=3Dm
CONFIG_AIC7XXX_OLD_TCQ_ON_BY_DEFAULT=3Dy
CONFIG_AIC7XXX_OLD_CMDS_PER_DEVICE=3D8
CONFIG_AIC7XXX_OLD_PROC_STATS=3Dy
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=3Dm
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=3Dm
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_SBP2=3Dm
CONFIG_IEEE1394_SBP2_PHYS_DMA=3Dy
CONFIG_IEEE1394_ETH1394=3Dm
CONFIG_IEEE1394_DV1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
CONFIG_IEEE1394_CMP=3Dm
CONFIG_IEEE1394_AMDTP=3Dm
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# I2O device support
#
CONFIG_I2O=3Dm
CONFIG_I2O_PCI=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_LAN=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=3Dy
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=3Dy
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_TC35815 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=3Dm
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=3Dm
CONFIG_8139TOO=3Dm
CONFIG_8139TOO_PIO=3Dy
CONFIG_8139TOO_TUNE_TWISTER=3Dy
CONFIG_8139TOO_8129=3Dy
CONFIG_8139_NEW_RX_RESET=3Dy
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=3Dm
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
CONFIG_IRDA_FAST_RR=3Dy
CONFIG_IRDA_DEBUG=3Dy

#
# Infrared-port device drivers
#
CONFIG_IRTTY_SIR=3Dm
CONFIG_IRPORT_SIR=3Dm
CONFIG_DONGLE=3Dy
CONFIG_ESI_DONGLE=3Dm
CONFIG_ACTISYS_DONGLE=3Dm
CONFIG_TEKRAM_DONGLE=3Dm
CONFIG_GIRBIL_DONGLE=3Dm
CONFIG_LITELINK_DONGLE=3Dm
CONFIG_OLD_BELKIN_DONGLE=3Dm
CONFIG_USB_IRDA=3Dm
CONFIG_NSC_FIR=3Dm
CONFIG_WINBOND_FIR=3Dm
CONFIG_TOSHIBA_FIR=3Dm
CONFIG_SMC_IRCC_FIR=3Dm
CONFIG_ALI_FIR=3Dm
CONFIG_VLSI_FIR=3Dm

#
# ISDN subsystem
#
CONFIG_ISDN=3Dm
CONFIG_ISDN_BOOL=3Dy
CONFIG_ISDN_PPP=3Dy
CONFIG_ISDN_PPP_VJ=3Dy
CONFIG_ISDN_MPP=3Dy
CONFIG_ISDN_PPP_BSDCOMP=3Dm
CONFIG_ISDN_AUDIO=3Dy
CONFIG_ISDN_TTY_FAX=3Dy

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=3Dm
CONFIG_ISDN_DIVERSION=3Dm

#
# Passive ISDN cards
#
CONFIG_ISDN_DRV_HISAX=3Dm
CONFIG_ISDN_HISAX=3Dy
CONFIG_HISAX_EURO=3Dy
CONFIG_DE_AOC=3Dy
CONFIG_HISAX_NO_SENDCOMPLETE=3Dy
CONFIG_HISAX_NO_LLC=3Dy
CONFIG_HISAX_NO_KEYPAD=3Dy
# CONFIG_HISAX_1TR6 is not set
# CONFIG_HISAX_NI1 is not set
CONFIG_HISAX_MAX_CARDS=3D8
# CONFIG_HISAX_16_0 is not set
# CONFIG_HISAX_16_3 is not set
# CONFIG_HISAX_TELESPCI is not set
# CONFIG_HISAX_S0BOX is not set
# CONFIG_HISAX_AVM_A1 is not set
CONFIG_HISAX_FRITZPCI=3Dy
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
# CONFIG_HISAX_ELSA is not set
# CONFIG_HISAX_IX1MICROR2 is not set
# CONFIG_HISAX_DIEHLDIVA is not set
# CONFIG_HISAX_ASUSCOM is not set
# CONFIG_HISAX_TELEINT is not set
# CONFIG_HISAX_HFCS is not set
# CONFIG_HISAX_SEDLBAUER is not set
# CONFIG_HISAX_SPORTSTER is not set
# CONFIG_HISAX_MIC is not set
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
# CONFIG_HISAX_NICCY is not set
# CONFIG_HISAX_ISURF is not set
# CONFIG_HISAX_HSTSAPHIR is not set
# CONFIG_HISAX_BKM_A4T is not set
# CONFIG_HISAX_SCT_QUADRO is not set
# CONFIG_HISAX_GAZEL is not set
# CONFIG_HISAX_HFC_PCI is not set
# CONFIG_HISAX_W6692 is not set
# CONFIG_HISAX_HFC_SX is not set
# CONFIG_HISAX_DEBUG is not set
# CONFIG_HISAX_SEDLBAUER_CS is not set
# CONFIG_HISAX_ELSA_CS is not set
# CONFIG_HISAX_AVM_A1_CS is not set
# CONFIG_HISAX_ST5481 is not set
# CONFIG_HISAX_FRITZ_PCIPNP is not set

#
# Active ISDN cards
#
# CONFIG_ISDN_DRV_ICN is not set
# CONFIG_ISDN_DRV_PCBIT is not set
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
# CONFIG_ISDN_DRV_EICON is not set
# CONFIG_ISDN_DRV_TPAM is not set
CONFIG_ISDN_CAPI=3Dm
# CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON is not set
CONFIG_ISDN_CAPI_MIDDLEWARE=3Dy
CONFIG_ISDN_CAPI_CAPI20=3Dm
CONFIG_ISDN_CAPI_CAPIFS_BOOL=3Dy
CONFIG_ISDN_CAPI_CAPIFS=3Dm
CONFIG_ISDN_CAPI_CAPIDRV=3Dm
CONFIG_ISDN_DRV_AVMB1_B1ISA=3Dm
CONFIG_ISDN_DRV_AVMB1_B1PCI=3Dm
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=3Dy
CONFIG_ISDN_DRV_AVMB1_T1ISA=3Dm
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=3Dm
# CONFIG_ISDN_DRV_AVMB1_AVM_CS is not set
CONFIG_ISDN_DRV_AVMB1_T1PCI=3Dm
CONFIG_ISDN_DRV_AVMB1_C4=3Dm
CONFIG_HYSDN=3Dm
# CONFIG_HYSDN_CAPI is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=3Dm
CONFIG_INPUT_KEYBDEV=3Dm
CONFIG_INPUT_MOUSEDEV=3Dm
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_PHILIPSPAR=3Dm
CONFIG_I2C_ELV=3Dm
CONFIG_I2C_VELLEMAN=3Dm
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ELEKTOR=3Dm
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_PROC=3Dm

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=3Dy
CONFIG_PSMOUSE=3Dy
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
CONFIG_NVRAM=3Dm
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dm
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=3Dy
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=3Dm
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dy
CONFIG_REISERFS_FS=3Dy
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=3Dy
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=3Dm
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=3Dm
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
CONFIG_DEVFS_FS=3Dy
CONFIG_DEVFS_MOUNT=3Dy
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=3Dm
CONFIG_INTERMEZZO_FS=3Dm
CONFIG_NFS_FS=3Dm
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=3Dm
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp850"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=3Dy
CONFIG_ZLIB_FS_INFLATE=3Dy

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=3Dm
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=3Dm
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=3Dm
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=3Dm
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dm

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=3Dy
CONFIG_FB_MATROX=3Dm
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G100=3Dy
# CONFIG_FB_MATROX_I2C is not set
# CONFIG_FB_MATROX_MAVEN is not set
# CONFIG_FB_MATROX_G450 is not set
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_VIRTUAL=3Dm
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_MFB=3Dm
CONFIG_FBCON_CFB2=3Dm
CONFIG_FBCON_CFB4=3Dm
CONFIG_FBCON_CFB8=3Dm
CONFIG_FBCON_CFB16=3Dm
CONFIG_FBCON_CFB24=3Dm
CONFIG_FBCON_CFB32=3Dm
CONFIG_FBCON_MAC=3Dm
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy

#
# Sound
#
CONFIG_SOUND=3Dm
CONFIG_SOUND_BT878=3Dm
CONFIG_SOUND_CMPCI=3Dm
CONFIG_SOUND_CMPCI_FM=3Dy
CONFIG_SOUND_CMPCI_FMIO=3D388
CONFIG_SOUND_CMPCI_FMIO=3D388
CONFIG_SOUND_CMPCI_MIDI=3Dy
CONFIG_SOUND_CMPCI_MPUIO=3D330
CONFIG_SOUND_CMPCI_JOYSTICK=3Dy
CONFIG_SOUND_CMPCI_CM8738=3Dy
# CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
CONFIG_SOUND_CMPCI_SPDIFLOOP=3Dy
CONFIG_SOUND_CMPCI_SPEAKERS=3D2
CONFIG_SOUND_EMU10K1=3Dm
CONFIG_MIDI_EMU10K1=3Dy
CONFIG_SOUND_FUSION=3Dm
CONFIG_SOUND_CS4281=3Dm
CONFIG_SOUND_ES1370=3Dm
CONFIG_SOUND_ES1371=3Dm
CONFIG_SOUND_ESSSOLO1=3Dm
CONFIG_SOUND_MAESTRO=3Dm
CONFIG_SOUND_MAESTRO3=3Dm
CONFIG_SOUND_ICH=3Dm
CONFIG_SOUND_RME96XX=3Dm
CONFIG_SOUND_SONICVIBES=3Dm
CONFIG_SOUND_TRIDENT=3Dm
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=3Dm
CONFIG_MIDI_VIA82CXXX=3Dy
CONFIG_SOUND_OSS=3Dm
CONFIG_SOUND_TRACEINIT=3Dy
CONFIG_SOUND_DMAP=3Dy
CONFIG_SOUND_AD1816=3Dm
CONFIG_SOUND_SGALAXY=3Dm
CONFIG_SOUND_ADLIB=3Dm
CONFIG_SOUND_ACI_MIXER=3Dm
CONFIG_SOUND_CS4232=3Dm
CONFIG_SOUND_SSCAPE=3Dm
CONFIG_SOUND_GUS=3Dm
CONFIG_SOUND_GUS16=3Dy
CONFIG_SOUND_GUSMAX=3Dy
CONFIG_SOUND_VMIDI=3Dm
CONFIG_SOUND_TRIX=3Dm
CONFIG_SOUND_MSS=3Dm
CONFIG_SOUND_MPU401=3Dm
CONFIG_SOUND_NM256=3Dm
CONFIG_SOUND_MAD16=3Dm
CONFIG_MAD16_OLDCARD=3Dy
CONFIG_SOUND_PAS=3Dm
# CONFIG_PAS_JOYSTICK is not set
CONFIG_SOUND_PSS=3Dm
CONFIG_PSS_MIXER=3Dy
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=3Dm
CONFIG_SOUND_AWE32_SYNTH=3Dm
CONFIG_SOUND_WAVEFRONT=3Dm
CONFIG_SOUND_MAUI=3Dm
CONFIG_SOUND_YM3812=3Dm
CONFIG_SOUND_OPL3SA1=3Dm
CONFIG_SOUND_OPL3SA2=3Dm
CONFIG_SOUND_YMFPCI=3Dm
CONFIG_SOUND_YMFPCI_LEGACY=3Dy
CONFIG_SOUND_UART6850=3Dm
CONFIG_SOUND_AEDSP16=3Dm
CONFIG_SC6600=3Dy
CONFIG_SC6600_JOY=3Dy
CONFIG_SC6600_CDROM=3D4
CONFIG_SC6600_CDROMBASE=3D0
CONFIG_AEDSP16_SBPRO=3Dy
CONFIG_AEDSP16_MPU401=3Dy
CONFIG_SOUND_TVMIXER=3Dm

#
# USB support
#
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_UHCI is not set
CONFIG_USB_UHCI_ALT=3Dm
# CONFIG_USB_OHCI is not set
CONFIG_USB_AUDIO=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_BLUETOOTH=3Dm
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_DEBUG=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_HP8200e=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
CONFIG_USB_HIDDEV=3Dy
CONFIG_USB_KBD=3Dm
CONFIG_USB_MOUSE=3Dm
CONFIG_USB_WACOM=3Dm
CONFIG_USB_DC2XX=3Dm
CONFIG_USB_MDC800=3Dm
CONFIG_USB_SCANNER=3Dm
CONFIG_USB_MICROTEK=3Dm
CONFIG_USB_HPUSBSCSI=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_CATC=3Dm
CONFIG_USB_CDCETHER=3Dm
CONFIG_USB_USBNET=3Dm
CONFIG_USB_USS720=3Dm

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_AUERSWALD=3Dm
CONFIG_USB_BRLVGER=3Dm

#
# Bluetooth support
#
CONFIG_BLUEZ=3Dm
CONFIG_BLUEZ_L2CAP=3Dm
CONFIG_BLUEZ_SCO=3Dm

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=3Dm
CONFIG_BLUEZ_USB_FW_LOAD=3Dy
CONFIG_BLUEZ_USB_ZERO_PACKET=3Dy
CONFIG_BLUEZ_HCIUART=3Dm
CONFIG_BLUEZ_HCIUART_H4=3Dy
# CONFIG_BLUEZ_HCIDTL1 is not set
CONFIG_BLUEZ_HCIVHCI=3Dm

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_DEBUG_HIGHMEM=3Dy
CONFIG_DEBUG_SLAB=3Dy
CONFIG_DEBUG_IOVIRT=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_SPINLOCK=3Dy
CONFIG_FRAME_POINTER=3Dy

--=-IpxFohRu5UNydibvIiyw--

