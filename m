Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131223AbRBETmZ>; Mon, 5 Feb 2001 14:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131661AbRBETmB>; Mon, 5 Feb 2001 14:42:01 -0500
Received: from cloudburst.umist.ac.uk ([130.88.119.66]:22288 "EHLO
	cloudburst.umist.ac.uk") by vger.kernel.org with ESMTP
	id <S130115AbRBETlo>; Mon, 5 Feb 2001 14:41:44 -0500
From: "Thomas Stewart" <T.Stewart@student.umist.ac.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Date: Mon, 5 Feb 2001 19:41:41 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: d-link dfe-530 tx (bug-report)
CC: Urban Widmark <urban@teststation.com>,
        Jonathan Morton <chromi@cyberspace.org>, linux-kernel@vger.kernel.org,
        ksa1 <ksa1@gmx.de>
Message-ID: <3A7F01F5.26400.B02DBA@localhost>
In-Reply-To: <3A7E873E.54E3ECC2@colorfullife.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Feb 2001, at 11:58, Manfred Spraul wrote:

> Thomas Stewart wrote:
> Several regs are just the wakeup frames, but some look suspicious.
> 
> Could you try Urban's patch, but add
> 
> <<<<<<<<
>  writeb(0x00, ioaddr + 0x83);
>  writel(0x01010000, ioaddr + 0xa0);
>  writel(0x01010000, ioaddr + 0xa4)
>  writew(0xffff, ioaddr + 0x72);
>  writeb(0x08, ioaddr + 0x96);
> >>>>>>>>>
> 
> just before
> +      writeb(0x40, ioaddr + 0x81);    /* Force software reset */
> (around line 540)

Right, I tryed that, mac address still reported as 00:00:00:00:00:00 
on boot.

I also turned on a bios option to try to reset pnp things.

Also now I cant get the card to do the dhcpcd stuff now, oh why 
didn't I just buy an ne2000 :)

regards
tom

---------------------------------------------------------
 This message is ROT-13 encoded twice for extra security
 Thomas Stewart - t.stewart@student.umist.ac.uk
 This should contain no attachments
---------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
