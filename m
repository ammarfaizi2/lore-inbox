Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314211AbSDVOmb>; Mon, 22 Apr 2002 10:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314213AbSDVOma>; Mon, 22 Apr 2002 10:42:30 -0400
Received: from 137-5.red-dsl.cpl.net ([192.216.137.5]:1295 "HELO
	mail.heronforge.net") by vger.kernel.org with SMTP
	id <S314211AbSDVOm2>; Mon, 22 Apr 2002 10:42:28 -0400
Date: Mon, 22 Apr 2002 07:42:27 -0700 (PDT)
From: Stephen Carville <carville@cpl.net>
X-X-Sender: <stephen@warlock.heronforge.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel oops and drive failure 
Message-ID: <Pine.LNX.4.33.0204220739520.3742-100000@warlock.heronforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Washer advises me this report need the output from ksymoops:

ksymoops 2.4.1 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (specified)
     -m /boot/System.map-2.4.18-041802 (specified)

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (expand_objects): cannot stat(/lib/raid5.o) for raid5
Error (expand_objects): cannot stat(/lib/xor.o) for xor
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (read_object): no symbols in /lib/modules/2.4.18/build/net/ipv4/netfilter/netfilter.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/net/ipv6/netfilter/netfilter.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/net/wan/wan.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/net/tokenring/tr.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/net/fc/fc.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/net/appletalk/appletalk.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/net/wireless/wireless_net.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/char/drm/drm.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/sound/sounddrivers.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/cdrom/driver.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/misc/misc.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/parport/driver.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/media/radio/radio.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/media/video/video.o
Warning (read_object): no symbols in /lib/modules/2.4.18/build/drivers/media/media.o
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01bf480, System.map says c015e740.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol pci_hp_change_slot_info_R__ver_pci_hp_change_slot_info not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol pci_hp_deregister_R__ver_pci_hp_deregister not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol pci_hp_register_R__ver_pci_hp_register not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says f8a75114, /lib/modules/2.4.18/kernel/drivers/usb/usbcore.o says f8a74c14.  Ignoring /lib/modules/2.4.18/kernel/drivers/usb/usbcore.o entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module jbd to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module raid5 to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module xor to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module aic7xxx to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module sd_mod to a unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module scsi_mod to a unique module object.  Trace may not be reliable.
Apr 21 18:09:54 jordan kernel: c01c067e
Apr 21 18:09:54 jordan kernel: *pde = 00000000
Apr 21 18:09:54 jordan kernel: Oops: 0002
Apr 21 18:09:54 jordan kernel: CPU:    0
Apr 21 18:09:54 jordan kernel: EIP:    0010:[<c01c067e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 21 18:09:54 jordan kernel: EFLAGS: 00010202
Apr 21 18:09:54 jordan kernel: eax: 00000841   ebx: f77db180   ecx: 00000020   edx: 00000841
Apr 21 18:09:54 jordan kernel: esi: f77db380   edi: 00000f80   ebp: c201f660   esp: f77d9f48
Apr 21 18:09:54 jordan kernel: ds: 0018   es: 0018   ss: 0018
Apr 21 18:09:54 jordan kernel: Process raid5d (pid: 20, stackpage=f77d9000)
Apr 21 18:09:54 jordan kernel: Stack: 00000000 f77df000 f77dc000 f7ead280 c201f6a0 c01c0729 f7ead280 c201f660
Apr 21 18:09:54 jordan kernel:        00000001 f78d3c00 f7ead280 00000000 c01c07ff f7ead280 00000064 00000001
Apr 21 18:09:54 jordan kernel:        f78d3c00 f77d8000 00000000 f8845b3b f7ead280 fffffc18 00000000 c0274000
Apr 21 18:09:54 jordan kernel: Call Trace: [<c01c0729>] [<c01c07ff>] [<f8845b3b>] [<f8845b20>] [<c01c360a>]
Apr 21 18:09:54 jordan kernel:    [<c0105876>] [<c01c34c0>]
Apr 21 18:09:54 jordan kernel: Code: f3 a5 8b 83 00 02 00 00 89 45 3c c7 04 24 01 00 00 00 8b 1c

>>EIP; c01c067e <set_this_disk+5e/a0>   <=====
Trace; c01c0729 <sync_sbs+69/90>
Trace; c01c07ff <md_update_sb+af/1c0>
Trace; f8845b3b <[raid5]device_bsize+13b/14bf>
Trace; f8845b20 <[raid5]device_bsize+120/14bf>
Trace; c01c360a <md_thread+14a/1b0>
Trace; c0105876 <kernel_thread+26/30>
Trace; c01c34c0 <md_thread+0/1b0>
Code;  c01c067e <set_this_disk+5e/a0>
00000000 <_EIP>:
Code;  c01c067e <set_this_disk+5e/a0>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c01c0680 <set_this_disk+60/a0>
   2:   8b 83 00 02 00 00         mov    0x200(%ebx),%eax
Code;  c01c0686 <set_this_disk+66/a0>
   8:   89 45 3c                  mov    %eax,0x3c(%ebp)
Code;  c01c0689 <set_this_disk+69/a0>
   b:   c7 04 24 01 00 00 00      movl   $0x1,(%esp,1)
Code;  c01c0690 <set_this_disk+70/a0>
  12:   8b 1c 00                  mov    (%eax,%eax,1),%ebx


27 warnings and 7 errors issued.  Results may not be reliable.

Original mssages:

I recently upgraded to 2.4.18 on a dual processor Dell 2550 server.
This is a backup Oracle servers (9i).  Last night the load average
jumped to about 4 and an hour later to about 7.  Top reports the CPU
utilization is less than 5%.  Nevertheless the load averages keep
climbing.


About the time the load average jumped the log reports:

----------------------

Apr 21 18:09:54 jordan kernel: Device 08:41 not ready.

Apr 21 18:09:54 jordan kernel:  I/O error: dev 08:41, sector 98566248

Apr 21 18:09:54 jordan kernel: raid5: Disk failure on sde1, disabling
device. Operation continuing on 3 devices

Apr 21 18:09:54 jordan kernel: md: recovery thread got woken up ...

Apr 21 18:09:54 jordan kernel: Unable to handle ke<1lUaULLblepto
tandde kfeeencernel NULL pointer dereference<6>md: recovery thread
finished ...

Apr 21 18:09:54 jordan kernel: md: recovery thre00000f80

Apr 21 18:09:54 jordan kernel:  printing eip:

Apr 21 18:09:54 jordan kernel: c01c067e

Apr 21 18:09:54 jordan kernel: *pde = 00000000

Apr 21 18:09:54 jordan kernel: Oops: 0002

Apr 21 18:09:54 jordan kernel: CPU:    0

Apr 21 18:09:54 jordan kernel: EIP:    0010:[<c01c067e>]    Not
tainted

Apr 21 18:09:54 jordan kernel: EFLAGS: 00010202

Apr 21 18:09:54 jordan kernel: eax: 00000841   ebx: f77db180   ecx:
00000020   edx: 00000841

Apr 21 18:09:54 jordan kernel: esi: f77db380   edi: 00000f80   ebp:
c201f660   esp: f77d9f48

Apr 21 18:09:54 jordan kernel: ds: 0018   es: 0018   ss: 0018

Apr 21 18:09:54 jordan kernel: Process raid5d (pid: 20,
stackpage=f77d9000)

Apr 21 18:09:54 jordan kernel: Stack: 00000000 f77df000 f77dc000
f7ead280 c201f6a0 c01c0729 f7ead280 c201f660

Apr 21 18:09:54 jordan kernel:        00000001 f78d3c00 f7ead280
00000000 c01c07ff f7ead280 00000064 00000001

Apr 21 18:09:54 jordan kernel:        f78d3c00 f77d8000 00000000
f8845b3b f7ead280 fffffc18 00000000 c0274000

Apr 21 18:09:54 jordan kernel: Call Trace: [<c01c0729>] [<c01c07ff>]
[<f8845b3b>] [<f8845b20>] [<c01c360a>] Apr 21 18:09:54 jordan kernel:
[<c0105876>] [<c01c34c0>]

Apr 21 18:09:54 jordan kernel:

Apr 21 18:09:54 jordan kernel: Code: f3 a5 8b 83 00 02 00 00 89 45 3c
c7 04 24 01 00 00 00 8b 1c

-------------------------

I guess this a kernel 'oops'?

Please CC me on any response.  I am not a member of this list.

-- 
-- Stephen Carville http://www.heronforge.net/~stephen/gnupgkey.txt
==============================================================
Government is like burning witches:  After years of burning young
women failed to solve any of society's problems, the solution was to
burn more young women.
==============================================================

