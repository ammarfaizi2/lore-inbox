Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRCOQmN>; Thu, 15 Mar 2001 11:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131683AbRCOQmE>; Thu, 15 Mar 2001 11:42:04 -0500
Received: from md.aacisd.com ([64.23.207.34]:51729 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S131408AbRCOQlq>;
	Thu, 15 Mar 2001 11:41:46 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D6718A8@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Hardware problem detection? Linux 2.4.3-pre4 lockups.
Date: Thu, 15 Mar 2001 11:35:48 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0AD6D.FD9D7850"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0AD6D.FD9D7850
Content-Type: text/plain;
	charset="iso-8859-1"


I am at a total loss, But I have found some interesting anomalies with my
hardware. 

My Current Setup:
Supermicro S370DE6 (Serverworks Chipset)
Dual PIII 866
2 x 256 MB PC133 ECC SDRAM
onboard AIC 7899 SCSI Controller.
36G,73GB Seagate Cheetah Drive.
Voodoo4 4500 AGP video,
Fore PCA 200e ATM 


Problem, I have a program the can read a file(large, or small) it will then
transmit the data over atm, ethernet, localhost,or write to a file.

I have noticed that the machine will consistently crash(hard lockup) when I
do a read loop of the File. It never locks up at the same place, and I have
changed it so that it never actually does anything with the data after it
reads. Still, same result.

Things that have "fixed" the problem. Setting the FSB to 100(jumpered) will
allow me to run forever.
Also, Setting the L1 Cache to Write-through instead of write back will allow
me to run forever at 133, but the performance hit is worse than setting the
FSB to 100. 

Another note. When I have attempted to compile the kernel for Uni processor.
I started getting segmentation faults with gcc.
Now this tells me it might be the processor. But I have nothing overclocked,
so I would think that it might be some kind of timing issue in the kernel.

I have two machines set up this way. One is much more stable. But I do
observe the occasional crash.(hard lockup) 

I have also seen fsck crash as well. when the system was not shut down
correctly. ( as a hard lockup happens very frequently.)

Here are some things that I have tried, but Have not fixed it.
1) SMP Kernel with "noapic" at lilo prompt ( and without the noapic)
2) Uni Kernel w/ & w/out apic

I am at a total loss. 
Is there anything I can do(other than run at 100 FSB)?

Nathan

P.S. I have enclosed the dmesg output for my Uniprocessor kernel
 <<dmesg.out.uni>> 



------_=_NextPart_000_01C0AD6D.FD9D7850
Content-Type: application/octet-stream;
	name="dmesg.out.uni"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.out.uni"

Linux version 2.4.3-pre4 (root@aacrecorder2.aacisd.com) (gcc version =
2.95.3 19991030 (prerelease)) #5 Thu Mar 15 09:01:35 EST 2001=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)=0A=
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)=0A=
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)=0A=
 BIOS-e820: 000000001ff00000 @ 0000000000100000 (usable)=0A=
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)=0A=
 BIOS-e820: 0000000000001000 @ 00000000fec01000 (reserved)=0A=
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)=0A=
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)=0A=
On node 0 totalpages: 131072=0A=
zone(0): 4096 pages.=0A=
zone(1): 126976 pages.=0A=
zone(2): 0 pages.=0A=
Kernel command line: auto BOOT_IMAGE=3Duni-2.4.3 ro root=3D807=0A=
Initializing CPU#0=0A=
Detected 866.303 MHz processor.=0A=
Console: colour VGA+ 80x25=0A=
Calibrating delay loop... 1730.15 BogoMIPS=0A=
Memory: 513216k/524288k available (1115k kernel code, 10684k reserved, =
400k data, 220k init, 0k highmem)=0A=
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)=0A=
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)=0A=
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)=0A=
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D =
0=0A=
CPU: L1 I cache: 16K, L1 D cache: 16K=0A=
CPU: L2 cache: 256K=0A=
Intel machine check architecture supported.=0A=
Intel machine check reporting enabled on CPU#0.=0A=
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000=0A=
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000=0A=
CPU: Common caps: 0383fbff 00000000 00000000 00000000=0A=
CPU: Intel Pentium III (Coppermine) stepping 06=0A=
Enabling fast FPU save and restore... done.=0A=
Enabling unmasked SIMD FPU exception support... done.=0A=
Checking 'hlt' instruction... OK.=0A=
POSIX conformance testing by UNIFIX=0A=
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)=0A=
mtrr: detected mtrr type: Intel=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=3D2=0A=
PCI: Using configuration type 1=0A=
PCI: Probing PCI hardware=0A=
PCI: Discovered primary peer bus 02 [IRQ]=0A=
PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0=0A=
PCI: Cannot allocate resource region 1 of device 00:00.0=0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Starting kswapd v1.8=0A=
pty: 256 Unix98 ptys configured=0A=
block: queued sectors max/low 341114kB/210042kB, 1024 slots per =
queue=0A=
Uniform Multi-Platform E-IDE driver Revision: 6.31=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79=0A=
ServerWorks OSB4: chipset revision 0=0A=
ServerWorks OSB4: not 100% native mode: will probe irqs later=0A=
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio=0A=
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio=0A=
Floppy drive(s): fd0 is 1.44M=0A=
FDC 0 is a National Semiconductor PC87306=0A=
fore200e: FORE Systems 200E-series driver - version 0.2g=0A=
PCI: Found IRQ 11 for device 00:04.0=0A=
fore200e: device PCA-200E found at 0xfe600000, IRQ 11=0A=
fore200e: device PCA-200E-0 self-test passed=0A=
fore200e: device PCA-200E-0 firmware started=0A=
fore200e: device PCA-200E-0 initialized=0A=
fore200e: device PCA-200E-0, rev. A, S/N: 28273, ESI: =
00:20:48:64:6e:71=0A=
fore200e: IRQ 11 reserved for device PCA-200E-0=0A=
NTFS version 000607=0A=
udf: registering filesystem=0A=
Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled=0A=
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A=0A=
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A=0A=
Real Time Clock Driver v1.10d=0A=
eepro100.c:v1.09j-t 9/29/99 Donald Becker =
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html=0A=
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. =
Savochkin <saw@saw.sw.com.sg> and others=0A=
PCI: Found IRQ 9 for device 00:06.0=0A=
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:30:48:10:95:39, =
IRQ 9.=0A=
  Receiver lock-up bug exists -- enabling work-around.=0A=
  Board assembly 000000-000, Physical connectors present: RJ45=0A=
  Primary interface chip i82555 PHY #1.=0A=
  General self-test: passed.=0A=
  Serial sub-system self-test: passed.=0A=
  Internal registers self-test: passed.=0A=
  ROM checksum self-test: passed (0x04f4518b).=0A=
  Receiver lock-up workaround activated.=0A=
[drm] Initialized tdfx 1.0.0 20000928 on minor 63=0A=
SCSI subsystem driver Revision: 1.00=0A=
PCI: Found IRQ 10 for device 00:05.1=0A=
PCI: Found IRQ 5 for device 00:05.0=0A=
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5=0A=
        <Adaptec aic7899 Ultra160 SCSI adapter>=0A=
        aic7899: Wide Channel A, SCSI Id=3D7, 32/255 SCBs=0A=
=0A=
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5=0A=
        <Adaptec aic7899 Ultra160 SCSI adapter>=0A=
        aic7899: Wide Channel B, SCSI Id=3D7, 32/255 SCBs=0A=
=0A=
  Vendor: SEAGATE   Model: ST336704LWV       Rev: 4301=0A=
  Type:   Direct-Access                      ANSI SCSI revision: 03=0A=
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0=0A=
  Vendor: SEAGATE   Model: ST173404LW        Rev: 0004=0A=
  Type:   Direct-Access                      ANSI SCSI revision: 03=0A=
Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0=0A=
scsi0:0:0:0: Tagged Queuing enabled.  Depth 253=0A=
scsi0:0:2:0: Tagged Queuing enabled.  Depth 253=0A=
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.00=0A=
  Type:   CD-ROM                             ANSI SCSI revision: 02=0A=
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 4, lun 0=0A=
(scsi1:A:4): 20.000MB/s transfers (20.000MHz, offset 16)=0A=
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray=0A=
Uniform CD-ROM driver Revision: 3.12=0A=
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)=0A=
SCSI device sda: 71687369 512-byte hdwr sectors (36704 MB)=0A=
Partition check:=0A=
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >=0A=
(scsi0:A:2): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)=0A=
SCSI device sdb: 143374738 512-byte hdwr sectors (73408 MB)=0A=
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 >=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP, IGMP=0A=
IP: routing cache hash table of 4096 buckets, 32Kbytes=0A=
TCP: Hash tables configured (established 32768 bind 32768)=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
VFS: Mounted root (ext2 filesystem) readonly.=0A=
Freeing unused kernel memory: 220k freed=0A=
Adding Swap: 1044184k swap-space (priority -1)=0A=
mtrr: type mismatch for e0000000,4000000 old: uncachable new: =
write-combining=0A=
mtrr: type mismatch for e0000000,4000000 old: uncachable new: =
write-combining=0A=
mtrr: type mismatch for e0000000,4000000 old: uncachable new: =
write-combining=0A=
mtrr: type mismatch for e0000000,4000000 old: uncachable new: =
write-combining=0A=

------_=_NextPart_000_01C0AD6D.FD9D7850--
