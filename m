Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQLSW4r>; Tue, 19 Dec 2000 17:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbQLSW4h>; Tue, 19 Dec 2000 17:56:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32261 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129477AbQLSW4T>;
	Tue, 19 Dec 2000 17:56:19 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012192225.WAA00449@raistlin.arm.linux.org.uk>
Subject: Re: set_rtc_mmss: can't update from 0 to 59
To: oxymoron@waste.org (Oliver Xymoron)
Date: Tue, 19 Dec 2000 22:25:24 +0000 (GMT)
Cc: mdharm-kernel@one-eyed-alien.net (Matthew Dharm), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0012191510570.18938-100000@waste.org> from "Oliver Xymoron" at Dec 19, 2000 03:13:03 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron writes:
> On Mon, 18 Dec 2000, Russell King wrote:
> > So, why don't we update the hours and be done with it?  We would have to
> > play the same game with the days of the month vs hours.  Also, we don't
> > know if the CMOS clock is programmed for UTC time or not (the kernel's
> > idea of time is UTC.  Your CMOS may be programmed for EST for instance).
> 
> Sounds like its still broken then - there are time zones which are not
> even multiples of 60 minutes.

Correct; please examine the code and you will find the answer to this.
Specifically, look at the lines around the following comment:

	/* correct for half hour time zone */
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
