Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbTKFNmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTKFNmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:42:49 -0500
Received: from imap.gmx.net ([213.165.64.20]:4260 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263565AbTKFNmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:42:46 -0500
X-Authenticated: #4512188
Message-ID: <3FAA5043.8060907@gmx.de>
Date: Thu, 06 Nov 2003 14:44:35 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA945DD.8030105@gmx.de> <20031106091746.GA1379@suse.de> <3FAA41C3.9060601@gmx.de> <3FAA45A9.20707@cyberone.com.au> <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de> <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de> <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de>
In-Reply-To: <20031106133136.GA477@suse.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>Heh indeed, maybe because the archs I use are still at 100. Looks
>>>suspiciously like it's loosing timer interrupts, which would indeed
>>>point to PIO.
>>>
>>
>>bash-2.05b# hdparm -I /dev/hdc
> 
> 
> -i please

bash-2.05b# hdparm -i /dev/hdc

/dev/hdc:

  Model=LITE-ON LTR-16102B, FwRev=OS0K, SerialNo=
  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
  IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 *mdma2
  AdvancedPM=no

  * signifies the current active mode

The same: dma is active.

> 
> 
>>Is it normal that SCSI subsystem gets init'ed, even though nothing of it 
>>is activated in the kernel?
> 
> 
> No, you still have it left in your kernel options.

Cannot be or there is a bug in the makefile. First I tried make 
oldconfig, then I noticed this thing coming up, so I did make clen and 
still  it caame, then mrproper and everything in config by hand, and 
still coming up. But I booted the "old" kernel up, where I didn't have 
thouse mouse stutterings and it alsa shows that scsi subsystem gets 
activated. What do I do wrong then? Should I post the .config?

Prakash

