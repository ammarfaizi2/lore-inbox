Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSFIQZj>; Sun, 9 Jun 2002 12:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSFIQZj>; Sun, 9 Jun 2002 12:25:39 -0400
Received: from mail026.mail.bellsouth.net ([205.152.58.66]:35389 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S313190AbSFIQZi>; Sun, 9 Jun 2002 12:25:38 -0400
Message-ID: <3D03817B.DA1C5217@bellsouth.net>
Date: Sun, 09 Jun 2002 12:25:31 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Oops 2.5.21 loading ide-scsi module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,
Problems with ide-85 changes and ide-scsi module.

ksymoops 2.4.5 on i686 2.5.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.21/ (default)
     -m /System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 616d6475
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<616d6475>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000000   ecx: c0321790   edx: c0302cd4
esi: c02b0000   edi: c03216c0   ebp: c03217ec   esp: c02b1f2c
ds: 0018   es: 0018   ss: 0018
Stack: c01d37ce c03217ec cff46cc0 616d6475 00000292 cff4bb00 04000001 0000000e 
       c02b1f98 c010a829 0000000e c03216c0 c02b1f98 c02b0000 0000000e c02b0000 
       c02f3c80 c010aa0b 0000000e c02b1f98 cff4bb00 cff4bb00 c02b0000 c02b0000 
Call Trace: [<c01d37ce>] [<c010a829>] [<c010aa0b>] [<c0106f60>] [<c010941e>] 
   [<c0106f60>] [<c0106f60>] [<c0106f87>] [<c0107006>] [<c0105000>] 
Code:  Bad EIP value.


>>EIP; 616d6475 Before first symbol   <=====

>>ecx; c0321790 <ide_hwifs+d0/3bd8>
>>edx; c0302cd4 <tv2+194/220>
>>esi; c02b0000 <init_thread_union+0/2000>
>>edi; c03216c0 <ide_hwifs+0/3bd8>
>>ebp; c03217ec <ide_hwifs+12c/3bd8>
>>esp; c02b1f2c <init_thread_union+1f2c/2000>

Trace; c01d37ce <ata_irq_request+de/170>
Trace; c010a829 <handle_IRQ_event+39/70>
Trace; c010aa0b <do_IRQ+8b/110>
Trace; c0106f60 <default_idle+0/30>
Trace; c010941e <common_interrupt+22/28>
Trace; c0106f60 <default_idle+0/30>
Trace; c0106f60 <default_idle+0/30>
Trace; c0106f87 <default_idle+27/30>
Trace; c0107006 <cpu_idle+36/40>
Trace; c0105000 <_stext+0/0>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_IVB=y
CONFIG_ATAPI=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=32
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
