Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285617AbRLRGeX>; Tue, 18 Dec 2001 01:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285629AbRLRGeO>; Tue, 18 Dec 2001 01:34:14 -0500
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:28425 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S285617AbRLRGeE> convert rfc822-to-8bit; Tue, 18 Dec 2001 01:34:04 -0500
From: "" <simon@baydel.com>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Date: Mon, 17 Dec 2001 13:47:15 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Subject: Re: Panic output
CC: linux-kernel@vger.kernel.org
Message-ID: <3C1DF763.28186.17B69A0@localhost>
In-Reply-To: <3C1DF9AD.1DFEB1B@loewe-komp.de>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried the console only method and this does not work either. 
Perhaps I sould add some more information about the panic. This 
card is a FC board and there was a bug in the hardware which 
caused invalid frame reception. When this happens the driver is 
interrupted and goes off to have a look at the frame. It sorts ou the 
hardware and continues. Initially I was just dumping part of the 
frame and the system continued and all was ok. I decided in 
certain circumstances this would not be a good idea so I inserted 
the panic. At this stage I get the hang or reboot depending how I 
set /proc/sys/kernel/panic. I guess if this is set to 0 the hang 
should be a screen oops message ?

I get the impression from the responses that panic does not aways 
work, is that correct ?

At this point the hardware is all ok and can be made to continue 
running all that has happened is some isolated event internal to a 
PCI card.

I will try the serial line.

Many Thanks

Simon. 


On 17 Dec 2001, at 14:57, Peter Wächtler wrote:

> simon@baydel.com schrieb:
> > 
> > During writing a driver for a PCI board I experienced the hardware
> > hanging and I had to press the big red button. The hang was traced
> > using a PCI analyzer and I found that the driver, loaded as a
> > module, was taking a route which called panic. I changed
> > /proc/sys/kernel/panic to a non zero value and the machine started
> > to reboot on PCI hang. My problem is I never see any output on the
> > screen or in /var/log/messages. All the stuff I have looked at in
> > /usr/src/linux/Documentation suggests the messages should be
> > here. I am running a 2.4.0 kernel with a SuSE 7.1 installation. At
> > the hang time the system is running kde 2 and in a command
> > winow I have a tail -f /var/log/messages running. The first change I
> > see is the PC bios startup.
> > 
> 
> First: try to start your driver from the console.
> There you should see the panic message.
> 
> Then look at Documentation/serial-console.txt and hook up a serial 
> console to your box


__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
