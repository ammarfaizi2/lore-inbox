Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTILJDn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTILJDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:03:43 -0400
Received: from alpha.tmit.bme.hu ([152.66.246.10]:23567 "EHLO alpha.ttt.bme.hu")
	by vger.kernel.org with ESMTP id S261332AbTILJDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:03:41 -0400
Message-Id: <200309120900.h8C908Xh011926@alpha.ttt.bme.hu>
From: "Horvath Gyorgy" <HORVAATH@tmit.bme.hu>
Organization: DTT_BUTE
To: Stewart Smith <stewart@linux.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 12 Sep 2003 10:59:40 +0200
Subject: Re: [ANNOUNCE] New hardware - SGA155D dual STM-1/OC3 PCI ad
X-mailer: Pegasus Mail v3.22
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> ====> From Stewart Smith
> On Wed, 2003-09-10 at 00:55, Alan Cox wrote:
> > > 4. Optionally - and if I have enough time - I'd like
> > >    to develop a twin-linear filesystem driver for
> > >    time-stamped capture/playback for multiple channels
> > >    of data - like a multi-band magnetic tape.
> > >    BTW do you know an existing one?
> >
> > I've seen people do this in user space (just interleaving the disk in
> > big chunks in the app and driving it with O_DIRECT raw access) but not
> > in kernel file system space.
>
> (from memory) I think that ext2/ext3 does (or at least did) this - they
> lacked any smart logic for rapid allocations - at least for inodes in
> the same cylinder group. I think this was mentioned in the "Journaling
> the ext2 filesystem" paper.

Unfortunatelly, I have to deal with the file-system from
the FPGA as well - as from the Linux.
Probably I have not enough room to implement ext2/ext3
in the FPGA.
Anyway - I will see what...

Actually - I have my driver-skeleton up, and I can now load
firmware into the card.
That's a movement ... but lot more to do.

Sep 11 14:53:01 westel9 kernel: SGA155D[x] is a dual STM-1/OC3
Telecom. PCI adapter 0.01
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: AMCC is at F3800000
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: CPLD is at F3000000
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: FPGA is at F2800000
Sep 11 14:53:01 westel9 kernel: PCI: Found IRQ 9 for device 02:0b.0
Sep 11 14:53:01 westel9 kernel: PCI: Sharing IRQ 9 with 00:1f.4
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: AMCC mapped to f0818000
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: AMCC S5933 Reset, MCSR=
00000026
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: AMCC MCSR Initialization
failed
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: AMCC S5933 Cold,
INTCSR=00000000
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: CPLD mapped to f081a000
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: CPLD Test,    CPLD_TEST =
 AA55
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: CPLD Test,    CPLD_TEST =
 3CF0
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: Firmware loaded,
running...
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: FPGA mapped to f081c000
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: FPGA Firmware ID is
D155FF02
Sep 11 14:53:01 westel9 kernel: SGA155D[0]: FPGA TEST =  AA553CF0

I don't know why AMCC said that stupid 0x26 instead of 0xE6...
Others seemed OK - and the LED's blinking :-)

Best regards,
Gyuri

Gyorgy Horvath,        Technical University of Budapest
--------------         Dept. of Telecom. and Telematics

Tel.: +36-1-463-1865,  Fax.: +36-1-463-1865
Mail: horvaath@bme-tel.ttt.bme.hu
FTP:  ttt-pub.ttt.bme.hu  ./income
