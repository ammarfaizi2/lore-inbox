Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278643AbRJ1TNG>; Sun, 28 Oct 2001 14:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278647AbRJ1TM5>; Sun, 28 Oct 2001 14:12:57 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:54520 "HELO
	pobox.com") by vger.kernel.org with SMTP id <S278643AbRJ1TMo>;
	Sun, 28 Oct 2001 14:12:44 -0500
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
To: zlatko.calusic@iskon.hr
Date: Sun, 28 Oct 2001 11:13:28 -0800 (PST)
Cc: torvalds@transmeta.com (Linus Torvalds), axboe@suse.de (Jens Axboe),
        marcelo@conectiva.com.br (Marcelo Tosatti), linux-mm@kvack.org,
        linux-kernel@vger.kernel.org (lkml)
Reply-To: barryn@pobox.com
In-Reply-To: <87k7xfk6zd.fsf@atlas.iskon.hr> from "Zlatko Calusic" at Oct 28, 2001 06:30:14 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011028191328.CCC828A6EA@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately, things didn't change on my first disk (IBM 7200rpm
> @home). I'm still getting low numbers, check the vmstat output at the
> end of the email.
> 
> But, now I found something interesting, other two disk which are on
> the standard IDE controller work correctly (writing is at 17-22
> MB/sec). The disk which doesn't work well is on the HPT366 interface,
> so that may be our culprit. Now I got the idea to check patches
> retrogradely to see where it started behaving poorely.
> 
> Also, one more thing, I'm pretty sure that under strange circumstances
> (specific alignment of stars) it behaves well (with appropriate
> writing speed). I just haven't yet pinpointed what needs to be done to
> get to that point.

I didn't read the entire thread, so this is a bit of a stab in the dark,
but:

This really reminds me of a problem I once had with a hard drive of
mine. It would usually go at 15-20MB/sec, but sometimes (under both
Linux and Windows) would slow down to maybe 350KB/sec. The slowdown, or
lack thereof, did seem to depend on the alignment of the stars. I lived
with it for a number of months, then started getting intermittent I/O
errors as well, as if the drive had bad sectors on disk.

The problem turned out to be insufficient ventilation for the controller
board on the bottom of the drive -- it was in the lowest 3.5" drive bay
in my case, so the bottom of the drive was snuggled next to a piece of
metal with ventilation holes. The holes were rather large (maybe 0.5"
diameter) -- and so were the areas without holes. Guess where one of the
drive's controller chips happened to be positioned, relative to the
holes? :( Moving the drive up a bit in the case, so as to allow 0.5"-1"
of space for air beneath the drive, fixed the problem (both the slowdown
and the I/O errors).

I don't know if this is your problem, but I'm mentioning it just in
case it is...

-Barry K. Nathan <barryn@pobox.com>
