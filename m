Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130107AbQLSXYj>; Tue, 19 Dec 2000 18:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130464AbQLSXY3>; Tue, 19 Dec 2000 18:24:29 -0500
Received: from waste.org ([209.173.204.2]:4656 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S130107AbQLSXYT>;
	Tue, 19 Dec 2000 18:24:19 -0500
Date: Tue, 19 Dec 2000 16:53:46 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: set_rtc_mmss: can't update from 0 to 59
In-Reply-To: <200012192225.WAA00449@raistlin.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0012191633350.18938-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2000, Russell King wrote:

> Oliver Xymoron writes:
> > On Mon, 18 Dec 2000, Russell King wrote:
> > > So, why don't we update the hours and be done with it?  We would have to
> > > play the same game with the days of the month vs hours.  Also, we don't
> > > know if the CMOS clock is programmed for UTC time or not (the kernel's
> > > idea of time is UTC.  Your CMOS may be programmed for EST for instance).
> >
> > Sounds like its still broken then - there are time zones which are not
> > even multiples of 60 minutes.
>
> Correct; please examine the code and you will find the answer to this.
> Specifically, look at the lines around the following comment:
>
> 	/* correct for half hour time zone */

Uhh.. Kathmandu? Chatham Island? +5:45 and +13:45 (DST) respectively.

At any rate, the printk should go - do_timer_interrupt already expects the
"bug"  its reporting.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
