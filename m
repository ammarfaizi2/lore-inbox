Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280025AbRKDXP7>; Sun, 4 Nov 2001 18:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280030AbRKDXPt>; Sun, 4 Nov 2001 18:15:49 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:26081 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S280025AbRKDXPd>; Sun, 4 Nov 2001 18:15:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.14-pre6
Date: Mon, 5 Nov 2001 00:16:30 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.33.0110310809200.32460-100000@penguin.transmeta.com> <3BE1B6CD.7DA43A6C@zip.com.au> <20011104233416.D1875@elf.ucw.cz>
In-Reply-To: <20011104233416.D1875@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011104231526Z17058-18972+16@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 11:34 pm, Pavel Machek wrote:
> > Another potential microoptimisation would be to write out
> > clean blocks if that helps merging.  So if we see a write
> > for blocks 1,2,3,5,6,7 and block 4 is known to be in memory,
> > then write it out too.  I suspect this would be a win for
> > ATA but a loss for SCSI.  Not sure.
> 
> Please don't do this, it is bug.
> 
> If user did not ask writing somewhere, DO NOT WRITE THERE! If power
> fails in the middle of the sector... Or if that is flashcard....

or raid or nbd...

> Just don't do this.

--
Daniel
