Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289356AbSAVTKa>; Tue, 22 Jan 2002 14:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289357AbSAVTKV>; Tue, 22 Jan 2002 14:10:21 -0500
Received: from imr1.ericy.com ([208.237.135.240]:9943 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S289356AbSAVTKG>;
	Tue, 22 Jan 2002 14:10:06 -0500
Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8301DB7419@eammlnt051.lmc.ericsson.se>
From: "David Gordon (LMC)" <David.Gordon@ericsson.ca>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Ibrahim Haddad (LMC)" <Ibrahim.Haddad@lmc.ericsson.se>
Subject: Consistent 2.4.16 kernel oops
Date: Tue, 22 Jan 2002 14:09:59 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not subscribed to the kernel mailing list, can you please send the
answer to david.gordon@ericsson.ca?

I have experienced repeated and consistent kernel oopses on about 5
different machines with the same hardware and software configuration.
Everytime fsck is run, the kernel panics at about 42.6% of fsck. Booting a
lower version kernel will not create a kernel oops when running fsck.

(By the way, fsck occurs because of another kernel oops, either ssh or
sendmail, but mostly ssh.)

I run:
kernel 2.4.16
RH 7.0 and RH 7.1
256 MB RAM
20 GIG IDE disk
500 MHz Intel

Thank you,

David Gordon
Ericsson Research


***********

EIP:    0010:[<00001100>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: c0268e40     ecx: 00000011       edx: d0804000
esi: 00000011   edi: c159bffc     ebp: c159e080       esp: c1417e24
ds: 0018        es: 0018       ss: 0018
Process init (pid: 1, stackpage=c1417000)
Stack:  c13fe4c0 c011e1ed c0268e40 00000001 bffff838 00000001 c159e080
c159c0c0
        c011e46b c159e080 c159c0c0 bffff838 c159bffc 00001100 00000001
c1417ea8
        c010806c 0000000e c14de060 c1417ea8 c1417ea8 0000000e c025dac0
c1416000
Call Trace: [<c011e1ed>] [<c011e46b>] [<c010806c>] [<c010e32a>] [<c010a248>]
        [<c010ee71>] [<c0138774.} [<c010e1a0>] [<c0106e38>] [<c0138eee>]
[<c0106d47>]
Code:   Bad EIP value.

>>EIP; 00001100 Before first symbol   <=====
Trace; c011e1ed <zap_page_range+fd/200>
Trace; c011e46b <map_user_kiobuf+fb/290>
Trace; c010806c <handle_IRQ_event+3c/70>
Trace; c010e32a <pirq_via_set+1a/20>
Trace; c010a248 <call_do_IRQ+5/d>
Trace; c010ee71 <bust_spinlocks+1/50>

***********

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
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
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_PNP=m
CONFIG_ISAPNP=m
CONFIG_BLK_DEV_FD=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6=y
CONFIG_KHTTPD=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
CONFIG_DRM_RADEON=y
CONFIG_AUTOFS4_FS=y
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFSD=m
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_UHCI_ALT=y


