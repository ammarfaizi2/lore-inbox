Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbQKSM7j>; Sun, 19 Nov 2000 07:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbQKSM73>; Sun, 19 Nov 2000 07:59:29 -0500
Received: from lima.epix.net ([199.224.64.56]:11231 "EHLO lima.epix.net")
	by vger.kernel.org with ESMTP id <S129742AbQKSM7V>;
	Sun, 19 Nov 2000 07:59:21 -0500
Message-ID: <3A17C845.1A9845E9@epix.net>
Date: Sun, 19 Nov 2000 07:32:05 -0500
From: Tony Spinillo <tspin@epix.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: isofs crash on 2.4.0-test11-pre7 [1.] MAINTAINERS: ISO 
 FILESYSTEM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same problem as Vincent - OOPs when "ls" a mounted cdrom. It did work
once with a CD-R. My report symptoms are nearly identical to previous
post with same subject heading with a few differences:

[4.] Kernel version (from /proc/version):
Linux version 2.4.0-test11 (root@svcr-adsl) (gcc driver version 2.95.3
19991030 (prerelease) executing gcc version egcs-2.91.66) #4 Sun Nov 19
02:00:43 EST 2000  

7.] Environment 
[7.1.] Software (add the output of the ver_linux script here) 
 ./ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux svcr-adsl-205-238-237-43 2.4.0-test11 #4 Sun Nov 19 02:00:43 EST
2000 i686 unknown
Kernel modules         2.3.17
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         NVdriver vmnet vmmon 3c59x tulip  

[7.2.] Processor information (from /proc/cpuinfo): 
 cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 871.000033
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1736.70    

7.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem

 cat /proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
a000-a01f : Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B)
a400-a41f : Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A)
a800-a80f : Intel Corporation 82820 820 (Camino 2) Chipset IDE U100
b000-dfff : PCI Bus #02
  b400-b43f : 3Com Corporation 3c905 100BaseTX [Boomerang]
    b400-b43f : eth1
  b800-b83f : Ensoniq ES1371 [AudioPCI-97]
    b800-b83f : es1371
  d000-d03f : Advanced System Products, Inc ABP940-UW
    d000-d03f : advansys
  d400-d4ff : Lite-On Communications Inc LNE100TX
    d400-d4ff : eth0
  d800-d8ff : PCI device 10cd:2500 (Advanced System Products, Inc)
e400-e403 : acpi
e404-e405 : acpi
e408-e40b : acpi
e428-e42b : acpi
e800-e80f : Intel Corporation 82820 820 (Camino 2) Chipset SMBus 

 cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cffff : Extension ROM
000d0000-000d3fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeafff : System RAM
  00100000-002a7147 : Kernel code
  002a7148-002c35e3 : Kernel data
1ffeb000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
ec800000-edffffff : PCI Bus #02
  ec800000-ec8000ff : Advanced System Products, Inc ABP940-UW
  ed000000-ed0000ff : Lite-On Communications Inc LNE100TX
    ed000000-ed0000ff : eth0
  ed800000-ed8000ff : PCI device 10cd:2500 (Advanced System Products,
Inc)
ee000000-efdfffff : PCI Bus #01
  ee000000-eeffffff : nVidia Corporation NV15 Bladerunner (Geforce2 GTS)
efe00000-efefffff : PCI Bus #02
eff00000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation NV15 Bladerunner (Geforce2 GTS)
f8000000-fbffffff : PCI device 8086:1130 (Intel Corporation)
ffff0000-ffffffff : reserved   

[7.6.] SCSI information (from /proc/scsi/scsi) 
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: S80K
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TW   Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 250          Rev: H.41
  Type:   Direct-Access                    ANSI SCSI revision: 02   

[X.] Other notes, patches, fixes, workarounds:
When trying to ls on cdrom mounted on scsi1 (Plextor CD-ROM), mount goes
okay. "ls" /mnt/cdrom results in
"oops" - same as a previous post. The ls did work
once with a cdr disc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
