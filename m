Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132579AbRDHRjN>; Sun, 8 Apr 2001 13:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132578AbRDHRjD>; Sun, 8 Apr 2001 13:39:03 -0400
Received: from pop.gmx.net ([194.221.183.20]:26628 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132576AbRDHRir>;
	Sun, 8 Apr 2001 13:38:47 -0400
Message-ID: <3AD0A38A.FB1FB9DB@gmx.at>
Date: Sun, 08 Apr 2001 19:44:42 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: UDMA(66) drive coming up as UDMA(33)?
In-Reply-To: <986664971.1224.4.camel@bugeyes.wcu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David St.Clair" wrote:
> 
> I'm trying to get my hard drive to use UDMA/66.  I'm thinking the cable
> is not being detected.  When the HPT366 bios is set to UDMA 4; using

I think that should be UDMA 5 for 66? As far as I can remember UDMA4 is 33MHz with S.M.A.R.T. which
add some reporting functionality. But I might be wrong...

> hdparm -t, I get a transfer rate of 19.51 MB/s. When the HPT366 bios is
> set to PIO 4 the transfer rate is the same. Is this normal for a UDMA/66
> drive? What makes me think something is wrong is that the log says
> 
> "ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio" <-- PIO?
> 
> and
> 
> "hde: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63,
> UDMA(33)" <--- UDMA(33)? shouldn't it be UDMA(66)?

I got (kernel 2.2.18):

HPT370: IDE controller on PCI bus 00 dev 98
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:pio

hda and hdc are my hd's. My mainboard is a Abit KT7-RAID.

> 
> Any ideas what might be wrong? Possible bug?

I would set the UDMA5 for the HDs in the HPT bios.

good luck,
Wilfried
