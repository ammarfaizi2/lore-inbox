Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130682AbRA3Spr>; Tue, 30 Jan 2001 13:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131978AbRA3Sph>; Tue, 30 Jan 2001 13:45:37 -0500
Received: from www.topmail.de ([212.255.16.226]:16279 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S130682AbRA3SpV> convert rfc822-to-8bit;
	Tue, 30 Jan 2001 13:45:21 -0500
Message-ID: <00e401c08aec$caae2820$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>,
        <root@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010130133314.139A-100000@chaos.analogic.com>
Subject: Re: Linux Post codes during runtime, possibly OT
Date: Tue, 30 Jan 2001 18:41:33 -0000
Organization: eccesys.net Linux Distribution Development
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "mirabilos" <eccesys@topmail.de>
Cc: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>; "Mark H. Wood" <mwood@IUPUI.Edu>
Sent: Tuesday, January 30, 2001 6:36 PM
Subject: Re: Linux Post codes during runtime, possibly OT


> On Tue, 30 Jan 2001, mirabilos wrote:
> 
> > [...]
> > > > 
> > > > Now, we've found that small delays are reasonably well generated with
> > > > an "outb" to 0x80. So, indeed changing that to something else is going
> > > > to be tricky. 
> > > 
> > > So how bad would it be to give these people a place to leave the value
> > > that they want to have displayed, and have the delay code write *that*
> > > instead of garbage?
> > 
> > Because Port &h80 is _not_ decoded by the standard PC hardware.
> > There are some ISA and nowadays even PCI cards that convert the value
> > OUTted to that port into two 7-segment-digit-LCDisplays, buffered so
> > you can read it from the card, but normally no chipset actually
> > cares about that port. (I speak of Desktop PCs.)
> > 
> > I repeat: Any OUT to port &h80 is, as long as there are no special
> > extensions, just as well as any OUT to port &h1234 or &h4711 or
> > whateveryouwant as long as nothing uses it.
> > Since Port &h80 is now "reserved" for that POST code usage,
> > and it is the safest port one can use in order to delay,
> > Linux uses it.
> 
> This is not correct. Port 0x80 is not an "unused" port. It
> is decoded by standard hardware:
> 
> C:\>debug
> 
> -i 80
> AE
> -o 80 20
> -i 80
> 20
> -q
> 
> 
> In this machine I do not have a 'POST-codes' board. Port 0x80 is
> an 8-bit read/write latch. It always has been.
> 
> 
> Cheers,
> Dick Johnson

OK, I'll check it against every box I've got here. I just was
citing what I've learned "ages" ago.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
