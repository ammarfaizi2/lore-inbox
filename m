Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131832AbRA3SQz>; Tue, 30 Jan 2001 13:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131959AbRA3SQq>; Tue, 30 Jan 2001 13:16:46 -0500
Received: from www.topmail.de ([212.255.16.226]:48578 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S131957AbRA3SQi> convert rfc822-to-8bit;
	Tue, 30 Jan 2001 13:16:38 -0500
Message-ID: <009801c08ae8$c839a280$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>,
        "Mark H. Wood" <mwood@IUPUI.Edu>
In-Reply-To: <Pine.LNX.4.21.0101301241250.11300-100000@mhw.ULib.IUPUI.Edu>
Subject: Re: Linux Post codes during runtime, possibly OT
Date: Tue, 30 Jan 2001 18:16:29 -0000
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

[...]
> > 
> > Now, we've found that small delays are reasonably well generated with
> > an "outb" to 0x80. So, indeed changing that to something else is going
> > to be tricky. 
> 
> So how bad would it be to give these people a place to leave the value
> that they want to have displayed, and have the delay code write *that*
> instead of garbage?

Because Port &h80 is _not_ decoded by the standard PC hardware.
There are some ISA and nowadays even PCI cards that convert the value
OUTted to that port into two 7-segment-digit-LCDisplays, buffered so
you can read it from the card, but normally no chipset actually
cares about that port. (I speak of Desktop PCs.)

I repeat: Any OUT to port &h80 is, as long as there are no special
extensions, just as well as any OUT to port &h1234 or &h4711 or
whateveryouwant as long as nothing uses it.
Since Port &h80 is now "reserved" for that POST code usage,
and it is the safest port one can use in order to delay,
Linux uses it.
If you don't want this, change it in your kernel or define
SLOW_BY_JUMPING.

-mirabilos


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
