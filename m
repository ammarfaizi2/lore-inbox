Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264737AbSJ3Qio>; Wed, 30 Oct 2002 11:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264735AbSJ3Qio>; Wed, 30 Oct 2002 11:38:44 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:28421
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S264734AbSJ3Qik>; Wed, 30 Oct 2002 11:38:40 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33C7E@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Alex Pavloff'" <apavloff@eason.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'linux-serial'" <linux-serial@vger.kernel.org>,
       "'Robert Schwebel'" <robert@schwebel.de>
Subject: RE: what serial port type are Elan ports?
Date: Wed, 30 Oct 2002 08:45:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Yes, it is exactly what I was looking for. Thanks very much.

Robert Schwebel has indicated that the Elan silicon bug is also in the SC410
chip. If you or somebody else have a ready to run SC4X0 based system, please
send me the first ten or so lines of output from the following command so I
can see the UART type that was detected for the SC4X0's serial ports:

	more /proc/tty/driver/serial

Thanks again,
Ed

> -----Original Message-----
> From: Alex Pavloff [mailto:apavloff@eason.com]
> Sent: Tuesday, October 29, 2002 6:06 PM
> To: 'Ed Vance'
> Cc: 'linux-kernel'; 'linux-serial'
> Subject: RE: what serial port type are Elan ports?
> 
> 
> 
> Hi Ed,
> 
> Well, here's the output from my stock Red Hat 7.3 (2.4.18-3) 
> system, running
> on an AMD ElanSC520-133AC Alpha Rev 1A from 1999 (antique, 
> aint it?).  Its
> sitting on an AMD Aspen Microcontroller Customer Developer 
> Platform Rev 1.2.
> 
> serinfo:1.0 driver:5.05c revision:2001-07-08
> 0: uart:16550A port:3F8 irq:4 baud:9600 tx:11 rx:0
> 1: uart:16550A port:2F8 irq:3 baud:9600 tx:11 rx:0
> 2: uart:unknown port:3E8 irq:4
> 3: uart:unknown port:2E8 irq:3
> 4: uart:unknown port:1A0 irq:9
> 5: uart:unknown port:1A8 irq:9
> 6: uart:unknown port:1B0 irq:9
> 7: uart:unknown port:1B8 irq:9
> 8: uart:unknown port:2A0 irq:5
> 9: uart:unknown port:2A8 irq:5
> 
> Is this what you need?
> 
> Alex Pavloff - apavloff@eason.com
> Eason Technology -- www.eason.com
>  
> 
> > -----Original Message-----
> > From: Alex Pavloff 
> > Sent: Tuesday, October 29, 2002 5:24 PM
> > To: 'Ed Vance'; Alex Pavloff
> > Cc: 'linux-kernel'; 'linux-serial'
> > Subject: RE: what serial port type are Elan ports?
> > 
> > 
> > 
> > Hi Ed,
> > 
> > I've got an SC520 dev board here actually.  I can get that 
> > output to you tommorow (have to scrounge up a power supply et al).
> > 
> > Alex Pavloff - apavloff@eason.com
> > Eason Technology -- www.eason.com
> >  
> > 
> > > -----Original Message-----
> > > From: Ed Vance [mailto:EdV@macrolink.com]
> > > Sent: Tuesday, October 29, 2002 5:14 PM
> > > To: 'Alex Pavloff'
> > > Cc: 'linux-kernel'; 'linux-serial'
> > > Subject: RE: what serial port type are Elan ports?
> > > 
> > > 
> > > Hi Alex,
> > > 
> > > Thanks, I think the Elan SC520 is all I need. I don't know if 
> > > the other
> > > chips in the family have the same bug. 
> > > 
> > > There is a conflict between the Elan work-around and the 
> > > 16C654 UART. It
> > > looks like the work-around causes it to drop transmit data. 
> > > If I can know
> > > for sure the detected type of the Elan's ports, then I can 
> > > shield all other
> > > UART types from the work-around with a quick type field check 
> > > without losing
> > > the benefit of the work-around. 
> > > 
> > > Suggestions are welcome.
> > > 
> > > Best regards,
> > > Ed
> > > 
> > > > -----Original Message-----
> > > > From: Alex Pavloff [mailto:apavloff@eason.com]
> > > > Sent: Tuesday, October 29, 2002 4:19 PM
> > > > To: 'Ed Vance'; 'linux-kernel'; 'linux-serial'
> > > > Subject: RE: what serial port type are Elan ports?
> > > > 
> > > > 
> > > > 
> > > > Elan Sc3x0?
> > > > Elan Sc4x0?
> > > > Elan Sc520?
> > > > 
> > > > I assume you mean the 520, if you really want to find the 
> > > > UART for the SC3x0
> > > > I might be convinced to plug in a hard drive to one of my 
> > > > many SC320s lying
> > > > around and let you know.
> > > > 
> > > > Alex Pavloff - apavloff@eason.com
> > > > Eason Technology -- www.eason.com
> > > > 
> > > > > -----Original Message-----
> > > > > From: Ed Vance [mailto:EdV@macrolink.com]
> > > > > Sent: Tuesday, October 29, 2002 4:14 PM
> > > > > To: 'linux-kernel'; 'linux-serial'
> > > > > Subject: what serial port type are Elan ports?
> > > > > 
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > I need to know what UART type the serial driver detects for 
> > > > > the two built-in
> > > > > serial ports on the AMD Elan Microcontroller?
> > > > > 
> > > > > Would some nice person who has an Elan based system please 
> > > > > send me the first
> > > > > ten lines of the output of the following command?
> > > > > 
> > > > > 	more /proc/tty/driver/serial
> > > > > 
> > > > > Thanks in advance,
> > > > > Ed
> > > > > 
> > > > > 
> > ---------------------------------------------------------------- 
> > > > > Ed Vance              edv (at) macrolink (dot) com
> > > > > Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> > > > > 
> ----------------------------------------------------------------
> > > > > 
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe 
> > > > > linux-serial" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> > > > 
> > > 
> > 
> 
