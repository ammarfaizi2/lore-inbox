Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129706AbRA3Sl1>; Tue, 30 Jan 2001 13:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131218AbRA3SlX>; Tue, 30 Jan 2001 13:41:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129706AbRA3SlK>; Tue, 30 Jan 2001 13:41:10 -0500
Date: Tue, 30 Jan 2001 13:36:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: mirabilos <eccesys@topmail.de>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
        "Mark H. Wood" <mwood@IUPUI.Edu>
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <009801c08ae8$c839a280$0100a8c0@homeip.net>
Message-ID: <Pine.LNX.3.95.1010130133314.139A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, mirabilos wrote:

> [...]
> > > 
> > > Now, we've found that small delays are reasonably well generated with
> > > an "outb" to 0x80. So, indeed changing that to something else is going
> > > to be tricky. 
> > 
> > So how bad would it be to give these people a place to leave the value
> > that they want to have displayed, and have the delay code write *that*
> > instead of garbage?
> 
> Because Port &h80 is _not_ decoded by the standard PC hardware.
> There are some ISA and nowadays even PCI cards that convert the value
> OUTted to that port into two 7-segment-digit-LCDisplays, buffered so
> you can read it from the card, but normally no chipset actually
> cares about that port. (I speak of Desktop PCs.)
> 
> I repeat: Any OUT to port &h80 is, as long as there are no special
> extensions, just as well as any OUT to port &h1234 or &h4711 or
> whateveryouwant as long as nothing uses it.
> Since Port &h80 is now "reserved" for that POST code usage,
> and it is the safest port one can use in order to delay,
> Linux uses it.

This is not correct. Port 0x80 is not an "unused" port. It
is decoded by standard hardware:

C:\>debug

-i 80
AE
-o 80 20
-i 80
20
-q


In this machine I do not have a 'POST-codes' board. Port 0x80 is
an 8-bit read/write latch. It always has been.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
