Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSEHMFb>; Wed, 8 May 2002 08:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSEHMFa>; Wed, 8 May 2002 08:05:30 -0400
Received: from oak.sktc.net ([208.46.69.4]:38154 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S313384AbSEHMF3>;
	Wed, 8 May 2002 08:05:29 -0400
Message-ID: <3CD91486.80903@sktc.net>
Date: Wed, 08 May 2002 07:05:26 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020413
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joaquin Rapela <rapela@usc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: es1371 sound problem
In-Reply-To: <20020507215024.B11180@plato.usc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joaquin Rapela wrote:
> Hello,
> 
> I am having problems with a sound card. When I play a sound the machine becomes
> frozen.
> 
> sndconfig tells reports an Ensoniq|ES1371 [AudioPCI-97]
> 
> After my machine recovers from the frozen stage I read the following in
> /var/log/messages:
> 
> May  7 21:34:58 plato kernel: scsi : aborting command due to timeout : pid 0,
> scsi0, channel 0, id 0, lun 0 Write (10) 00 01 05 aa 19 00 00 26 00 

Since the log message is from your SCSI card, it would have been helpful 
to know what kind of SCSI card you have, and how it and the ES1371 are 
mapped in terms of interrupts.

It sounds like your SCSI card and your sound card are on the same 
interrupt, and the SCSI card isn't sharing. Perchance is your SCSI card 
an ISA card? If so, then you need to tell your computer's BIOS that the 
SCSI card's interrupt is "Reserved for legacy ISA" so the sound card 
won't be assigned to that interrupt.


