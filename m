Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbRGRRZU>; Wed, 18 Jul 2001 13:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbRGRRZA>; Wed, 18 Jul 2001 13:25:00 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:63212 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267509AbRGRRYt>; Wed, 18 Jul 2001 13:24:49 -0400
Message-ID: <3B55C5C2.47A5AA5B@yahoo.co.uk>
Date: Wed, 18 Jul 2001 13:22:10 -0400
From: Thomas Hood <jdthood@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACP Modem (Mwave)
In-Reply-To: <OF67CA15A0.AE538F3E-ON85256A8D.00580180@raleigh.ibm.com> <Pine.LNX.4.33.0107181129430.18913-100000@screwy.haywired.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI here's a data point.

I just tried this latest driver and it builds properly; it
correctly induces the serial driver to create /dev/tts/1
when mwave.o loads and to delete it when mwave.o unloads;
and it allows me to establish a connection.  No problems
encountered so far on:
   ThinkPad 600 51U (266 MHz Pentium II processor)
   linux-2.4.6-ac2 + Mwave driver patch 20010718

MWAVE DRIVER USERS!  Please note that the name of the module
has changed from mwavedd.o to mwave.o .  You may have to 
change your /etc/modules.conf.  E.g., I had to change the
line 
   alias char-major-10-219 mwavedd
to
   alias char-major-10-219 mwave

Although the driver is called "mwave", it does not support
all functions of all Mwave DSPs.  Currently it only supports
the 3780i Mwave DSP and only for the purpose of Hayes-
compatible modem implementation.  The 3780i DSP is found on
certain IBM ThinkPad laptop models, including the ThinkPad 600.

I would like to take this opportunity to thank Paul Schroeder
Mike Sullivan, and IBM for contributing this GPLed driver to
Linux.

--
Thomas Hood

paulsch@haywired.net wrote:
> 
> Oh yeah...
> 
> It can be gotten here:
> 
> http://oss.software.ibm.com/acpmodem/
> 
> Directly:
> http://oss.software.ibm.com/pub/acpmodem/mwave_linux-2.4.6.patch-20010718
> 
> On Wed, 18 Jul 2001, Paul Schroeder wrote:
> 
> > Okay..  I cleaned things up...  I was more careful about the globals this
> > time...
> >
> > Also...  The driver now builds as mwave.o instead of mwavedd.o...  The
> > driver now registers it's UART as a serial device (Thomas Hood)..  So there
> > is no need to run setserial anymore...
> >
> > Cheers...Paul...
