Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSDWOEI>; Tue, 23 Apr 2002 10:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315220AbSDWOEH>; Tue, 23 Apr 2002 10:04:07 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36265 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315218AbSDWOEE>;
	Tue, 23 Apr 2002 10:04:04 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 23 Apr 2002 16:04:01 +0200 (MEST)
Message-Id: <UTC200204231404.g3NE41414336.aeb@smtp.cwi.nl>
To: dwmw2@infradead.org
Subject: Re: Flash device IDs
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        mdharm-usb@one-eyed-alien.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: David Woodhouse <dwmw2@infradead.org>

    >  No, I am afraid this thing doesn't let me talk to raw flash, or if it
    > does, I have not yet discovered how.

    Ok... so when you issue write commands, you're pretending it's a normal
    SCSI hard drive and issuing requests with the _logical_ block numbers?
    You don't have to grok the SmartMedia format and issue _physical_
    addresses on the flash, handle ECC, the block chains, etc.?

It is worse. The commands are SCSI-like, but vendor-unique.
So one has to discover the commands and the details of the
media format. I wrote an ECC routine, and do something more
or less random for the connection between logical and physical blocks.
If you have ECC and LBA/PBA handling, then there is more to merge.

[Things are not quite straightforward. I think the media uses
512+16 byte sectors, but my SCSI commands must use 512+64 byte
sectors.][Of course 512 and 16 are variables. Don't know about 64.]

Andries
