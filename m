Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRJOLu7>; Mon, 15 Oct 2001 07:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRJOLut>; Mon, 15 Oct 2001 07:50:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37297 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272280AbRJOLuj>;
	Mon, 15 Oct 2001 07:50:39 -0400
Date: Mon, 15 Oct 2001 07:51:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <20011015133506.B4269@kushida.jlokier.co.uk>
Message-ID: <Pine.GSO.4.21.0110150742230.8707-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Jamie Lokier wrote:

> This does not work.  Example:
> 
>   1. JamieEmacs loads file using MAP_PRIVATE.
>   2. Something else writes to the file.
>   3. Scroll to the bottom of the file in JamieEmacs.  It displays some
>      of the newly written data, though not all of it.
> 
> --> Wrong editor semantics.

--> Wrong permissions or hopelessly crappy source control system.

At point 2 you are _already_ screwed.  Depending on who hits (hell,
what's the equivalent of :x in Emacsese?) first, one of you is
going to lose results of editing.  Doctor, it hurts when I do it...

If you want versioning - use source control system.  Or go play
with DEC cra^WOSes.  In RSX that "feature" sucked (and so did
editor semantics, but that's a separate story).

Without versioning - see above.

