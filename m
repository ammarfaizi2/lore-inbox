Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269092AbRHCOBU>; Fri, 3 Aug 2001 10:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269111AbRHCOBJ>; Fri, 3 Aug 2001 10:01:09 -0400
Received: from [194.30.80.67] ([194.30.80.67]:28938 "EHLO
	serv_correo.ingecom.net") by vger.kernel.org with ESMTP
	id <S269092AbRHCOBB>; Fri, 3 Aug 2001 10:01:01 -0400
Message-ID: <018201c11c24$cd2af730$66011ec0@frank>
From: "Frank Torres" <frank@ingecom.net>
To: <root@chaos.analogic.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1010803085542.16919A-100000@chaos.analogic.com>
Subject: Re: Duplicate console output to a RS232C and keep keyb where it is
Date: Fri, 3 Aug 2001 16:01:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 3 Aug 2001, Frank Torres wrote:
> >
> > The RS232C is a serial port with 12V and there I have a BA63 20x4
display
> > connected. (info worldwide). It is setted with the right speed, parity,
etc. I use echo whatever
> > >/dev/ttyS2 and it works.
>
> It has probably been set okay after boot by `setserial` in some boot
> script.
>
> > If I use the command line parameter everybody says:  (odd and 8 data
bits is
> > what I use)
> >             serial=2,9600o8   and     console=ttyS2,9600o8 console=tty0
>
> This is not valid. You cannot reasonably have parity and 8 bits. One
> of them has to go. Either use 8 bits and no parity or 7 bits with
> parity.
>
> This is because there are 10 bits/baud. The "stop" bit is a timing
> interval equal to one of these bits, between characters. Therefore, you
> can have many stop bits, this just spaces the characters.

Richard:
I must tell you I am the one who sets the speed, IRQ and the rest of the
parameters of the serial port in an /etc/rc.serial built by me only with the
settings I need. The original rc.serial was producing some error when
executed by rc.sysinit (kern. 2.4.2-2)
I have to configure ttyS2 with both, setserial and stty, 'cause of the
parity and the stop bit, etc.
I tested the following configurations:
    8, no parity, stop b.
    8, no parity, no stop b.
    7, parity on, parity odd, stop b.
    7, no parity, no stop b.
All showed wrong or no characters in the display. It only worked with 8,
parity on, parity odd, stop b. (also with no stop b.)
The Linux is installed in a Beetle/M POS.
Perhaps it can't be done? I mean to obtain the video through the serial port
without modifying the normal keyb entry?
Thanx


