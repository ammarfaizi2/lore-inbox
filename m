Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318907AbSHWQI0>; Fri, 23 Aug 2002 12:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318888AbSHWQI0>; Fri, 23 Aug 2002 12:08:26 -0400
Received: from string.physics.ubc.ca ([142.103.234.11]:52905 "HELO
	string.physics.ubc.ca") by vger.kernel.org with SMTP
	id <S318876AbSHWQIX>; Fri, 23 Aug 2002 12:08:23 -0400
Date: Fri, 23 Aug 2002 09:12:34 -0700 (PDT)
From: Bill Unruh <unruh@physics.ubc.ca>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: <linux-ppp@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.33.0208231113550.8320-100000@router.windsormachine.com>
Message-ID: <Pine.LNX.4.33L2.0208230905440.16602-100000@string.physics.ubc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, that problem is usually a "hardware" problem-- ie the hardware is
not responding properly to the icotl request. This could be because
there is not hardware there (eg trying to open a serial port which does
not exist on the machine), or is busy, or has been left in some weird
state. The last sounds most likely here-- eg the serial port on your
modem thinks it is still busy.

You could try running the little program I got basically from Carlson in
http://axion.physics.ubc.ca/modem-chk.html
to try resetting the serial line befor the next attempt (eg, put it into
/etc/ppp/ip-down).
Not sure if this is the problem however.

On Fri, 23 Aug 2002, Mike Dresser wrote:

> On Fri, 23 Aug 2002, Bill Unruh wrote:
>
> > Well, it would be good if you actually told us what problem you were
> > describing. Is this a new connection attempt after the first hang up?
> > What?
> >
> > What repeats over and over-- I see no repeat.
>
> I >
> > You also do not tell us info like what kind of modem is this-- external,
> > internal, serial, usb, pci, winmodem,....
> >
> > I assume what you are refering to is the "inappropriate ioctl" line.
> > This indicates a hardware problem.
> >
> > Actually, it looks to me like another pppd is up on the line. Those
> > EchoReq are another pppd receiving stuff on an open pppd on another
> > line. More information on what it is you are trying to do, on what your
> > system is, and what the problem is might get you help.
> >
>
> Sorry.
>
> It's a new connection from the persist option.  The exact same message
> repeats for every dial out it attempts.
>
> It's a PCI 3com 56k Sportster.  It's a hardware modem.
>
> There is sometimes another pppd up on ttys1
>
> Here's the setup:
>
> There is an external modem on ttyS01, irq 3, that dials in occasionally as
> needed.
>
> there is an internal PCI modem on ttyS04, irq 5, that dials in permamently
> to the ISP.
>
> Every 6 hours, the ISP enforces the 6 hour hangup rule they have.
>
> The modem is set to persist, max-fails 0.  It is not able to redial, and
> keeps giving the error message that i pasted.
>
> Under 2.2.x, this functioned properly.
>
> System is a VIA VT82C693A/694x [Apollo PRO133x] based motherboard, from
> Giga-byte, if I remember correctly.  Celeron 533.
>
> Sorry about the too brief error message, I fell into my "it makes sense to
> me the way it is" trap.
>
> Mike
>
>

-- 
William G. Unruh        Canadian Institute for          Tel: +1(604)822-3273
Physics&Astronomy          Advanced Research            Fax: +1(604)822-5324
UBC, Vancouver,BC        Program in Cosmology           unruh@physics.ubc.ca
Canada V6T 1Z1               and Gravity           www.theory.physics.ubc.ca/
For step by step instructions about setting up ppp under Linux, see
            http://www.theory.physics.ubc.ca/ppp-linux.html

