Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135964AbRAMAqa>; Fri, 12 Jan 2001 19:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135970AbRAMAqV>; Fri, 12 Jan 2001 19:46:21 -0500
Received: from [216.184.166.130] ([216.184.166.130]:2874 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S135964AbRAMAqL>; Fri, 12 Jan 2001 19:46:11 -0500
Date: Fri, 12 Jan 2001 16:43:40 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, Vojtech Pavlik <vojtech@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <E14HEVf-0005K2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.1010112162542.1292a-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001, Alan Cox wrote:

> Date: Sat, 13 Jan 2001 00:25:28 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
> Subject: Re: ide.2.4.1-p3.01112001.patch
> 
> > what the bug is, and whether there is some other work-around, and whether
> > it is 100% certain that it is just those two controllers (maybe the other
> > ones are buggy too, but the 2.2.x tests basically cured their symptoms too
> > and peopl ehaven't reported them because they are "fixed").
> 
> I've not seen reports on the later chips. If they had been buggy and then 
> fixed I'd have expected much unhappy ranting before the change

The "fix" was an hdparm command like hdparm -X66 -m16c1d1 /dev/hda.
Which I set for my VIA 686a on a Tyan mobo w a 1G Athlon.

Interestingly, initially feeding that chip 40 wire cables (w/o the
-X66 of course) would result in the crc errors followed by DMA turn off,
about 85% of time... Other 15% was fine and DMA worked great.

I then switched to the 80 wire cable and DMA became rock solid at
which point the -X66 was added.

Just thought I'd add some data points :) 

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
kerndev@sc-software.com
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
