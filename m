Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRH0Tzi>; Mon, 27 Aug 2001 15:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbRH0Tz2>; Mon, 27 Aug 2001 15:55:28 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:50348 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S267520AbRH0TzV>; Mon, 27 Aug 2001 15:55:21 -0400
Date: Mon, 27 Aug 2001 13:55:44 -0600
Message-Id: <200108271955.f7RJtia19506@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010827185803Z16034-32384+632@humbolt.nl.linux.org>
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva>
	<20010827142441Z16237-32383+1641@humbolt.nl.linux.org>
	<200108271848.UAA20391@ns.cablesurf.de>
	<20010827185803Z16034-32384+632@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> The quesion is, how do you know you're streaming?  Some files are
> read/written many times and some files are accessed randomly.  I'm
> trying to avoid penalizing these admittedly rarer, but still
> important cases.

I wonder if we're trying to do the impossible: an algorithm that works
great for very different workloads, without hints from the process.

Shouldn't we encourage use of madvise(2) more? And if needed, add
O_DROPBEHIND and similar flags for open(2).

The application knows how it's going to use data/memory. It should
tell the kernel so the kernel can choose the best algorithm.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
