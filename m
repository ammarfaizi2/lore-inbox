Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319058AbSHSUWd>; Mon, 19 Aug 2002 16:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319059AbSHSUWc>; Mon, 19 Aug 2002 16:22:32 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44548
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319058AbSHSUWb>; Mon, 19 Aug 2002 16:22:31 -0400
Date: Mon, 19 Aug 2002 13:26:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Michael Dreher <dreher@math.tsukuba.ac.jp>
cc: linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu,
       alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.20-pre2-ac2 pcmcia panic
In-Reply-To: <20020819150841.69B1113B47@abel.math.tsukuba.ac.jp>
Message-ID: <Pine.LNX.4.10.10208191325160.458-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is an addition to be added in ide-probe.c in do_identify.

For cdroms and maybe all atapi
drive->special.all = 0;

On Mon, 19 Aug 2002, Michael Dreher wrote:

> Hi Alan, Hi David,
> 
> somehow IDE over PCMCIA has stopped working.
> 
> 2.4.20-pre2 with pcmcia-cs-3.2.1 is OK (dmesg and lspci -v are attached).
> 2.4.20-pre2-ac2 with pcmcia-cs-3.2.1 locks the box and makes 2 LEDs blink.
> Nothing in the logs, unfortunately no serial console (this is my only 
> computer at the moment).
> 
> 2.4.19-ac4 with pcmcia-cs-3.1.33 shows the same symptoms.
> 2.4.19-ac4 with pcmcia-cs-3.1.34 does not lock up, but also does not work.
> 
> Kernel pcmcia never worked on this box, so I had to resort to the version of
> David Hinds.
> 
> I could not try 2.4.20-pre2-ac4, since it boots extremely slow.
> All usb related messages come after some long timeout only, and somewhere
> in init it stops.
> 
> sorry for this vague description. If you need more info, just ask.
> 
> Best regards,
> Michael
> 

Andre Hedrick
LAD Storage Consulting Group

