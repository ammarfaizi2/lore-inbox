Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbRHFHfI>; Mon, 6 Aug 2001 03:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbRHFHe5>; Mon, 6 Aug 2001 03:34:57 -0400
Received: from [194.30.80.67] ([194.30.80.67]:64773 "EHLO
	serv_correo.ingecom.net") by vger.kernel.org with ESMTP
	id <S267248AbRHFHer>; Mon, 6 Aug 2001 03:34:47 -0400
Message-ID: <00a801c11e4a$5571a950$66011ec0@frank>
From: "Frank Torres" <frank@ingecom.net>
To: "Russell King" <rmk@arm.linux.org.uk>, <jdow@earthlink.net>,
        <root@chaos.analogic.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1010803085542.16919A-100000@chaos.analogic.com> <018201c11c24$cd2af730$66011ec0@frank> <20010803194300.A1609@flint.arm.linux.org.uk>
Subject: Re: Duplicate console output to a RS232C and keep keyb where it is
Date: Mon, 6 Aug 2001 09:35:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Aug 03, 2001 at 04:01:28PM +0200, Frank Torres wrote:
> > > This is not valid. You cannot reasonably have parity and 8 bits. One
> > > of them has to go. Either use 8 bits and no parity or 7 bits with
> > > parity.
>
> All standard 16550 family ports support 8 bits _and_ parity.  Ancient
> serial ports did have a restriction, but that restriction is no more.
>
> > All showed wrong or no characters in the display. It only worked with 8,
> > parity on, parity odd, stop b. (also with no stop b.)
>
> You actually mean 2 stop bits.  (There is _always_ one stop bit).
>
> I read your first mail, but couldn't really grasp the details of your
> problem.
>
> Are you trying to direct console _output_ to ttyS2 and the VGA card, yet
> still accept input from the PS/2 keyboard?  And then when you try to set
> this up, you get garbled characters via ttyS2?

Smthng like that.
Yes, I'm trying to direct console output to ttyS2 and to the VGA card at the
same time.
I don't care if I have to direct it only to ttyS2, but I need to have the
input from
the PS/2 keyboard. When I use the line
                s2:2345:respawn ....
in inittab, it sends a login prompt to the display connected to ttyS2,
different console than
that on tty0, therefore, obtaining the keyboard input from PS/2 only for
tty0.
If I use the command append="console=ttyS2,9600 ...." in lilo.conf it
happens what I explained
in the first mail. If U want to, I can send you a mail with the kernel and
init messages I got
connecting another serial port to ttyS2 and saving the data.
I've seen everywhere it should be as simple as redirecting the output with
the "console" command.
But it doesn't continue working alright after the Welcome message. ¿?

Frank Torres   (34) 94 439 6261
Ingecom, Máximo Aguirre 18 Bis
Bilbao, 48011, Spain.


