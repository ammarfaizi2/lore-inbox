Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbRB0Nl7>; Tue, 27 Feb 2001 08:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRB0Nlu>; Tue, 27 Feb 2001 08:41:50 -0500
Received: from f110.law10.hotmail.com ([64.4.15.110]:3081 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129309AbRB0Nlb>;
	Tue, 27 Feb 2001 08:41:31 -0500
X-Originating-IP: [194.65.14.69]
From: "Mack Stevenson" <mackstevenson@hotmail.com>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: ISO-8859-1 completeness of kernel fonts?
Date: Tue, 27 Feb 2001 14:41:24 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F110arjrfh6BYVKBLEB00013ccb@hotmail.com>
X-OriginalArrivalTime: 27 Feb 2001 13:41:25.0092 (UTC) FILETIME=[FA5DBA40:01C0A0C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for your reply.

> >
> > The 8x16 and Sun 12x22 kernel fonts I tried seem to lack some standard
> > glyphs necessary to represent the entire ISO-8859-1 charmap; I am 
>talking
> > about all accented capital vowels except for 'É'.
> >
> > This seems to happen in both 2.2.16 as well as in 2.2.18.
> >
> > Is this intentional? If so, why?
> >
> > How can I override this behaviour?
> >
>
>They're probably CP 437 fonts.  Just load your own; e.g. "setfont 
>lat1u-16".
>

I know that, but unfortunately all the fonts I found for use with the kbd 
and console-tools packages are much smaller than 12x22, making them hardly 
legible (to me) on high dpi screens: that's why I even tried the ones in the 
kernel. :-)

[Is there any easy way for you to create larger console fonts out of the 
8x16 Latin* ones you already wrote?]

"setfont -h22 [font]" doesn't work, too.

Anyway, I have already pinned down the source file (in 2.2.18) -  
drivers/video/font_sun12x22.c - and would like to try to change this. Yet it 
seems like the kernel boots using the CP437 charmap, so this would need to 
be modified, too -  I suppose that the relevant file is 
drivers/char/consolemap.c.

- How can I instruct the kernel to use the ISO-8859-1 character map? 
drivers/char/consolemap.c contains three different translation tables - 
CP437, ISO-8859-1 and VT100 mapped to Unicode -; how can I choose one of 
them?

- Or shouldn't I even bother about this since in the ASCII range CP437 and 
ISO-8859-1 map to the same characters? May I just boot the kernel using an 
unmatched pair of (CP437) charmap and (ISO-8859-1) font, feeling at ease 
because the kernel won't try to print any non-ASCII characters, and only 
later, in userspace, call loadunimap?

Am I understanding this correctly?

Thank you,

Mack
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

