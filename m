Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSE1Kek>; Tue, 28 May 2002 06:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSE1Kej>; Tue, 28 May 2002 06:34:39 -0400
Received: from fep01.tuttopmi.it ([212.131.248.100]:25779 "EHLO
	fep01-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S313477AbSE1Kei>; Tue, 28 May 2002 06:34:38 -0400
Subject: Re: Kernel (2.4.19-pre8) hang
From: Frederik Nosi <fredi@e-salute.it>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1022534650.11859.316.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 May 2002 12:43:56 +0200
Message-Id: <1022582637.1565.20.camel@linux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il lun, 2002-05-27 alle 23:24, Alan Cox ha scritto:
> On Mon, 2002-05-27 at 20:24, Frederik Nosi wrote:
> > May 27 18:28:13 linux kernel: EXT3-fs error (device ide0(3,7)):
> > ext3_free_blocks: bit already cleared for block 215665
> > 
> > I suspect at my hd too but for being sure... Please CC me because I'm
> > not subscribed to the list and excuse me for my bad english and the long
> > mail.
> 
> What mode is your hard disk reported to be in. If it is using UDMA then
> its very unlikely to be the disk itself. We also should now have all the
> needed workarounds for VIA chipset bugs.

Well, the thing that makes me suspect of an hardware problem is that
with the very same kernel (and with ide0=ata66 option stupidly settet by
me for "using all hardware's power" and witch I have disabled from the
first problems I had) the pc worked happily from the 2.4.19-pre8 release
day till 3 or for days ago. In bios I've set PIO 4 && (U?)DMA 2. My
chipset is kx133 (mainboard: asus k7v-rm), CPU athlon 700 (not
overclocked) and the disk is a quantum 15Gb. I dont know what cabling is
used to connect the hd because I dont know to distinguish 80pin from
40pin. I've been using this hardware from 2 years and this is the first
"strange" problem. I've seen too that this problem happens expecialy in
massively writes to disk (for swapping ecc). Maybe this is useful:

#cat /proc/ide/ide0/hda/settings
name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                1826            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        8               0               255             rw
bswap                   0               0               1               r
current_speed           68              0               69              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
ide_scsi                0               0               1               rw
init_speed              12              0               69              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      128             1               255             rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               1               0               1               rw
wcache                  0               0               1               rw

#cat /proc/ide/ide0/hda/driver
ide-disk version 1.12

If you need more information I'll be happy to give that.

Well, did I have to buy a new hd ? :)

> Has this box been stable with older kernels ?

I think so

> 
> Alan
> 
Thank you for your time,
Fredi.

