Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291080AbSAaOBD>; Thu, 31 Jan 2002 09:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291078AbSAaOAo>; Thu, 31 Jan 2002 09:00:44 -0500
Received: from elin.scali.no ([62.70.89.10]:32004 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S291076AbSAaOAb>;
	Thu, 31 Jan 2002 09:00:31 -0500
Subject: Re: TCP/IP Speed
From: Terje Eggestad <terje.eggestad@scali.com>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020130114353.15469A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020130114353.15469A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 31 Jan 2002 15:00:27 +0100
Message-Id: <1012485627.21288.100.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm, 

I tend to use the rdtsc register to do these kind of measurements, 
but I get ~110 uS round trip with or without TCP_NDELAY

I get ~100uS wehen pinging with raw ethernet frames.

PS: Intel 82557 Ethernet Pro 100 NIC's

TJ

ons, 2002-01-30 kl. 17:47 skrev Richard B. Johnson:
> On Wed, 30 Jan 2002, Zwane Mwaikambo wrote:
> 
> > On Wed, 30 Jan 2002, Richard B. Johnson wrote:
> > 
> > > But it's already connected.
> > > 
> > > 
> > >          host:
> > >          for (;;) {
> > >             gettimeofday(...);
> > >             write(s, buf, 64);
> > >             read(s, buf, sizeof(buffer));
> > >             gettimeofday(...);
> > >          /* delay is 1.0 ms */
> > >          }
> > >          server is IPPORT_ECHO
> > 
> > You didn't make that explicit in your previous email, and anyway what kind 
> > of resolution can you expect from gettimeofday...
> > 
> 
> The resolution is in microseconds. That's the specification. Not
> all 'codes' are exercised of course, but the resolution is sufficient
> to discern a 10 to 30 microsecond difference. I'm trying to measure
> milliseconds, well within its capability. FYI, this is what `ping`
> and `traceroute` use. It's fine.
> 
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

