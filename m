Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSEHV3U>; Wed, 8 May 2002 17:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315211AbSEHV3T>; Wed, 8 May 2002 17:29:19 -0400
Received: from vpl.usc.edu ([128.125.21.202]:54656 "EHLO vpl.usc.edu")
	by vger.kernel.org with ESMTP id <S315210AbSEHV3S>;
	Wed, 8 May 2002 17:29:18 -0400
Date: Wed, 8 May 2002 14:29:16 -0700
From: Joaquin Rapela <rapela@usc.edu>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: es1371 sound problem
Message-ID: <20020508142916.B1665@plato.usc.edu>
In-Reply-To: <20020507215024.B11180@plato.usc.edu> <3CD91486.80903@sktc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 07:05:26AM -0500, David D. Hagood wrote:
> Joaquin Rapela wrote:
> > Hello,
> > 
> > I am having problems with a sound card. When I play a sound the machine becomes
> > frozen.
> > 
> > sndconfig tells reports an Ensoniq|ES1371 [AudioPCI-97]
> > 
> > After my machine recovers from the frozen stage I read the following in
> > /var/log/messages:
> > 
> > May  7 21:34:58 plato kernel: scsi : aborting command due to timeout : pid 0,
> > scsi0, channel 0, id 0, lun 0 Write (10) 00 01 05 aa 19 00 00 26 00 
> 
> Since the log message is from your SCSI card, it would have been helpful 
> to know what kind of SCSI card you have, and how it and the ES1371 are 
> mapped in terms of interrupts.

Dear David,

My scsi is an ADAPTEC AIC-7896 mapped to irq=10, my sound card is an
Ensoniq|ES1371 [AudioPCI-97] mapped to irq=11.

> 
> It sounds like your SCSI card and your sound card are on the same 
> interrupt, and the SCSI card isn't sharing. Perchance is your SCSI card 
> an ISA card? If so, then you need to tell your computer's BIOS that the 
> SCSI card's interrupt is "Reserved for legacy ISA" so the sound card 
> won't be assigned to that interrupt.

It seems that my scsi is not ISA. When I set in BIOS irq10 to ISA neither the
scsi card or the sound card use irq10.

I am wondering how the scsi could be interfering with the sound card if the two
card are using different IRQs.

Thanks for your help, Joaquin

-- 
Joaquin Rapela
PhD Student, Visual Processing Group
University of Southern California
3650 South McClintock Ave.
Olin Hall of Engineering 500
Los Angeles, CA 90089-1451
tel/fax: (213) 821-2070
----------------------------------

"Respectfully keep at your studies constantly, and then you will have results."

                                                                     Confucius
