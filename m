Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276538AbRJKQwk>; Thu, 11 Oct 2001 12:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276285AbRJKQwc>; Thu, 11 Oct 2001 12:52:32 -0400
Received: from radium.jvb.tudelft.nl ([130.161.76.91]:11780 "HELO
	radium.jvb.tudelft.nl") by vger.kernel.org with SMTP
	id <S276547AbRJKQwL>; Thu, 11 Oct 2001 12:52:11 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: "'John Gluck'" <jgluckca@home.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
Date: Thu, 11 Oct 2001 18:52:49 +0200
Message-ID: <002601c15275$2945b510$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3BC5C866.1337F5DF@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My testcase was indeed one large file. I did not test lots of small
files. It would always lockup after said amount of traffic, but only in
10 Mbit half duplex mode. Also, I have the 82557, not the 82558 chip.

The problem looks a lot like what should be fixed in this changelog line
from 2.4.9-ac13:

- Work around eepro100 bug with some chip		(Arjan van de
Ven)
  versions on 10Mbit half duplex

Only 2.4.10ac11 still had the problem...

- Robbert

> -----Original Message-----
> From: john@femail22.sdc1.sfba.home.com 
> [mailto:john@femail22.sdc1.sfba.home.com] On Behalf Of John Gluck
> Sent: donderdag 11 oktober 2001 18:27
> To: Robbert Kouprie
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 
> 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
> 
> 
> Hi
> 
> I haven't noticed this problem on my system...
> 
> I have an 82558 that uses this driver on a Tyan S1836DLUAN 
> motherboard.
> I have Dual PIIIs and the system is multi homed. I have a 2nd 
> interface that
> uses the NE2000 PCI driver.
> 
> The system is my workstation but also acts as an internet 
> gateway (via cable
> modem) and firewall for 2 other computers. My workstation is 
> on 24/7 and has
> never hungup.
> 
> I am currently using 2.4.10 for the kernel but I've used most 
> kenels since
> the 2.4.0testX days.
> 
> In your tests, is the 80 - 130 megs a single file or is it an 
> aggregate. In
> my use I far exceed the amount of data but it's web surfing 
> so the files are
> much smaller the what you mention.
> 
> John
> 
> Robbert Kouprie wrote:
> 
> > Hi all,
> >
> > I can confirm that the known bug in the Intel EtherExpress Pro/100
> > adapter is still not worked around in recent kernels. The bug only
> > manifests itself when the card is operating on 10 Mbit half 
> duplex. On
> > 100 Mbit there are no problems. The problem is that after the device
> > received certain amount of traffic (between 80 and 130 Mb 
> in my tests)
> > the device will lockup on new connections. Processes start 
> to hang after
> > this and logging in is impossible. The only solution is to reset the
> > interface (using a previously logged in root session) and reboot the
> > system.
> >
> 
> 

