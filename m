Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132652AbRDGOEo>; Sat, 7 Apr 2001 10:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132653AbRDGOEe>; Sat, 7 Apr 2001 10:04:34 -0400
Received: from front6m.grolier.fr ([195.36.216.56]:49091 "EHLO
	front6m.grolier.fr") by vger.kernel.org with ESMTP
	id <S132652AbRDGOEY>; Sat, 7 Apr 2001 10:04:24 -0400
Message-ID: <3ACF1BDA.E731D9FF@club-internet.fr>
Date: Sat, 07 Apr 2001 15:53:30 +0200
From: Alexandre et/ou Sophie Beneteau <a_benet@club-internet.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel panic when trying to mount a scsi cdrom.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

 Kernel panic when trying to mount a scsi cdrom.
 
[2.] Full description of the problem/report:

Since version 2.4.2, I get a kernel panic everytime I try to mount an
iso9660 cdrom :

# mount /dev/scd0 /cdrom
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x write cd/rw xa/form2 cdda tray
mount: block device /dev/scd0 is write-protected, mounting read-only
sr: ran out of meme for scatter pad
Kernel panic: scsi_free: Bad offset

(typed by hand, since the system is frozen at this point of the
operation :-) )

No problem when I read a cd-rom (with cdparanoia, cdrecord or cdrdao)
nor when I write a cd/r cd/rw, nor when I listen a cd-audio....

[3.] Keywords (i.e., modules, networking, kernel):

scsi, kernel panic, mount

[4.] Kernel version (from /proc/version):

Linux version 2.4.3 (root@casimir) (gcc version 2.95.3 19991030
(prerelease)) #2 Sat Mar 31 19:34:40 CEST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

NO OOPS

[6.] A small shell script or example program which triggers the
     problem (if possible)

mount /dev/scd0 /cdrom

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux casimir 2.4.3 #2 Sat Mar 31 19:34:40 CEST 2001 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.0.24
util-linux             2.11b
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        1.3.so
awk: cmd. line:2: (FILENAME=- FNR=2) fatal: attempt to access field -1
Dynamic linker (ldd)   2.1.3
Linux C++ Library      2.8.0
Linux C++ Library      ..
Procps                 2.0.7
Net-tools              1.50
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         ne 8390

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 2
model name      : 6x86 2x Core/Bus Clock
stepping        : 5
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : yes
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu cyrix_arr
bogomips        : 119.60

[7.3.] Module information (from /proc/modules):

ne                      6704   1 (autoclean)
8390                    6192   0 (autoclean) [ne]

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0213-0213 : isapnp read
0240-025f : eth0
02f8-02ff : serial(set)
03c0-03df : vga+
  03c0-03df : matrox
03f6-03f6 : ide0
03f8-03ff : serial(set)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cbfff : Extension ROM
000f0000-000fffff : System ROM
00100000-04ffffff : System RAM
  00100000-001bc34d : Kernel code
  001bc34e-001fe5bf : Kernel data
fa800000-faffffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
fb7ec000-fb7effff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
  fb7ec000-fb7effff : matroxfb MMIO
fb800000-fbffffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
  fb800000-fbffffff : matroxfb FB
e800-e80f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]

[7.5.] PCI information ('lspci -vvv' as root)

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model: CD-R/RW RW7060S  Rev: 1.20
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

proc/scsi/sg : 

debug : dev_max(currently)=7 max_active_device=1 (origin 1)
 scsi_dma_free_sectors=160 sg_pool_secs_aval=320 def_reserved_size=32768


host_strs : Adaptec 1542

hosts : 820     0       1       16      1       0

version : 30117   Version: 3.1.17 (20001002)


[X.] Other notes, patches, fixes, workarounds:

Feel free to ask me whatever information you would need to investigate
the problem... Thanks :-)

	Alex.

