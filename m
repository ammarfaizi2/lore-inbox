Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSHaGxF>; Sat, 31 Aug 2002 02:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSHaGxF>; Sat, 31 Aug 2002 02:53:05 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:23057 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S316322AbSHaGxD>; Sat, 31 Aug 2002 02:53:03 -0400
Date: Sat, 31 Aug 2002 01:57:30 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <Pine.LNX.4.10.10208302313040.1033-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0208310138420.23964-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2002, Andre Hedrick wrote:

> On Sat, 31 Aug 2002, Mike Isely wrote:
> 
> > On Fri, 30 Aug 2002, Andre Hedrick wrote:
> > 
> 
> Okay that sounds more like it.  The driver did not damage the data, only
> user space forced down the driver trashed it.  Regardless of the
> definition of "is" you system was wrecked.

No permanent harm.  It was a workstation, and most of the 160GB drive
was being used primarily as a backup device for a separate file server
machine.  Obviously I'd like to get that "backup device" up and running
again.


> 
> > 
> > > Linux failed to understand cut off partitions.
> > 
> > ???
> 
> This was a great concern of mine when 48-bit was introduced.

Ah, a riddle answered with another riddle.  I know what 48 bit addresing 
is; I'm just curious to understand why my system seems to have run afoul 
of it, especially since things were ok before.  (but read on...)


> > What are the "rules of Promise" or where may I find such information?
> 
> You do not want to sign the NDA's to get the data sheets, aquire all the
> hardware to test, generate tables of irregularities, query Promise, and
> then scratch your head why.

OK, Uncle!  I detect a lot of pain here and perhaps I'm exacerbating it
by asking.  The technical side of me just wants to understand.  I write
code for a living and have had my share of pain with crappy hardware
(though nothing even close to the scale at which you are working).  I
hate I2C, by the way, and don't ever ask me about the P.O.S. Philips
pcf8584.


> 
> I have a FastTrak 100 TX4 the BIOS fails to see beyond 128GB, but in
> practice it does.
> 
> The PDC20267 will puke in 48-bit DMA, but run clean in 48-bit PIO :-/
> Oh but that is the primary channel, Seconday Channel is clean both ways :-\

Oh goodie.  This can't be by design, but rather by stupid
implementation.  But I'll stop now before aggravating your ulcer :-)


> 
> PDC20262 works in 48-bit DMA every where.
> 
> PDC20265 similar to PDC20267 except yours.

But I'd still like to understand why my PDC20265 seems unique.  Earlier
hardware rev?  Later hardware rev?  Promise BIOS issue?  The Asus
A7V-266E motherboard was purchased December 2001.  If it's any help, I'm
staring at the chip on the board now.  The label shows:

  PROMISE (R)
  TECHNOLOGY INC.
  PDC20265R
  (C) 2000-0113

Maybe there is another cleaner way to go at this problem.


> 
> Rules are emperical tests and rants back at the OEM, and ....
> 

Sounds to me like you need a vacation ;-)


> > 
> > But this wasn't a problem in 2.4.19-ac4; what confounding factor now is 
> > making it difficult?
> 
> Cause there were reports of PDC20265/PDC20267 comming in as deadlocking.
> Thanks for the wrinkle in the fabric of ruleless world. :-)
> 

You're welcome :-)

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

