Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129671AbRBIOip>; Fri, 9 Feb 2001 09:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbRBIOig>; Fri, 9 Feb 2001 09:38:36 -0500
Received: from secure.webhotel.net ([195.41.202.80]:8261 "HELO
	secure.webhotel.net") by vger.kernel.org with SMTP
	id <S129671AbRBIOiY>; Fri, 9 Feb 2001 09:38:24 -0500
X-Authenticated-Timestamp: 15:40:43(CET) on February 09, 2001
Message-ID: <3A8400D7.82A61E6A@netgroup.dk>
Date: Fri, 09 Feb 2001 15:38:15 +0100
From: Peter Lund <firefly@netgroup.dk>
Organization: NetGroup A/S
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ionut@cs.columbia.edu
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox, Thu Feb 08 2001 - 02:42:52 EST:

> > It's the printk that gets it wrong, although that's harmless. 
> > Intel's documentation states that the bug does NOT exist if the 
> > bits 0 and 1 in eeprom[3] are 1. Thus, the workaround is correct, 
> > the printk is wrong. 
> 
> So why does it fix the problem for him. His report and your reply don't 
> make sense viewed together 

Wish I'd seen this patch about a month and a half before.  I had borrowed two
machines from IBM Denmark for evaluation and their motherboard mounted eepro100
cards (forget which exact chip version it was) didn't quite work with the driver
in the standard RH 6.2.

On boot up it said something about the Receiver lock up bug (only one of the two
messages, I think) and then it locked up anyway half an hour and a couple of
hundred ethernet packets later.  I didn't have time to look really closely at
the source code at the time :/

Just another data point indicating that the current receiver lock up enabling
code isn't good enough on newish chips.

-Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
