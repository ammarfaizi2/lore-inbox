Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRALLPr>; Fri, 12 Jan 2001 06:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130119AbRALLPi>; Fri, 12 Jan 2001 06:15:38 -0500
Received: from president.eu.org ([194.45.71.67]:29459 "EHLO president.eu.org")
	by vger.kernel.org with ESMTP id <S129511AbRALLP2>;
	Fri, 12 Jan 2001 06:15:28 -0500
Date: Fri, 12 Jan 2001 12:15:19 +0000
From: Hans Freitag <macrotron@president.eu.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: umount /var -> umount: /var: device is busy -- 2.4.0-ac6
Message-ID: <20010112121518.A279@BOFH.president.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Ident: 204D1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


[1.] One line summary of the problem:    
Unable to unmount all filesystems on my LVM 

[2.] Full description of the problem/report:
On shutdown /var couldn't be umounted.
/usr is only possible to remount read only.
I detect this error on kernel release 2.4.0-ac5 and ac6.
2.4.0 works fine.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 2.4.0-ac6 (root@BOFH) (gcc version 2.95.2 19991024 (release)) #1 Fri Jan 12 00:37:16 /etc/localtime 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)

# umount /var
umount: /var: device is busy
     

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):


processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 8
model name	: AMD-K6(tm) 3D processor
stepping	: 12
cpu MHz		: 350.806
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 699.59


[7.3.] Module information (from /proc/modules):


cs4232                  2992   1
ad1848                 16576   0 [cs4232]
uart401                 6224   0 [cs4232]
sound                  56176   1 [cs4232 ad1848 uart401]
soundcore               3952   4 [sound]
bttv                   54896   0 (unused)
msp3400                13104   0 (unused)
tuner                   3248   1
i2c-algo-bit            7104   1 [bttv]
i2c-dev                 3680   0 (unused)
i2c-core               12752   0 [bttv msp3400 tuner i2c-algo-bit i2c-dev]
videodev                4544   2 [bttv]


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)


0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
02f8-02ff : serial(auto)
0340-035f : eth1
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0530-0533 : Crystal audio controller
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : 3Dfx Interactive, Inc. Voodoo 3
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e800-e8ff : Macronix, Inc. [MXIC] MX987x5
  e800-e8ff : eth0


00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00257827 : Kernel code
  00257828-002e2ab7 : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
e0000000-e3ffffff : PCI Bus #01
  e0000000-e1ffffff : 3Dfx Interactive, Inc. Voodoo 3
e4000000-e5ffffff : PCI Bus #01
  e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo 3
e6000000-e6ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e8000000-e80000ff : Macronix, Inc. [MXIC] MX987x5
  e8000000-e80000ff : eth0
e8001000-e8001fff : Brooktree Corporation Bt848 TV with DMA push
  e8001000-e8001fff : bttv
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)


PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=16.  
      Prefetchable 32 bit memory at 0xe6000000 [0xe6ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 71).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0xe000 [0xe00f].
  Bus  0, device   7, function  3:
    Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
  Bus  0, device   9, function  0:
    Ethernet controller: Macronix, Inc. [MXIC] MX987x5 (rev 37).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe80000ff].
  Bus  0, device  10, function  0:
    Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 18).
      IRQ 12.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xe8001000 [0xe8001fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 1).
      IRQ 11.
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe1ffffff].
      Prefetchable 32 bit memory at 0xe4000000 [0xe5ffffff].
      I/O at 0xd000 [0xd0ff].

[7.6.] SCSI information (from /proc/scsi/scsi)


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IDE-CD   Model: R/RW 4x4x32      Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

cat /proc/mounts:

/dev/ide/host0/bus0/target0/lun0/part2 / ext2 rw 0 0
none /dev devfs rw 0 0
proc /proc proc rw 0 0
/dev/discs/disc0/part1 /boot ext2 ro 0 0
/dev/main_vg/usr /usr ext2 rw 0 0
/dev/main_vg/var /var ext2 rw,noexec,nosuid 0 0
/dev/main_vg/home /home ext2 rw 0 0
/dev/main_vg/tmp /tmp ext2 rw,nosuid 0 0


vgdisplay:

--- Volume group ---
VG Name               main_vg
VG Access             read/write
VG Status             available/resizable
VG #                  0
MAX LV                256
Cur LV                5
Open LV               5
MAX LV Size           255.99 GB
Max PV                256
Cur PV                2
Act PV                2
VG Size               50.18 GB
PE Size               4 MB
Total PE              12846
Alloc PE / Size       12846 / 50.18 GB
Free  PE / Size       0 / 0
VG UUID               Wy5Iw0-lQ5T-1Ldu-baV5-O3ZA-4mvf-69JMgA

an fuser -v /var on an escapeshell in shutdownprocess:

                     USER        PID ACCESS COMMAND
/var                 root     kernel mount  /var


[X.] Other notes, patches, fixes, workarounds:

2.4.0 works fine ac5 has the problem with both,
reiserFS-beta and ext2


bye
-- 
W.O.R.L.D.: Worker Optimized for Repair and Logical Destruction
******** PGP/GPG keys available at wwwkeys.eu.pgp.net *********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
