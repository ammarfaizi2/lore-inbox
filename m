Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135905AbRDTSeA>; Fri, 20 Apr 2001 14:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135915AbRDTSdm>; Fri, 20 Apr 2001 14:33:42 -0400
Received: from chmls20.mediaone.net ([24.147.1.156]:3476 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S135922AbRDTSda>; Fri, 20 Apr 2001 14:33:30 -0400
From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Fri, 20 Apr 2001 14:29:28 -0400
To: linux-kernel@vger.kernel.org
Subject: machine hangs during Ghost multicast traffic
Message-ID: <20010420142928.A27544@pimlott.ne.mediaone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I periodically experience major system slowdowns, which are
obviously network related because they instantly go away when I pull
out the network cable, and return when I put it back in.  The
machine is not totally unresponsive, but nearly so.  For example, if
I hit enter at a shell prompt, it may be ten seconds or more before
a new prompt appears.

When I run tcpdump during these episodes (I have to pull out the
network cord to start tcpdump, then plug it in, then pull it out
again I see any results), I always see entries like:

13:56:24.671684 host.example.com.1726 > 224.77.34.185.7777:  udp 1464 [ttl 1]

I believe this is traffic from Norton Ghost; I found some technical
documentation at
http://service1.symantec.com/SUPPORT/ghost.nsf/docid/1999033015222425

The NIC is a 3Com PCMCIA card.  dmesg says

3c574_cs.c v1.08 9/24/98 Donald Becker/David Hinds, becker@cesdis.gsfc.nasa.gov.
eth0: Megahertz 574B at io 0x300, irq 5, hw_addr 00:00:86:5E:E3:D9.
  ASIC rev 1, 64K FIFO split 1:1 Rx:Tx, autoselect MII interface.

I'm using pcmcia-cs 3.1.22 .  I have seen the problem with kernels
2.2.19 and 2.4.3 (not using the pcmcia support included in 2.4).  I
don't think I have any unusual network options, though I do have
multicast enabled (2.2.19 .config at end).  I don't see any log
messages (other than link beat messages from plugging in and out the
network cord), and everything returns to normal after Ghost is
finished.

Can anyone give me any suggestions?

Thanks,
Andrew

ONFIG_EXPERIMENTAL=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_1GB=y
CONFIG_MTRR=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_OLD_PROC=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_APM=y
CONFIG_TOSHIBA=m
CONFIG_PNP=y
CONFIG_PNP_PARPORT=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_PARIDE_PARPORT=m
CONFIG_PACKET=m
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_PRINTER_READBACK=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_SMB_FS=m
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_YMFPCI=m
CONFIG_MAGIC_SYSRQ=y

