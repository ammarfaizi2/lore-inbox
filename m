Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265149AbRGERGZ>; Thu, 5 Jul 2001 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265916AbRGERGQ>; Thu, 5 Jul 2001 13:06:16 -0400
Received: from [192.187.140.129] ([192.187.140.129]:58597 "EHLO paracel.com")
	by vger.kernel.org with ESMTP id <S265149AbRGERGC>;
	Thu, 5 Jul 2001 13:06:02 -0400
From: "Christophe Beaumont" <christophe@paracel.com>
To: <root@chaos.analogic.com>
Cc: "kernel Linux" <linux-kernel@vger.kernel.org>
Subject: RE: DMA memory limitation?
Date: Thu, 5 Jul 2001 10:07:17 -0700
Message-ID: <NFBBINOGHMOOBMPNBAHKCEPECEAA.christophe@paracel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <Pine.LNX.3.95.1010705082119.19376B-100000@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Thu, 5 Jul 2001, Vasu Varma P V wrote:
> 
> > Hi,
> > 
> > Is there any limitation on DMA memory we can allocate using
> > kmalloc(size, GFP_DMA)? I am not able to acquire more than
> > 14MB of the mem using this on my PCI SMP box with 256MB ram.
> > I think there is restriction on ISA boards of 16MB.
> > Can we increase it ?
> > 
> > thx,
> > Vasu
> 
> 14MB of DMA(able) memory?  Err. I think you are trying to
> do something you would never need to do.
> 
And what is that supposed to be????

I have a piece of pretty well designed hardware here... and my
application requires me to have the PCI board to random access
in master mode a whole lot of memory (anywhere from 128MEGS to
1GIG... and possibly more...) so I really do need BIG DMA buffers
(I don't say huge anymore as one can get 1/2 Gig of RAM for just
over 120 bucks???)... 

There is no way I can have the piece of hardware behave in 
another fashion... and NO it is NOT broken (when you do BOTH 
hardware & software, you know about BOTH limitations... there
are just some cases where you have to face some unique issues).
the mem=1024M works pretty fine once you have figured out how 
to handle in a fairly simple way this "reserved" memory...

So please software people... do not blame it all on the 
hardware... =)

Chris.
