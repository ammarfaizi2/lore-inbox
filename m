Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291394AbSBSND4>; Tue, 19 Feb 2002 08:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291393AbSBSNDr>; Tue, 19 Feb 2002 08:03:47 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:38911 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S291450AbSBSNDd>; Tue, 19 Feb 2002 08:03:33 -0500
Date: Tue, 19 Feb 2002 13:57:58 +0100
From: Kristian <kristian.peters@korseby.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre9-ac4 filesystem corruption
Message-Id: <20020219135758.67f7f4c2.kristian.peters@korseby.net>
In-Reply-To: <E16d982-0000LP-00@the-village.bc.nu>
In-Reply-To: <20020219125211.10f80f4e.kristian.peters@korseby.net>
	<E16d982-0000LP-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: Debian GNU/Linux 2.4.17
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > I've seen filesystem corruption using -ac4 with ext2 although I'm not using
> > a SIS chipset. So I really recommend using not this patch.
> 
> The SiS patch is only changing anything if the SiS vode is in use.
> 
> Precisely what chipset, what IDE, what ide cable (40/80 pin) and drives
> do you have. What hdparm commands are you using if any ?

No hdparm settings. 40pin cable and this drive:

$ dmesg|grep hda
    ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:DMA, hdb:DMA
hda: WDC AC24300L, ATA DISK drive
hda: 8421840 sectors (4312 MB) w/256KiB Cache, CHS=557/240/63, UDMA(33)

$ lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 02)
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
00:0f.0 Token ring network controller: IBM 16/4 Token ring UTP/STP controller (r
ev 05)
00:14.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:14.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:14.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:14.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)

Before you ask: I'll test memory later just to be sure.

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :..........................:
