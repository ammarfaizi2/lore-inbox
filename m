Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWGaNSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWGaNSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWGaNSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:18:02 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:13542 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751183AbWGaNSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:18:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uio5HM27xXLm+Qnm4x5inNtgqfXTf93t+n8t/lg3vetdaYSOj1KBd6P6JBwqLbvWsNmhGcEXG9tWP4PyR1yzfRDcQOzopBiQwfVZqNFpB3mopnnce8vmSF3fZeyFClMlSnCqRD9u55/UdPK1aYHt0EJnAeJOHAuCfVsAcPtBCtE=
Message-ID: <3b2bc9d0607310617p21552cc8xba66f935b9ec73bd@mail.gmail.com>
Date: Mon, 31 Jul 2006 15:17:54 +0200
From: "marco gaddoni" <marco.gaddoni@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fwd: PROBLEM: ide messages during boot caused by a strange partition table
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1154343947.7230.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3b2bc9d0607302313p637ce780sf98b1727213bd6a2@mail.gmail.com>
	 <3b2bc9d0607302316s68734797r212e0a422ed26a50@mail.gmail.com>
	 <1154343947.7230.15.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-31 am 08:16 +0200, ysgrifennodd marco gaddoni:
> > hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> > hda: task_in_intr: error=0x10 { SectorIdNotFound },
> > LBAsect=1052835654, high=62, low=12648262, sector=1052835654
>
> The sector number appears valid for the drive (assuming the drive
> 9733 255 63 geometry is correct), so that looks like a bad block on the
> disk and nothing to do with partition tables.
>
>
thank you for your reply.
maybe this is a concidence, but i saw the problem the first
boot of linux after the (attempted) dos installation.

the disk is this

/dev/hda:

 Model=SAMSUNG SP0802N, FwRev=TK100-23, SerialNo=0709J1FW500608
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156368016
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-7 T13 1532D revision 0:  ATA/ATAPI-1
ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6
ATA/ATAPI-7

 * signifies the current active mode

is it correct that the max lba sect is LBAsects=156368016 and the kernel
is asking for 1052835654, 10 times more ?
