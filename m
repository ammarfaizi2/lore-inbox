Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269643AbRHCWpe>; Fri, 3 Aug 2001 18:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269653AbRHCWpX>; Fri, 3 Aug 2001 18:45:23 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.121.12]:33247 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S269648AbRHCWpP>; Fri, 3 Aug 2001 18:45:15 -0400
Message-ID: <031801c11c6d$f65a4a90$1125a8c0@wednesday>
From: "J. Dow" <jdow@earthlink.net>
To: <root@chaos.analogic.com>, "Frank Torres" <frank@ingecom.net>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1010803085542.16919A-100000@chaos.analogic.com>
Subject: Re: Duplicate console output to a RS232C and keep keyb where it is
Date: Fri, 3 Aug 2001 15:45:10 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Richard B. Johnson" <root@chaos.analogic.com>

> On Fri, 3 Aug 2001, Frank Torres wrote:
> >
> > The RS232C is a serial port with 12V and there I have a BA63 20x4 display
> > connected. (info worldwide)
> > It is setted with the right speed, parity, etc. I use echo whatever
> > >/dev/ttyS2 and it works.
>
> It has probably been set okay after boot by `setserial` in some boot
> script.
>
> > If I use the command line parameter everybody says:  (odd and 8 data bits is
> > what I use)
> >             serial=2,9600o8
> >             console=ttyS2,9600o8 console=tty0
>
> This is not valid. You cannot reasonably have parity and 8 bits. One
> of them has to go. Either use 8 bits and no parity or 7 bits with
> parity.
>
> This is because there are 10 bits/baud. The "stop" bit is a timing
> interval equal to one of these bits, between characters. Therefore, you
> can have many stop bits, this just spaces the characters.

Dick Johnson, that is utter nonsense. I have applications that use 8 bits,
even parity, and two stop bits. I have applications that use 7 bits no
parity and to stop bits.

Nor are there 10 buts/baud on an RS-232 port. Barring using BAUDOT protocols
the baud and bit rate of an RS-232 port are the same number. When you get
into complex signaling protocols such as are used in MODEMs you can get
multiple bits sent within a signal protocol interval. The latter is called
the baud (not baud rate) of the link. It is not uncommon to have 2400 baud
or signaling intervals per second and have each of these intervals encode
say 16 bits worth of data. Then you have to consider the error correcting
and other protocols that may be placed on the raw bits transmitted each
baud. Nonetheless, none of this applies to RS-232.

{^_^}    Joanne "Been doing this for nearly 40 years" Dow


