Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136088AbREKXs1>; Fri, 11 May 2001 19:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137036AbREKXsT>; Fri, 11 May 2001 19:48:19 -0400
Received: from steve.prima.de ([62.72.84.2]:29444 "EHLO steve.prima.de")
	by vger.kernel.org with ESMTP id <S136088AbREKXsG>;
	Fri, 11 May 2001 19:48:06 -0400
Message-ID: <XFMail.010512014854.ingo@plato.prima.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.0.Linux:010512014854:2713=_"
Date: Sat, 12 May 2001 01:48:54 +0200 (CEST)
Organization: Private Site
From: Ingo Renner <ingo@plato.prima.de>
To: linux-kernel@vger.kernel.org
Subject: OOPS on 2.4.4-ac4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.0.Linux:010512014854:2713=_
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,
I have the following Hardware installed:
Epox EP-8KTA2 with Athlon 800 onboard sound enabled with kernel driver
cat  /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
      Master Capable.  Latency=3D8. =20
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0=
).
      Master Capable.  No bursts.  Min Gnt=3D12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 6=
4).
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controll=
er
(rev 80).
      IRQ 15.
      I/O at 0x9c00 [0x9cff].
      I/O at 0xa000 [0xa003].
      I/O at 0xa400 [0xa403].
  Bus  0, device   9, function  0:
    Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev=
 3).
      IRQ 11.
      Master Capable.  Latency=3D120.  Min Gnt=3D8.Max Lat=3D8.
      I/O at 0xa800 [0xa807].
      I/O at 0xac00 [0xac03].
      I/O at 0xb000 [0xb007].
      I/O at 0xb400 [0xb403].
      I/O at 0xb800 [0xb8ff].
  Bus  0, device  10, function  0:
    SCSI storage controller: Adaptec AIC-7881U (rev 0).
      IRQ 15.
      Master Capable.  Latency=3D32.  Min Gnt=3D8.Max Lat=3D8.
      I/O at 0xbc00 [0xbcff].
      Non-prefetchable 32 bit memory at 0xd8000000 [0xd8000fff].
  Bus  0, device  13, function  0:
    Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (=
rev
49).
      IRQ 10.
      Master Capable.  Latency=3D32.  Min Gnt=3D20.Max Lat=3D40.
      I/O at 0xc000 [0xc0ff].
      Non-prefetchable 32 bit memory at 0xd8001000 [0xd80010ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation Riva TnT 128 [NV04] (rev =
4).
      IRQ 12.
      Master Capable.  Latency=3D248.  Min Gnt=3D5.Max Lat=3D1.
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd4ffffff].
      Prefetchable 32 bit memory at 0xd6000000 [0xd6ffffff].


I had trouble with a Networkcard with Realtek RTL 8139A Chip wich does not =
work
proper with the via Chip. So today I changed the card with one from Fiober =
Line
wich has a Davicom DM 9102AF Chip. After some stress test I thought this ca=
rd
was doing fine. Now I had to leave and prepared the computer for my Girlfri=
ed.
Loggin in under her account, starting KDE 2.1.2 under Suse 7.1 and switched=
 of
the Monitor. 6 Hours later I found this oops and my girlfriend hasn't used =
the
computer during this time.=20
So I don't know if this has to do with the new networkcard, the new NVIDIA
Driver 0.9-769 I installed yesterday with XFree 4.3 or something else. The =
only
thing I know is, that I never had this oops before.=20
If there is something more I can do to help to find the reason please tell =
me,
but please more than three words, I'm no kernel Hacker, I just like to help=
.
I included the part of /var/log/messages.
I left between the      May 11 17:33:44 lara -- MARK --
               and      May 11 17:53:44 lara -- MARK --
               entry
and came back at May 12 00:43:36

vmware -version  =20
VMware Workstation protocol=3D6 build=3Dbuild-1118 product=3D'2.0.4 build-1=
118'
My modules:
-----------
Module                  Size  Used by
via82cxxx_audio        16800   2  (autoclean)
soundcore               3600   2  (autoclean) [via82cxxx_audio]
ac97_codec              8560   0  (autoclean) [via82cxxx_audio]
NVdriver              626480  12  (autoclean)
vmnet                  16224   3
vmmon                  18224   0
dmfe                    9408   1  (autoclean)

---------------------------------------------------------------------------
ksymoops 2.4.1 on i686 2.4.4-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-ac4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

May 12 00:15:50 lara kernel: Unable to handle kernel paging request at virt=
ual
address 417563e8
May 12 00:15:50 lara kernel: c012ffb4
May 12 00:15:50 lara kernel: Oops: 0000
May 12 00:15:50 lara kernel: CPU:    0
May 12 00:15:50 lara kernel: EIP:    0010:[set_blocksize+404/544]
May 12 00:15:50 lara kernel: EFLAGS: 00010a87
May 12 00:15:50 lara kernel: eax: 417563c0   ebx: 00000000   ecx: c11956bc =
=20
edx: 00000000
May 12 00:15:50 lara kernel: esi: 417563c0   edi: c17563c0   ebp: c11956a0 =
=20
esp: c356fda0
May 12 00:15:50 lara kernel: ds: 0018   es: 0018   ss: 0018
May 12 00:15:50 lara kernel: Process find (pid: 2127, stackpage=3Dc356f000)
May 12 00:15:50 lara kernel: Stack: c11956a0 c11956bc 00000000 00000002
00000000 00000003 c0126883 c11956a0=20
May 12 00:15:50 lara kernel:        00000000 00000000 00000009 00001605
00101594 00000000 00000002 00000000=20
May 12 00:15:50 lara kernel:        00000000 00000000 00000002 00000000
00009338 00000000 c012e19c 00000003=20
May 12 00:15:50 lara kernel: Call Trace: [kmalloc+115/144]
[dentry_open+140/336] [sys_close+46/96] [ext2_new_block+633/1824] [e
xt2_new_block+576/1824]=20
May 12 00:15:50 lara kernel: Code: 8b 76 28 8b 50 18 8b 40 10 83 e2 46 09 d=
0 0f
85 b0 00 00 00=20
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 76 28                  mov    0x28(%esi),%esi
Code;  00000003 Before first symbol
   3:   8b 50 18                  mov    0x18(%eax),%edx
Code;  00000006 Before first symbol
   6:   8b 40 10                  mov    0x10(%eax),%eax
Code;  00000009 Before first symbol
   9:   83 e2 46                  and    $0x46,%edx
Code;  0000000c Before first symbol
   c:   09 d0                     or     %edx,%eax
Code;  0000000e Before first symbol
   e:   0f 85 b0 00 00 00         jne    c4 <_EIP+0xc4> 000000c4 Before fir=
st
symbol


1 warning issued.  Results may not be reliable.
----------------------------------------------------------

        Ciao,
                Ingo

"I have looked into the darkness, Na'Toth. You cannot do that and ever be
 quite the same again. When you told me about the destruction of our base
 in Quadrant 37, I knew that only a major power could attempt an assault
 of that magnitude, but none of the governments here could have done it,
 which left only two possibilities: a new race, or an old race - a very
 old race.=20
        -- G'Kar, "Revelations"


--_=XFMail.1.4.0.Linux:010512014854:2713=_
Content-Disposition: attachment; filename="log.txt"
Content-Transfer-Encoding: 7bit
Content-Description: log.txt
Content-Type: text/plain; charset=iso-8859-1; name=log.txt; SizeOnDisk=10752

May 11 16:53:47 lara kernel: klogd 1.3-3, log source = /proc/kmsg started.
May 11 16:53:47 lara kernel: Inspecting /boot/System.map
May 11 16:53:48 lara kernel: Loaded 15243 symbols from /boot/System.map.
May 11 16:53:48 lara kernel: Symbols match kernel version 2.4.4.
May 11 16:53:48 lara kernel: Loaded 5 symbols from 1 module.
May 11 16:53:48 lara kernel: Davicom DM91xx net driver, version 1.30p3 (April 17
, 2001)
May 11 16:53:48 lara kernel: PCI: Found IRQ 10 for device 00:0d.0
May 11 16:53:48 lara kernel: eth0: Davicom DM9102 at 0xc000, 00:80:ad:79:41:89, 
IRQ 10
May 11 16:53:59 lara /usr/sbin/cron[376]: (CRON) STARTUP (fork ok) 
May 11 16:53:59 lara kernel: /dev/vmmon: Module vmmon: registered with major=10 
minor=165 tag=$Name: build-1118 $
May 11 16:53:59 lara kernel: /dev/vmmon: Module vmmon: initialized
May 11 16:53:59 lara insmod: Using /lib/modules/2.4.4-ac4/misc/vmmon.o
May 11 16:53:59 lara insmod: Using /lib/modules/2.4.4-ac4/misc/vmnet.o
May 11 16:53:59 lara kernel: /dev/vmnet: open called by PID 439 (vmnet-bridge)
May 11 16:53:59 lara kernel: /dev/vmnet: hub 0 does not exist, allocating memory
.
May 11 16:53:59 lara kernel: /dev/vmnet: port on hub 0 successfully opened
May 11 16:53:59 lara kernel: bridge-eth0: up
May 11 16:53:59 lara kernel: bridge-eth0: attached
May 11 16:54:03 lara kernel: /dev/vmnet: open called by PID 495 (vmnet-netifup)
May 11 16:54:03 lara kernel: /dev/vmnet: hub 1 does not exist, allocating memory
.
May 11 16:54:03 lara kernel: /dev/vmnet: port on hub 1 successfully opened
May 11 16:54:03 lara vmnet-dhcpd: Internet Software Consortium DHCP Server 2.0
May 11 16:54:03 lara vmnet-dhcpd: Copyright 1995, 1996, 1997, 1998, 1999 The Int
ernet Software Consortium.
May 11 16:54:03 lara vmnet-dhcpd: All rights reserved.
May 11 16:54:03 lara vmnet-dhcpd: 
May 11 16:54:03 lara vmnet-dhcpd: Please contribute if you find this software us
eful.
May 11 16:54:03 lara vmnet-dhcpd: For info, please visit http://www.isc.org/dhcp
-contrib.html
May 11 16:54:03 lara vmnet-dhcpd: 
May 11 16:54:03 lara vmnet-dhcpd: Configured subnet: 10.17.215.0
May 11 16:54:03 lara vmnet-dhcpd: Setting vmnet-dhcp IP address: 10.17.215.254
May 11 16:54:03 lara kernel: /dev/vmnet: open called by PID 505 (vmnet-dhcpd)
May 11 16:54:03 lara kernel: /dev/vmnet: port on hub 1 successfully opened
May 11 16:54:03 lara vmnet-dhcpd: Recving on     VNet/vmnet1/10.17.215.0
May 11 16:54:03 lara vmnet-dhcpd: Sending on     VNet/vmnet1/10.17.215.0
May 11 16:55:09 lara kernel: NVRM: loading NVIDIA kernel module version 1.0-769
May 11 16:55:39 lara kernel: Via 686a audio driver 1.1.14b
May 11 16:55:39 lara kernel: PCI: Found IRQ 15 for device 00:07.5
May 11 16:55:39 lara kernel: PCI: The same IRQ used for device 00:0a.0
May 11 16:55:39 lara kernel: ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (IC
E1232)
May 11 16:55:39 lara kernel: via82cxxx: board #1 at 0x9C00, IRQ 15
May 11 16:55:39 lara modprobe: modprobe: Can't locate module sound-service-1-0
May 11 16:56:05 lara last message repeated 5 times
Mai 11 16:58:48 lara su: (to root) ingo on /dev/pts/1
Mai 11 16:58:48 lara PAM-unix2[743]: session started for user root, service su 
May 11 16:59:00 lara /USR/SBIN/CRON[755]: (root) CMD ( rm -f /var/spool/cron/las
trun/cron.hourly) 
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,0)
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,0)
May 11 16:59:20 lara kernel: sr0: CDROM not ready.  Make sure there is a disc in
 the drive.
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,0)
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,0)
May 11 16:59:20 lara kernel: sr0: CDROM not ready.  Make sure there is a disc in
 the drive.
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,0)
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,0)
May 11 16:59:20 lara kernel: sr0: CDROM not ready.  Make sure there is a disc in
 the drive.
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,1)
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,1)
May 11 16:59:20 lara kernel: sr1: CDROM not ready.  Make sure there is a disc in
 the drive.
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,0)
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,0)
May 11 16:59:20 lara kernel: sr0: CDROM not ready.  Make sure there is a disc in
 the drive.
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,1)
May 11 16:59:20 lara kernel: VFS: Disk change detected on device sr(11,1)
May 11 16:59:20 lara kernel: sr1: CDROM not ready.  Make sure there is a disc in
 the drive.
May 11 16:59:20 lara modprobe: modprobe: Can't locate module sound-service-1-3
May 11 16:59:20 lara modprobe: modprobe: Can't locate module sound-service-2-3
May 11 16:59:20 lara modprobe: modprobe: Can't locate module sound-service-3-3
May 11 16:59:20 lara modprobe: modprobe: Can't locate module sound-service-1-3
May 11 16:59:21 lara modprobe: modprobe: Can't locate module sound-service-2-3
May 11 16:59:21 lara modprobe: modprobe: Can't locate module sound-service-3-3
May 11 17:00:07 lara kernel: ISO 9660 Extensions: Microsoft Joliet Level 3
May 11 17:00:07 lara kernel: ISO 9660 Extensions: RRIP_1991A
May 11 17:05:58 lara kernel: /dev/vmnet: open called by PID 874 (vmware)
May 11 17:05:58 lara kernel: bridge-eth0: set IFF_PROMISC
May 11 17:05:58 lara kernel: /dev/vmnet: port on hub 0 successfully opened
May 11 17:06:23 lara kernel: VFS: Disk change detected on device sr(11,1)
May 11 17:06:23 lara last message repeated 7 times
May 11 17:08:53 lara kernel: bridge-eth0: clear IFF_PROMISC
May 11 17:33:44 lara -- MARK --
May 11 17:53:44 lara -- MARK --
May 11 17:59:00 lara /USR/SBIN/CRON[998]: (root) CMD ( rm -f /var/spool/cron/las
trun/cron.hourly) 
Mai 11 18:00:30 lara PAM-unix2[743]: session finished for user root, service su 
May 11 18:04:39 lara kernel: mtrr: no MTRR for d0000000,2000000 found
May 11 18:04:58 lara modprobe: modprobe: Can't locate module sound-service-1-0
May 11 18:05:03 lara last message repeated 3 times
May 11 18:33:44 lara -- MARK --
May 11 18:53:44 lara -- MARK --
May 11 18:59:00 lara /USR/SBIN/CRON[1311]: (root) CMD ( rm -f /var/spool/cron/la
strun/cron.hourly) 
May 11 19:13:44 lara -- MARK --
May 11 19:33:44 lara -- MARK --
May 11 19:53:44 lara -- MARK --
May 11 19:59:00 lara /USR/SBIN/CRON[1423]: (root) CMD ( rm -f /var/spool/cron/la
strun/cron.hourly) 
May 11 20:13:44 lara -- MARK --
May 11 20:33:44 lara -- MARK --
May 11 20:53:44 lara -- MARK --
May 11 20:59:00 lara /USR/SBIN/CRON[1535]: (root) CMD ( rm -f /var/spool/cron/la
strun/cron.hourly) 
May 11 21:13:44 lara -- MARK --
May 11 21:33:44 lara -- MARK --
May 11 21:48:37 lara kernel: via82cxxx: timeout while reading AC97 codec (0x9A00
00)
May 11 21:59:00 lara /USR/SBIN/CRON[1647]: (root) CMD ( rm -f /var/spool/cron/la
strun/cron.hourly) 
May 11 22:13:44 lara -- MARK --
May 11 22:33:44 lara -- MARK --
May 11 22:47:04 lara kernel: via82cxxx: timeout while reading AC97 codec (0x9A00
00)
May 11 22:59:00 lara /USR/SBIN/CRON[1759]: (root) CMD ( rm -f /var/spool/cron/la
strun/cron.hourly) 
May 11 23:13:44 lara -- MARK --
May 11 23:33:44 lara -- MARK --
May 11 23:53:44 lara -- MARK --
May 11 23:59:00 lara /USR/SBIN/CRON[1871]: (root) CMD ( rm -f /var/spool/cron/la
strun/cron.hourly) 
May 12 00:13:44 lara -- MARK --
May 12 00:14:00 lara /USR/SBIN/CRON[1899]: (root) CMD ( rm -f /var/spool/cron/la
strun/cron.daily) 
May 12 00:15:16 lara su: (to nobody) root on none
May 12 00:15:16 lara PAM-unix2[2125]: session started for user nobody, service s
u 
May 12 00:15:50 lara kernel: Unable to handle kernel paging request at virtual a
ddress 417563e8
May 12 00:15:50 lara kernel:  printing eip:
May 12 00:15:50 lara kernel: c012ffb4
May 12 00:15:50 lara kernel: pgd entry c327c414: 0000000000000000
May 12 00:15:50 lara kernel: pmd entry c327c414: 0000000000000000
May 12 00:15:50 lara kernel: ... pmd not present!
May 12 00:15:50 lara kernel: Oops: 0000
May 12 00:15:50 lara kernel: CPU:    0
May 12 00:15:50 lara kernel: EIP:    0010:[set_blocksize+404/544]
May 12 00:15:50 lara kernel: EFLAGS: 00010a87
May 12 00:15:50 lara kernel: eax: 417563c0   ebx: 00000000   ecx: c11956bc   edx
: 00000000
May 12 00:15:50 lara kernel: esi: 417563c0   edi: c17563c0   ebp: c11956a0   esp
: c356fda0
May 12 00:15:50 lara kernel: ds: 0018   es: 0018   ss: 0018
May 12 00:15:50 lara kernel: Process find (pid: 2127, stackpage=c356f000)
May 12 00:15:50 lara kernel: Stack: c11956a0 c11956bc 00000000 00000002 00000000
 00000003 c0126883 c11956a0 
May 12 00:15:50 lara kernel:        00000000 00000000 00000009 00001605 00101594
 00000000 00000002 00000000 
May 12 00:15:50 lara kernel:        00000000 00000000 00000002 00000000 00009338
 00000000 c012e19c 00000003 
May 12 00:15:50 lara kernel: Call Trace: [kmalloc+115/144] [dentry_open+140/336]
 [sys_close+46/96] [ext2_new_block+633/1824] [ext2_new_block+576/1824] 
May 12 00:15:50 lara kernel:    [sys_llseek+152/208] [ext2_file_lseek+58/176] [l
oad_inode_bitmap+116/448] [ext2_new_block+867/1824] [read_kcore+388/1136] [open_
exec+137/208] 
May 12 00:15:50 lara kernel:    [sys_newfstat+65/96] [sys_readlink+106/160] [sys
_mknod+299/352] [vfs_rmdir+384/432] [vfs_unlink+63/304] [vfs_rmdir+384/432] 
May 12 00:15:50 lara kernel:    [open_namei+400/1440] [ret_with_reschedule+9/16]
 
May 12 00:15:50 lara kernel: 
May 12 00:15:50 lara kernel: Code: 8b 76 28 8b 50 18 8b 40 10 83 e2 46 09 d0 0f 
85 b0 00 00 00 
May 12 00:15:50 lara PAM-unix2[2125]: session finished for user nobody, service 
su 
May 12 00:29:00 lara /USR/SBIN/CRON[2241]: (root) CMD ( rm -f /var/spool/cron/la
strun/cron.weekly) 
May 12 00:43:36 lara kernel:  mtrr: no MTRR for d0000000,2000000 found
May 12 00:44:54 lara modprobe: modprobe: Can't locate module sound-service-1-0
May 12 00:45:19 lara last message repeated 5 times
May 12 00:59:00 lara /USR/SBIN/CRON[2518]: (root) CMD ( rm -f /var/spool/cron/la
strun/cron.hourly) 
Mai 12 01:00:34 lara su: (to root) ingo on /dev/pts/1
Mai 12 01:00:34 lara PAM-unix2[2559]: session started for user root, service su 
Mai 12 01:09:20 lara su: (to root) ingo on /dev/pts/3
Mai 12 01:09:20 lara PAM-unix2[2668]: session started for user root, service su 
May 12 01:14:28 lara kernel: via82cxxx: timeout while reading AC97 codec (0x9A00
00)
May 12 01:33:44 lara -- MARK --
Mai 12 01:36:13 lara crontab[2838]: (root) LIST (root) 
Mai 12 01:36:22 lara su: (to nobody) root on /dev/pts/3
Mai 12 01:36:22 lara PAM-unix2[2839]: session started for user nobody, service s
u 
Mai 12 01:36:26 lara crontab[2849]: (nobody) LIST (nobody) 
Mai 12 01:36:27 lara PAM-unix2[2839]: session finished for user nobody, service 
su 

--_=XFMail.1.4.0.Linux:010512014854:2713=_
Content-Disposition: attachment; filename="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Description: oops.txt
Content-Type: text/plain; charset=iso-8859-1; name=oops.txt; SizeOnDisk=2576

ksymoops 2.4.1 on i686 2.4.4-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-ac4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

May 12 00:15:50 lara kernel: Unable to handle kernel paging request at virtual a
ddress 417563e8
May 12 00:15:50 lara kernel: c012ffb4
May 12 00:15:50 lara kernel: Oops: 0000
May 12 00:15:50 lara kernel: CPU:    0
May 12 00:15:50 lara kernel: EIP:    0010:[set_blocksize+404/544]
May 12 00:15:50 lara kernel: EFLAGS: 00010a87
May 12 00:15:50 lara kernel: eax: 417563c0   ebx: 00000000   ecx: c11956bc   edx
: 00000000
May 12 00:15:50 lara kernel: esi: 417563c0   edi: c17563c0   ebp: c11956a0   esp
: c356fda0
May 12 00:15:50 lara kernel: ds: 0018   es: 0018   ss: 0018
May 12 00:15:50 lara kernel: Process find (pid: 2127, stackpage=c356f000)
May 12 00:15:50 lara kernel: Stack: c11956a0 c11956bc 00000000 00000002 00000000
 00000003 c0126883 c11956a0 
May 12 00:15:50 lara kernel:        00000000 00000000 00000009 00001605 00101594
 00000000 00000002 00000000 
May 12 00:15:50 lara kernel:        00000000 00000000 00000002 00000000 00009338
 00000000 c012e19c 00000003 
May 12 00:15:50 lara kernel: Call Trace: [kmalloc+115/144] [dentry_open+140/336]
 [sys_close+46/96] [ext2_new_block+633/1824] [ext2_new_block+576/1824] 
May 12 00:15:50 lara kernel: Code: 8b 76 28 8b 50 18 8b 40 10 83 e2 46 09 d0 0f 
85 b0 00 00 00 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 76 28                  mov    0x28(%esi),%esi
Code;  00000003 Before first symbol
   3:   8b 50 18                  mov    0x18(%eax),%edx
Code;  00000006 Before first symbol
   6:   8b 40 10                  mov    0x10(%eax),%eax
Code;  00000009 Before first symbol
   9:   83 e2 46                  and    $0x46,%edx
Code;  0000000c Before first symbol
   c:   09 d0                     or     %edx,%eax
Code;  0000000e Before first symbol
   e:   0f 85 b0 00 00 00         jne    c4 <_EIP+0xc4> 000000c4 Before first sy
mbol


1 warning issued.  Results may not be reliable.

--_=XFMail.1.4.0.Linux:010512014854:2713=_--
End of MIME message
