Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUAYTXb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUAYTXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:23:30 -0500
Received: from intra.cyclades.com ([64.186.161.6]:10966 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265206AbUAYTXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:23:09 -0500
Date: Sun, 25 Jan 2004 17:20:46 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Gabor Z. Papp" <gzp@papp.hu>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Linux 2.4.25-pre7 - no DRQ after issuing WRITE
In-Reply-To: <x6ptd8l7so@gzp>
Message-ID: <Pine.LNX.4.58L.0401251714400.1311@logos.cnet>
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet> <x6ptd8l7so@gzp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Jan 2004, Gabor Z. Papp wrote:

> * Marcelo Tosatti <marcelo.tosatti@cyclades.com>:
>
> | Please help testing! :)
>
> Here we go: http://gzp.odpn.net/tmp/linux-2.4.25-pre7/
>
> The "no DRQ after issuing WRITE" problem with 2 120GB Seagate
> harddisk. I don't think its hw problem, because these disks are fine
> in other environment. More "load" related, without running them in sw
> raid mode, the problem doesn't hit me so quickly.

Hi Gabor,

I'm not IDE expert, but these errors look like hardware fault for me
(Bartlomiej CCed).

What about 2.6 and older 2.4 kernels on the same hardware ?

-------------
Mounted devfs on /dev
Freeing unused kernel memory: 116k freed
hde: dma_timer_expiry: dma status == 0x21
hdg: dma_timer_expiry: dma status == 0x21
hde: error waiting for DMA
hde: dma timeout retry: status=0x7f { DriveReady DeviceFault SeekComplete
DataRequest CorrectedError Index Error }
hde: dma timeout retry: error=0x7f { DriveStatusError UncorrectableError
SectorIdNotFound TrackZeroNotFound AddrMarkNotFound },
LBAsect=9343692930943, high=556927, low=8355711, sector=4352
hde: DMA disabled
hdg: error waiting for DMA
hdg: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest
}
hdg: status error: status=0x50 { DriveReady SeekComplete }
hdg: no DRQ after issuing MULTWRITE
hdg: status timeout: status=0xd0 { Busy }

>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
