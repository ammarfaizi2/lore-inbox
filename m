Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279277AbRLHM1F>; Sat, 8 Dec 2001 07:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279317AbRLHM04>; Sat, 8 Dec 2001 07:26:56 -0500
Received: from leary.csoft.net ([63.111.22.80]:40640 "HELO mail63.csoft.net")
	by vger.kernel.org with SMTP id <S279277AbRLHM0o>;
	Sat, 8 Dec 2001 07:26:44 -0500
Message-ID: <002a01c17fe3$8ae2d5f0$3200a8c0@KRYTEN>
From: "Rob Fulton" <rob@cow-frenzy.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Bad EIP value on 2.4.16
Date: Sat, 8 Dec 2001 12:25:55 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0027_01C17FE3.7C02DA30"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0027_01C17FE3.7C02DA30
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I have just installed a vanilla 2.4.16 kernel onto a redhat 7.1 system.
After compiling and rebooting, I realised I was missing something so went
and re-configured the kernel and started the compile again. I then got loads
of errors and the make crashed.It was running fine with 2.4.8 prior to this.

Below is one of the errors in my messages file!

Dec  8 12:20:09 scutter kernel: Unable to handle kernel paging request at
virtl address 0000b600
Dec  8 12:20:09 scutter kernel:  printing eip:
Dec  8 12:20:09 scutter kernel: 0000b600
Dec  8 12:20:09 scutter kernel: *pde = 00000000
Dec  8 12:20:09 scutter kernel: Oops: 0000
Dec  8 12:20:09 scutter kernel: CPU:    0
Dec  8 12:20:09 scutter kernel: EIP:    0010:[<0000b600>]    Not tainted
Dec  8 12:20:09 scutter kernel: EFLAGS: 00010202
Dec  8 12:20:09 scutter kernel: eax: 00000001   ebx: c02b2e40   ecx:
000000b6 edx: cc802000
Dec  8 12:20:09 scutter kernel: esi: 000000b6   edi: c6e77268   ebp:
c8589b40 esp: c5a67e98
Dec  8 12:20:09 scutter kernel: ds: 0018   es: 0018   ss: 0018
Dec  8 12:20:09 scutter kernel: Process make (pid: 2275, stackpage=c5a67000)
Dec  8 12:20:09 scutter kernel: Stack: c10333c0 c011de3d c02b2e40 00000001
08099f 00000000 c8589b40 c6ecfe60
Dec  8 12:20:09 scutter kernel:        c011e0bb c8589b40 c6ecfe60 0809a99f
c6e268 0000b600 00000000 c6e796e4
Dec  8 12:20:09 scutter kernel:        00000011 c5a66560 c6e796e4 c5a66560
c5afc4 c010693d 00000011 c5a66000
Dec  8 12:20:09 scutter kernel: Call Trace: [do_swap_page+125/224]
[handle_mm_ult+107/192] [handle_signal+125/256] [do_page_fault+394/1232]
[getname+94/160]Dec  8 12:20:09 scutter kernel:    [__user_walk+65/80]
[sys_stat64+20/112] [doage_fault+0/1232] [error_code+52/60]
Dec  8 12:20:09 scutter kernel:
Dec  8 12:20:09 scutter kernel: Code:  Bad EIP value.

A few minutes later I got an error that init had crashed and so the kernel
crashed! Every time after I rebooted I got this error whil the drives were
being fscked. I have attached my config file for the kernel and a copy of
dmesg.

regards

Rob Fulton

------=_NextPart_000_0027_01C17FE3.7C02DA30
Content-Type: text/plain;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
request_module[parport_lowlevel]: Root fs not mounted
lp: driver loaded but no devices found
block: 128 slots per queue, batch=3D32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
PDC20268: IDE controller on PCI bus 00 dev a0
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xfebf0000
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER =
Mode.
    ide2: BM-DMA at 0xef60-0xef67, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xef68-0xef6f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DPTA-372050, ATA DISK drive
hde: MAXTOR 6L040L2, ATA DISK drive
hdg: Maxtor 32049H2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xeff0-0xeff7,0xefe6 on irq 5
ide3 at 0xefa8-0xefaf,0xefe2 on irq 5
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=3D2495/255/63, =
UDMA(33)
hde: 78177792 sectors (40027 MB) w/1820KiB Cache, CHS=3D77557/16/63, =
UDMA(100)
hdg: 40021632 sectors (20491 MB) w/2048KiB Cache, CHS=3D39704/16/63, =
UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
 hde: unknown partition table
 hdg: [PTBL] [2491/255/63] hdg1 hdg2
8139too Fast Ethernet driver 0.9.22
eth0: RealTek RTL8139 Fast Ethernet at 0xcc800e00, 00:40:95:30:73:83, =
IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
SCSI subsystem driver Revision: 1.00
scsi0 : AdvanSys SCSI 3.3G: PCI Ultra: IO 0xE800-0xE80F, IRQ 0xA
  Vendor: YAMAHA    Model: CRW8824S          Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
md: raid1 personality registered as nr 3
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding Swap: 136512k swap-space (priority -1)
Adding Swap: 136512k swap-space (priority -2)
eth0: Setting 100mbps full-duplex based on auto-negotiated partner =
ability 45e1.
------=_NextPart_000_0027_01C17FE3.7C02DA30
Content-Type: application/octet-stream;
	name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

CONFIG_EXPERIMENTAL=y

CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

CONFIG_PNP=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_MD_MULTIPATH=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y

CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_SCSI_ADVANSYS=y
CONFIG_NETDEVICES=y

CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y

------=_NextPart_000_0027_01C17FE3.7C02DA30--

