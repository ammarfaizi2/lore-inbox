Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSCOJYj>; Fri, 15 Mar 2002 04:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSCOJYa>; Fri, 15 Mar 2002 04:24:30 -0500
Received: from blackhole.adamant.ua ([212.26.128.69]:9220 "EHLO
	blackhole.adamant.net") by vger.kernel.org with ESMTP
	id <S287817AbSCOJYM>; Fri, 15 Mar 2002 04:24:12 -0500
Date: Fri, 15 Mar 2002 11:24:04 +0200
From: Alexander Trotsai <mage@adamant.ua>
To: linux-kernel@vger.kernel.org
Subject: udf broken (may be)
Message-ID: <20020315092404.GA1110@blackhole.adamant.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I try to use packet-cd patch for writing cdrw as block
device

Now I install kernel 2.4.19-pre3-ac1 and latest packet patch
packet-2.4.19-pre2.patch.bz2

But I has same situation with 2.4.19-pre2-ac2

Packet drivers load successfully and pktsetup work OK (may
be). But when I try to do mount and got kernel oops
Decoded oops I insert bottom.

I ask about this trouble in packet-cd maillist but they said
to problem seems in udf module.
Can someone help me (Also in packet-cd maillist I read
messages about successful usage packet software in pure
kernel, not ac)?

There is decoded oops
 
ksymoops 2.4.1 on i686 2.4.19-pre3-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre3-ac1/ (default)
     -m /boot/System.map-2.4.19-pre3-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says d29a57c4, /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/sr_mod.o says d29a56e0.  Ignoring /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/sr_mod.o entry
Warning (compare_maps): mismatch on symbol tulip_max_interrupt_work  , tulip says d299418c, /lib/modules/2.4.19-pre3-ac1/kernel/drivers/net/tulip/tulip.o says d2993a8c.  Ignoring /lib/modules/2.4.19-pre3-ac1/kernel/drivers/net/tulip/tulip.o entry
Warning (compare_maps): mismatch on symbol tulip_rx_copybreak  , tulip says d2994190, /lib/modules/2.4.19-pre3-ac1/kernel/drivers/net/tulip/tulip.o says d2993a90.  Ignoring /lib/modules/2.4.19-pre3-ac1/kernel/drivers/net/tulip/tulip.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says d29309e4, /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/scsi_mod.o says d29303e4.  Ignoring /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says d2930a10, /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/scsi_mod.o says d2930410.  Ignoring /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says d2930a0c, /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/scsi_mod.o says d293040c.  Ignoring /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says d2930a14, /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/scsi_mod.o says d2930414.  Ignoring /lib/modules/2.4.19-pre3-ac1/kernel/drivers/scsi/scsi_mod.o entry
cpu: 0, clocks: 2675875, slice: 1337937
UDF-fs DEBUG lowlevel.c:57:udf_get_last_session: XA disk: no, vol_desc_start=0
UDF-fs DEBUG super.c:1413:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte sectors)
Unable to handle kernel NULL pointer dereference at virtual address 00000174
d4d52781
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d4d52781>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000140   ebx: 00008000   ecx: 0000000b   edx: c7f70440
esi: 00000120   edi: c6bab110   ebp: c6bab000   esp: c36e9db0
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 1139, stackpage=c36e9000)
Stack: c6bab000 00000100 00000100 c36e9dda 00000246 00000000 c6bab0e4 cb6671c0 
       00000003 00000140 0002b000 00000000 c6bab000 d4d52290 c6bab000 c6bab040 
       c6bab000 00000000 c36e9e3c d4d52f43 c6bab000 c36e9e3c 00000000 d4d57a27 
Call Trace: [<d4d52290>] [<d4d52f43>] [<d4d57a27>] [<d29262e3>] [<d29a2193>] 
   [<d2911f00>] [<d291ffff>] [<c013fa54>] [<c0150eec>] [<c0150e3a>] [<d4d59060>] 
   [<c01400ae>] [<d4d59060>] [<c0151f7e>] [<c0152260>] [<c01520a9>] [<c0152371>] 
   [<c0107423>] 
Code: 8b 40 34 d3 fb 01 f3 8b 68 18 89 14 24 d3 fd 03 6c 24 24 e8 

>>EIP; d4d52781 <[udf]udf_load_partition+491/500>   <=====
Trace; d4d52290 <[udf]udf_check_valid+60/c0>
Trace; d4d52f43 <[udf]udf_read_super+453/700>
Trace; d4d57a27 <[udf].LC6+11a/1593>
Trace; d29262e3 <[scsi_mod]scsi_ioctl+f3/3c0>
Trace; d29a2193 <[sr_mod]sr_media_change+53/e0>
Trace; d2911f00 <[cdrom]media_changed+0/90>
Trace; d291ffff <[ide-cd].rodata.end+600/1b61>
Trace; c013fa54 <get_sb_bdev+1e4/2d0>
Trace; c0150eec <set_devname+3c/90>
Trace; c0150e3a <alloc_vfsmnt+3a/70>
Trace; d4d59060 <[udf]udf_fstype+0/20>
Trace; c01400ae <do_kern_mount+17e/1b0>
Trace; d4d59060 <[udf]udf_fstype+0/20>
Trace; c0151f7e <do_add_mount+2e/e0>
Trace; c0152260 <do_mount+160/1c0>
Trace; c01520a9 <copy_mount_options+79/d0>
Trace; c0152371 <sys_mount+b1/e0>
Trace; c0107423 <system_call+33/38>
Code;  d4d52781 <[udf]udf_load_partition+491/500>
00000000 <_EIP>:
Code;  d4d52781 <[udf]udf_load_partition+491/500>   <=====
   0:   8b 40 34                  mov    0x34(%eax),%eax   <=====
Code;  d4d52784 <[udf]udf_load_partition+494/500>
   3:   d3 fb                     sar    %cl,%ebx
Code;  d4d52786 <[udf]udf_load_partition+496/500>
   5:   01 f3                     add    %esi,%ebx
Code;  d4d52788 <[udf]udf_load_partition+498/500>
   7:   8b 68 18                  mov    0x18(%eax),%ebp
Code;  d4d5278b <[udf]udf_load_partition+49b/500>
   a:   89 14 24                  mov    %edx,(%esp,1)
Code;  d4d5278e <[udf]udf_load_partition+49e/500>
   d:   d3 fd                     sar    %cl,%ebp
Code;  d4d52790 <[udf]udf_load_partition+4a0/500>
   f:   03 6c 24 24               add    0x24(%esp,1),%ebp
Code;  d4d52794 <[udf]udf_load_partition+4a4/500>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> d4d52799 <[udf]udf_load_partition+4a9/500>


9 warnings issued.  Results may not be reliable.

-- 
Best regard, Alexander Trotsai aka MAGE-RIPE aka MAGE-UANIC
My PGP at ftp://blackhole.adamant.net/pgp/trotsai.key[.asc]
Big trouble - bugs in the RAID
