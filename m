Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRAHUsf>; Mon, 8 Jan 2001 15:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbRAHUsZ>; Mon, 8 Jan 2001 15:48:25 -0500
Received: from pop3.web.de ([212.227.116.81]:12045 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S129669AbRAHUsL>;
	Mon, 8 Jan 2001 15:48:11 -0500
Date: Mon, 8 Jan 2001 21:49:33 +0100
From: Michael Duelli <m.duelli@web.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Duelli <m.duelli@web.de>, linux-kernel@vger.kernel.org
Subject: Re: Ext2 (dma ?) error
Message-ID: <20010108214933.A483@Unimatrix01.surf-callino.de>
In-Reply-To: <20010107214838.A1086@Unimatrix01.surf-callino.de> <E14FMop-0003Ic-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14FMop-0003Ic-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Son, Jan 07, 2001 at 21:53:32 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel hackers,

okay possibly my HD is the problem and I will try to check the disc
with a Seagate tool (damned, i.e. reinstalling Windows) or even
reformating I everything else goes wrong.

Nevertheless I checked the partition with my old SuSE 2.2.16 kernel
and it gave a different error message:

hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x40 { UncorrectableError } LBAsect = 2421754, sector
210048
end_request: I/O error, dev 03:03 (hda), sector 2100448

no more dma but read.
Fortunately it is still under warranty.

Am 2001-01-07, 21:53:32 schrieb(en) Alan Cox:
> > Fsck discovered an error it wasn't able to fix. This error never
> > appeared before and my Seagate HD actually should be alright.
> 
> Umm the error says not
> 
> > hda: dma_intr: status=0x51 { DriveReady SeekCompleteError }
> > hda: dma_intr: error=0x40 { UncorrectableError } LBAsect = 2421754,
> sector
> > 210048
> > end_request: I/O error, dev 03:03 (hda), sector 2100448
> 
> Thats a media error. It may go away if the block is rewritten , on a
> reformat etc. But its the disk reporting a bad block. Now that could be
> a 2.4 artifact (incredibly unlikely) so try fscking with 2.2 just to be
> sure is not an error reporting bug.
> 

_________________________________________
Michael Duelli
m.duelli@web.de
linuxmaths.sourceforge.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
