Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKULFa>; Tue, 21 Nov 2000 06:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130215AbQKULFV>; Tue, 21 Nov 2000 06:05:21 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:33781 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129231AbQKULFP>;
	Tue, 21 Nov 2000 06:05:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001121073955.16B948960@tuttifrutti.cdt.luth.se> 
In-Reply-To: <20001121073955.16B948960@tuttifrutti.cdt.luth.se> 
To: Hakan Lennestal <hakanl@cdt.luth.se>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Nov 2000 10:35:05 +0000
Message-ID: <5117.974802905@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hakanl@cdt.luth.se said:
>   Nov 21 08:08:40 t kernel: hde: IBM-DTLA-307030, ATA DISK drive

>   Nov 21 08:08:40 t kernel:  hde: hde1 hde2 < hde5

> And then after a while it gets a DMA timeout and hangs hard. 

You mean this?

	hde: timeout waiting for DMA
	ide_dmaproc: chipset supported ide_dma_timeout func only: 14

I see identical hangs when I have a similar IBM-DTLA drive attached 
anywhere on the HPT366. But I also see it hang on 2.2.17 if I try:

 hdparm -t /dev/hde & hdparm -t /dev/hde & hdparm -t /dev/hde

a few times. This is even with Andre's latest patch.

For now, I've just moved the IBM drive onto the PIIX4, where it's stable. My 
other UDMA66 drive has been rock solid on the BP6 for months:
	hda: SAMSUNG SV0432D, ATA DISK drive

Andre, un{less,til} we can work out what the problem is, can we add the IBM 
drives to the HPT366 udma4 blacklist? I'll also try it in udma3 mode to see 
what happens.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
