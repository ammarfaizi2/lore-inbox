Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311094AbSCHUbd>; Fri, 8 Mar 2002 15:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311082AbSCHUak>; Fri, 8 Mar 2002 15:30:40 -0500
Received: from miranda.axis.se ([193.13.178.2]:21710 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S311094AbSCHUa2>;
	Fri, 8 Mar 2002 15:30:28 -0500
From: johan.adolfsson@axis.com
Message-ID: <034601c1c6e0$064bf620$aab270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: <root@chaos.analogic.com>, <johan.adolfsson@axis.com>
Cc: "Jamie Lokier" <lk@tantalophile.demon.co.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Terje Eggestad" <terje.eggestad@scali.com>,
        "Ben Greear" <greearb@candelatech.com>,
        "Davide Libenzi" <davidel@xmailserver.org>,
        "george anzinger" <george@mvista.com>
In-Reply-To: <Pine.LNX.3.95.1020308143013.6910A-100000@chaos.analogic.com>
Subject: Re: gettimeofday() system call timing curiosity
Date: Fri, 8 Mar 2002 21:29:59 +0100
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

>
> > What happens if you remove the printf/puts and simply counts the number
> > of times the different cases happen?
> >
>
> Try it. It doesn't matter. Alan was correct, my computer sucks. However,
> they won't give me a 10 GHz one (yet). Note that although gettimeofday()
> has 1 microsecond resolution, not all the codes are exercised. We get
> something with the granularity of 50 to 190 microseconds.

I admit that I don't know the details of the x86 implementation,
but that sounds a little to large doesn't it?

I recently fixed the cris port to get 1 us resolution (by reading a
25MHz timer value within a jiffie).
My tests show that the time between calls to gettimeofday() typically
is 4-5 us on the 100MIPS ETRAX100LX - not that bad.
On my Linux PC i got 1us most of the time but never the same value,
but that is an old machine - PII 266 (reminds me I need to change machine:).

..
>
> Cheers,
> Dick Johnson

/Johan


