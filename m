Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316721AbSE3PW6>; Thu, 30 May 2002 11:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSE3PW6>; Thu, 30 May 2002 11:22:58 -0400
Received: from pl204.dhcp.adsl.tpnet.pl ([217.98.31.204]:1664 "EHLO
	bzzzt.slackware.pl") by vger.kernel.org with ESMTP
	id <S316721AbSE3PWz>; Thu, 30 May 2002 11:22:55 -0400
Date: Thu, 30 May 2002 17:24:39 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
X-X-Sender: <pkot@bzzzt.slackware.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [2.4.19-pre9] DMA not available
Message-ID: <Pine.LNX.4.33.0205301702310.139-100000@bzzzt.slackware.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't enable DMA with 2.4.19-pre9 with my Dell laptop:
root@bzzzt:~# hdparm -d 1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

dmesg shows the following error:
PIIX4: (ide_setup_pci_device:) Could not enable device.

There were no problems regarding it with 2.4.18 kernel.

Information about the harddisk:
root@bzzzt:~# hdparm -i /dev/hda

/dev/hda:

 Model=HITACHI_DK23CA-30, FwRev=00H0A0G1, SerialNo=11GMEC
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=36477, SectSize=579, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=58605120
 IORDY=yes, tPIO={min:400,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 3:  1 2 3 4 5

Other info (all commands executed on 2.4.19-pre9):
kernel config:	http://tfuj.pl/info/.config
lspci -vvv:	http://tfuj.pl/info/lspci
dmesg:		http://tfuj.pl/info/dmesg
/proc/pci:	http://tfuj.pl/info/procpci

Any other info needed?

pkot
-- 
Pawel Kot <pkot@linuxnews.pl>
http://www.gnokii.org/ :: http://www.slackware.pl/
http://kt.linuxnews.pl/ -- Kernel Traffic po polsku

