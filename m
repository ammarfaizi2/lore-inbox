Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269021AbRHCM1h>; Fri, 3 Aug 2001 08:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269002AbRHCM1S>; Fri, 3 Aug 2001 08:27:18 -0400
Received: from [194.30.80.67] ([194.30.80.67]:5130 "EHLO
	serv_correo.ingecom.net") by vger.kernel.org with ESMTP
	id <S269001AbRHCM04>; Fri, 3 Aug 2001 08:26:56 -0400
Message-ID: <014101c11c17$a6dd21a0$66011ec0@frank>
From: "Frank Torres" <frank@ingecom.net>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Duplicate console output to a RS232C and keep keyb where it is
Date: Fri, 3 Aug 2001 14:27:20 +0200
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

How do I make Linux to use the serial port RS232C as console and get the
keyb entry from the normal console?

The RS232C is a serial port with 12V and there I have a BA63 20x4 display
connected. (info worldwide)
It is setted with the right speed, parity, etc. I use echo whatever
>/dev/ttyS2 and it works.
If I use the command line parameter everybody says:  (odd and 8 data bits is
what I use)
            serial=2,9600o8
            console=ttyS2,9600o8 console=tty0
it shows the kernel messages in tty0 and it also sends it to the serial port
(of course, but without configuring it, though, almost illegible) at the
point of starting init, it stops the output.

If I swap the consoles (console=tty0 console=ttyS2,9600o8) it sends the
kernel messages to both, the tty0 and the ttySn, but when init starts, it
begins to send the Welcome... adn the Press I to enter... messages
repetedely each time further one from another. Seldom it continues executing
rc.sysinit processes, but it never comes to the end. I check it by
connecting the serial output to a serial input in a PC also running Linux
and using cat /dev/ttyS0.

I also used the line s0:1234:respawn .... at inittab,   but it creates a new
line for loggin where you say it to do it. If I dont change lilo.conf but
only inittab, I can see the loggin message. I don't want that. I just want
it to get se loggin from the console I'm working with.

What I expect it to obtain all the console output through the serial port
and the input through my keyboard using any of the virual consoles (let's
say tty1), not comming from serial. Is there any way to do that?

Thanx from advance. Frank.

