Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266539AbRGGUmF>; Sat, 7 Jul 2001 16:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266544AbRGGUlz>; Sat, 7 Jul 2001 16:41:55 -0400
Received: from 35.roland.net ([65.112.177.35]:11022 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S266539AbRGGUlm>;
	Sat, 7 Jul 2001 16:41:42 -0400
Message-ID: <000401c10725$47643b20$bb1cfa18@JimWS>
From: "Jim Roland" <jroland@roland.net>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3B469D66.7B100BD3@megsinet.net> <002201c106e7$4a64da20$bb1cfa18@JimWS> <3B47130B.6B0D4F04@megsinet.net>
Subject: Re: Does kernel require IDE enabled in BIOS to access HD, FS errors?
Date: Sat, 7 Jul 2001 15:42:02 -0500
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


----- Original Message -----
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
To: "Jim Roland" <jroland@roland.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, July 07, 2001 8:47 AM
Subject: Re: Does kernel require IDE enabled in BIOS to access HD, FS
errors?


> Jim,
>
> Thanks for the info, comments interleaved below
>
[snip]
>
> But, that's kind of the point I'm driving at if the OS can't correctly
access the
> IDE interface it shouldn't do it at all.

Right.  It's possible that your BIOS may be letting the kernel write.  While
I don't write the kernel, it's probably best for Linus to answer this one,
but it's possible that the kernel is making a BIOS call, and the BIOS does
not refuse to write data (which it should just say "no IDE drives are on the
system right now") with the IDE setting to <NONE> in your BIOS.  OTOH, the
kernel may be making calls of it's own or as you say, there may be a broken
driver.  I seem to remember there was a "bug workaround" option in the
kernel for the CMD640 chipset.

> > Are you getting IDE corruption with the BIOS set to <AUTO> for your IDE
> > drive?
>
> None whatsoever.

Then AFAIK, it's definitely a BIOS issue. There might be (if not there
already) a kernel option to check to see what the BIOS setting is for number
of IDE drives (of course set to <NONE> would mean 0 drives), and refuse to
write it.  This workaround (if any) would be required for buggy BIOSes (I'm
sure yours isn't the only one <grin>).



