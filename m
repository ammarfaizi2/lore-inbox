Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132435AbQKZS5W>; Sun, 26 Nov 2000 13:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130900AbQKZS5M>; Sun, 26 Nov 2000 13:57:12 -0500
Received: from oracle.clara.net ([195.8.69.94]:268 "EHLO oracle.clara.net")
        by vger.kernel.org with ESMTP id <S132435AbQKZS5A>;
        Sun, 26 Nov 2000 13:57:00 -0500
From: "Phil Randal" <phil@rebee.clara.co.uk>
To: <linux-kernel@vger.kernel.org>, Paul Jakma <paulj@itg.ie>
Date: Sun, 26 Nov 2000 18:27:10 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: problem with hp C1537A tape drives
Message-ID: <3A2155FE.14692.110282@localhost>
In-Reply-To: <Pine.LNX.4.30.0011261520220.892-100000@rossi.itg.ie>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date sent:      	Sun, 26 Nov 2000 15:33:00 +0000 (GMT)
From:           	Paul Jakma <paulj@itg.ie>
To:             	<linux-kernel@vger.kernel.org>
Subject:        	problem with hp C1537A tape drives

> I have a problem with the aforementioned DDS-3 tape drives. I'm using
> one with amanda for backups. But every now and then the nightly backup
> fails with "I/O error" and i see the following in the system logs:
> 
> st0: Error with sense data: [valid=0] Info fld=0x0, Current st09:00:
> sense key Aborted Command
> Additional Sense indicates Data phase error
> 
> I try various things to get the drive to work again -> mt rewind, mt
> retension, load and unload the tape. "scsi remove-single-device" ->
> power off drive -> power up -> "scsi add-single-device". (it's not the
> tape cause i've tried replacing tapes).
>
> but nothing helps. now it mightn't be unreasonable to say the drive is
> faulty, so i replaced the drive with an identical C1537A. And... same
> thing happens again: after a couple of weeks of good backups i get the
> same problem again.
> 
> Is there a known problem with SCSI tape drives? or with HP DDS-3
> drives? What does the kernel error message mean? (it's all 0's so not
> much i guess). What is a "Data Phase error"?

Ah, have you tried cleaning the tape heads?

The Compaq tape drive manuals have interesting cleaning
instructions...  With new tapes, the heads nead cleaning
far more frequently than you'd expect.  I've found it needs
two cleaning tape passes to clear this one. 

Cleaning solves a similar problem I get with these drives
and Backup Exec for Netware.

Phil

--------------------------------------------------------------------
Phil Randal                           Home: phil@rebee.clara.co.uk
Worcester, UK                               http://www.rebee.clara.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
