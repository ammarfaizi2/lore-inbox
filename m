Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAEQ0c>; Fri, 5 Jan 2001 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbRAEQ0X>; Fri, 5 Jan 2001 11:26:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22278 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129406AbRAEQ0K>; Fri, 5 Jan 2001 11:26:10 -0500
Subject: Re: Looking for maintainer of ENSONIQ SoundScape driver
To: rankinc@zipworld.com.au
Date: Fri, 5 Jan 2001 16:27:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <200101051413.f05EDu405677@wittsend.ukgateway.net> from "Chris Rankin" at Jan 05, 2001 02:13:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EZiH-0007yy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> would like to discuss with its maintainer, please. For instance,
> although /dev/mixer does not use sscape.o (the mixer driver is in the
> ad1848.o module), unloading sscape.o while a mixer application is

That sounds like the mixer calls sscape code and there is a locking error
somewhere that should have prevented the unload

> sscape.o allocates IO ports is also suspicious, and causes these
> messages to be logged every time the sound modules are loaded:
> 
> Jan 5 14:08:31 wittsend kernel: Trying to free nonexistent resource <00000338-00000339>
> Jan 5 14:08:31 wittsend kernel: Trying to free nonexistent resource <00000330-00000337>
> 

Look for request_resource/free_resource mismatches 

> There is no specific person mentioned in the MAINTAINERS file for this
> ISA PNP card, and I have received no response from the linux-sound
> mailing list.
> 
> Is there anybody out there? 

I dont think so.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
