Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRB0Sna>; Tue, 27 Feb 2001 13:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129754AbRB0SnU>; Tue, 27 Feb 2001 13:43:20 -0500
Received: from www.topmail.de ([212.255.16.226]:61653 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S129747AbRB0SnG> convert rfc822-to-8bit;
	Tue, 27 Feb 2001 13:43:06 -0500
Message-ID: <000001c0a0ed$1ea188d0$742c9c3e@tp.net>
From: "Thorsten Glaser Geuer" <eccesys@topmail.de>
To: "LKML" <linux-kernel@vger.kernel.org>,
        "Mack Stevenson" <mackstevenson@hotmail.com>
In-Reply-To: <F281raFC8XymNMDdckH00012e6f@hotmail.com>
Subject: Re: ISO-8859-1 completeness of kernel fonts?
Date: Tue, 27 Feb 2001 16:26:21 -0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> The 8x16 and Sun 12x22 kernel fonts I tried seem to lack some standard 
> glyphs necessary to represent the entire ISO-8859-1 charmap; I am talking 
> about all accented capital vowels except for 'I'.
> 
> This seems to happen in both 2.2.16 as well as in 2.2.18.
> 
> Is this intentional? If so, why?
> 
> How can I override this behaviour?
> 
> Thank you.
> 
> Cheers,
> 
> Mack Stevenson

I have converted my fonts by hand (with a GW-BASIC proggy) from bitmap
to .c, though not the SUN fonts for ISO but the PC fonts for cp437.
I did this because I do not like e.g. the glyph "0" in standard font
and included the "Euro" sign. (I use the same for DOS and Linux now,
and even Windoze recently got it as Terminal font!)

My second suggestion: code it as .psfu and load it by setfont, including
the appropiate console-map. AFAIK all the kernel default fonts are cp437
(linux/drivers/char/cp437.uni; consolemap.*)

-mirabilos


