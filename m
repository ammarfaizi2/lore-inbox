Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbTJaGgd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 01:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTJaGgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 01:36:33 -0500
Received: from northuist.CNS.CWRU.Edu ([129.22.104.60]:22756 "EHLO
	ims-msg.TIS.CWRU.Edu") by vger.kernel.org with ESMTP
	id S263039AbTJaGgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 01:36:31 -0500
Date: Fri, 31 Oct 2003 06:36:36 +0000
From: Dan Bernard <djb29@cwru.edu>
Subject: Re: kernel: i8253 counting too high! resetting..
In-reply-to: <200310310040.19519.gene.heskett@verizon.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: CN <cnliou9@fastmail.fm>, linux-kernel@vger.kernel.org
Mail-followup-to: Dan Bernard <djb29@cwru.edu>,
 Gene Heskett <gene.heskett@verizon.net>, CN <cnliou9@fastmail.fm>,
 linux-kernel@vger.kernel.org
Message-id: <20031031063636.GA61826@teraz.cwru.edu>
MIME-version: 1.0
X-Mailer: Mutt 1.4.1i-JA.1 [JP] (FreeBSD i386)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com>
 <20031030171235.GA59683@teraz.cwru.edu>
 <20031031050439.E03B17E2B8@smtp.us2.messagingengine.com>
 <200310310040.19519.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20031031 0040, Gene Heskett wrote:
> >
> >ALi
> >M1542 A1
> >100MHz
> >Uniform Multi-Platform E-IDE driver Revision: 6.31
> >ide: Assuming 33MHz system bus speed for PIO modes; override with
> >idebus=xx
> 
> This is correct, and for 2.4.20, I don't think the override works.
> 
> > ...
> 
> And again, while slower, this is the default bus speed FOR PIO, 
> Programmed I/O, not DMA.  Another animal entirely.  Running at this 
> 33MHZ speed, but without any handshaking, it can move 132Mb a second 
> because each access is 32 bits, or 4 bytes, wide.  Which is still far 
> faster than your drives can bring data past the heads.  You are 
> confusing the UDMA66 mode which exists on the drive cable, with the 
> bus speed the IDE card is plugged into, 2 entirely different animals.
> 
> > ...
> 
> You'll need good cables, and a lengthy read of the hdparm manpage.  
> Then you can put the correct hdparm command to enable the UDMA66 mode 
> right into your /etc/rc.d/rc.local script.

ALi M1542 chipset is probably not too different from mine.  That's good,
because if it were not ALi, then this would be much more complicated.

The main problem here is not any kind of malfunction, but simply a
component or group of components performing slightly below what is
expected, and the software therefore generates unnecessary noise.

I do not try to tweak any settings with hdparm unless something is broken.
However, it looks like that may be your best bet in this particular case.
I shall just continue putting up with the warnings for now.

Still, if anyone gets these warnings without ALi chipsets, please do tell.

Regards,
Dan Bernard

