Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275743AbRJQLsF>; Wed, 17 Oct 2001 07:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275750AbRJQLrq>; Wed, 17 Oct 2001 07:47:46 -0400
Received: from apexmail.kih.net ([209.209.190.216]:2291 "EHLO apexmail.kih.net")
	by vger.kernel.org with ESMTP id <S275743AbRJQLrj>;
	Wed, 17 Oct 2001 07:47:39 -0400
Date: Wed, 17 Oct 2001 06:45:11 -0500 (CDT)
From: grouch <grouch@apex.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: VIA chipset
Message-ID: <Pine.LNX.4.30.0110151840000.13866-100000@paq.edgers.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, my apologies to the list subscribers and to the person responding
privately to my questions. I assumed that person was posting to the list
and CC'ing replies to me, since I am not subscribed to the list. My
replies were CC'ed to the list because of that. The assumption was
wrong and the result is that I was rudely posting my half of a private
conversation to this public mailing list. Sorry.

Second, the system lockups appear to be cured! It appears to be a
problem with using Ultra ATA/100 drives on an Award BIOS + VIA chipset
motherboard that only supports up to Ultra ATA/33 drives. Note that even
the tests I ran with the BIOS set to disable UDMA and the kernel
configured to not use UDMA resulted in system hangs.

First clue came from a single line about (of all things, Windows 95) on
page 51 of this document from IBM: djna-dpta-dtla_digw.pdf . It warns of
system hangs when a UDMA 100 or UDMA 66 drive is used on some UDMA 33 or
lower motherboards.

Using the IBM Drive Feature Tool at
http://service.boulder.ibm.com/storage/hddtech/ibmftool-install-img.bin
I set the IBM-DTLA-305040 drive to report and use UDMA 33. This utility
http://www.wdc.com/service/ftp/dlgtools/dlgmaker.exe was used to do the
same for a WDC AC26400R drive.

I've only tested it for a night, shuffling a few G's of data around, but
much less was needed to lock the system under 2.4.x before. I have no
clue why it never locked using the default Debian 2.2.18pre21 kernel,
why it locked quickly with any 2.4.x kernel, why it locked only
occasionally with a 2.2.x kernel with ext3, nor why it appears stable
now.

Maybe this will save someone else some frustration. Then again, maybe
it's a fluke caused by the phase of the moon when the mobo was made.

Terry Vessels

