Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317785AbSFSGdN>; Wed, 19 Jun 2002 02:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317786AbSFSGdM>; Wed, 19 Jun 2002 02:33:12 -0400
Received: from zwanebloem.xs4all.nl ([213.84.22.107]:30873 "EHLO
	thuis.zwanebloem.nl") by vger.kernel.org with ESMTP
	id <S317785AbSFSGdL>; Wed, 19 Jun 2002 02:33:11 -0400
Date: Wed, 19 Jun 2002 08:53:31 +0200
From: faasen@xs4all.nl
To: linux-kernel@vger.kernel.org
Subject: Re: VIA KT266 PCI-related crashes fixed.  Now whats the catch?
Message-ID: <20020619065331.GB12167@router.zwanebloem.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> G'day Alan, all,
> 
> In November, I assembled a new machine using a Soyo Dragon+ mb with a
> Pinnacle PCTV/Pro card as the only add-in board (I have an ATI 7500 in the
> AGP slot).  Very quickly I learned that any heavy disk activity (from two
> UDMA100 drives) during TV card use would lock the system tight.  As long
> as I didn't use the TV card, the system was completely solid -- under
> heavy disk, sound, net usage, etc.  I tried moving the card around,
> playing with BIOS, upgrading BIOS, with no success.  I dug around in
> quirks.c and put a serious dent in google's usage reports trying to find
> answers.  About the time I was concluding that I had a defective mb, a
> friend decided to install Linux on his KT266 system also.  After the
> install, we popped a PCTV (non-PRO minus FM radio) into it and ended up
> duplicating my machines's crashing behaviour.
> 
> About a month ago, after giving up and either avoiding TV card use (which
> given the state of US TV isn't a completely bad thing :-), or resigning
> myself to not doing serious work if I had the TV card on, I stumbled
> across Serguei Miridonov's site (http://www.cicese.mx/~mirsev/Linux/VIA/).  
> His small module changes PCI config register 0x75 from 0x01 to 0x07 and
> clears all the bits on 0x76 (originally set to 0x10 on my mb).  The result
> has been perfect stability for both boards with TV cards and as much disk
> and other I/O as bonnie and friends could generate.
> 
> Alan, given that you are one of gurus on VIA chipset quirks, what am I 
> trading off on this?  Is this an isolated quirk, or have I stumbled across 
> something mildly useful to others?
> 
> Any insights would be appreciated.
> 
> Many thanks,
>

I have an epox kta3 aka VIA kt133a chipset which has the odd habit to freeze after 10-30 minutes in linux or
winxp even when not using the tv card. If I perfom a warm reset after post the system is perfectly stable.
Except the cdwriter I have scsi only system. 

Is there any relation to this problem?

I also read 2 weeks ago that VIA confirmed that they didn't have some intel PCI extentions that some pci card
makers assume like the ceative SBlive which caused some known problems.

Although I am pretty used to the warm reset before bot-up I rather see the problem fixed, I'll have a go with this
"fix".

Tommy 
> -- 
> 
> -Jonathan <davis@jdhouse.org>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

