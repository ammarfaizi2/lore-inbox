Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTFPSel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTFPScw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:32:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64961 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264052AbTFPSbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:31:05 -0400
Date: Mon, 16 Jun 2003 20:44:26 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <jfontain@free.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 / IDE lost interrupt / ServerWorks problem
In-Reply-To: <1055763075.3eedaa83b19c8@imp.free.fr>
Message-ID: <Pine.SOL.4.30.0306162041200.22323-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Do you have ServerWorks IDE support compiled in 2.4.21?
Can you send me boot logs from 2.4.20 and 2.4.21?

Regards,
--
Bartlomiej

On Mon, 16 Jun 2003 jfontain@free.fr wrote:

> [Please CC me as I am not subscribed to the list]
>
> I just upgraded from a 2.4.20 to 2.4.21 but had to revert due to the following
> errors:
>  hdd: dma_timer_expiry: dma status == 0x60
>  hdd: timeout waiting for DMA
>  hdd: lost interrupt
>
> This chipset is:
>   Bus  0, device  15, function  0:
>     ISA bridge: ServerWorks CSB5 South Bridge (rev 147).
>   Bus  0, device  15, function  1:
>     IDE interface: ServerWorks CSB5 IDE Controller (rev 147).
>   Bus  0, device  15, function  2:
>     USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 5).
> on a bi-pentium III machine.
>
> With 2.4.20 and the ide1=ata66 kernel option, that setup worked great:
> # /sbin/hdparm -t /dev/hdd
> /dev/hdd:
>  Timing buffered disk reads:  64 MB in  1.37 seconds = 46.72 MB/sec
> (thanks to all for such great performance (same as SCSI!))
>
> For 2.4.21, I just added the new "Generic PCI IDE Chipset Support" (no help
> provided), and recompiled, then rebooted. The 2.4.20 message:
>   hdd:351651888sectors(180046 MB)w/2048KiBCache,CHS=21889/255/63,UDMA(100)
> appeared on 2.4.21 as (notice that UDMA(100) has dissapeared):
>   hdd:351651888sectors(180046 MB)w/2048KiBCache,CHS=21889/255/63
>
> I then tried hdparm, which came up with only 2.5 MB/sec, then forced DMA which
> hdparm, tested again and got the errors cited at the beginning of this
> message.
>
> Please let me know if you'd like me to perform some tests, but as I can only
> reboot once or twice at lunch time.
>
> Regards,
>
> Jean-Luc

