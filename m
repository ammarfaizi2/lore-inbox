Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135883AbRAMBRg>; Fri, 12 Jan 2001 20:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136088AbRAMBR1>; Fri, 12 Jan 2001 20:17:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46865 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135883AbRAMBRN>; Fri, 12 Jan 2001 20:17:13 -0500
Date: Fri, 12 Jan 2001 17:16:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Heil <kerndev@sc-software.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.3.95.1010112165949.1292b-100000@scsoftware.sc-software.com>
Message-ID: <Pine.LNX.4.10.10101121713120.851-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, John Heil wrote:
> 
> Yes, initially the 686a was problematic, now with an 80 wire cable its
> fine. 
> 
> One point of clarification... I started out with a simple hdparm -d1
> which failed 85% of the time. I added the other stuff only to enhance the
> -d0 state I was left with.

This sounds like a totally different thing than the DMA corruption - this
sounds like you just got CRC error messages, and the driver still did the
right thing? 

The 82c586 corruption seems to be silently just writing (and maybe
reading) bad data to the disk.

The case of CRC errors and recivering from them (or fixing them with a
good cable) is different - when the CRC errors are noticed, they cause the
command to be re-tried and thus no data corruption should occur.

Basically it's the difference between being "silently bad" and "noisily
good". Sounds like you are in the "noisily good" category - a category
that I don't worry about ;)

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
