Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268570AbRH0UJa>; Mon, 27 Aug 2001 16:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268432AbRH0UJU>; Mon, 27 Aug 2001 16:09:20 -0400
Received: from ns.cablesurf.de ([195.206.131.193]:40699 "EHLO ns.cablesurf.de")
	by vger.kernel.org with ESMTP id <S268570AbRH0UJG>;
	Mon, 27 Aug 2001 16:09:06 -0400
Message-Id: <200108272019.WAA20893@ns.cablesurf.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 22:09:25 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva> <20010827185803Z16034-32384+632@humbolt.nl.linux.org> <200108271955.f7RJtia19506@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200108271955.f7RJtia19506@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. August 2001 21:55 schrieb Richard Gooch:
> Daniel Phillips writes:
> > The quesion is, how do you know you're streaming?  Some files are
> > read/written many times and some files are accessed randomly.  I'm
> > trying to avoid penalizing these admittedly rarer, but still
> > important cases.
>
> I wonder if we're trying to do the impossible: an algorithm that works
> great for very different workloads, without hints from the process.

For streaming we should be able to detect consecutive reads.
If it's not that easy could we not measure hit/miss ratios ?

> Shouldn't we encourage use of madvise(2) more? And if needed, add
> O_DROPBEHIND and similar flags for open(2).

For symmetry rather fadvise. Besides usage patterns may change.

	Regards
		Oliver
