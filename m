Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277512AbRJOMa0>; Mon, 15 Oct 2001 08:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRJOMaQ>; Mon, 15 Oct 2001 08:30:16 -0400
Received: from pcephc56.cern.ch ([137.138.38.92]:53632 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S277512AbRJOM35>; Mon, 15 Oct 2001 08:29:57 -0400
Date: Mon, 15 Oct 2001 14:29:03 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011015142903.E4269@kushida.jlokier.co.uk>
In-Reply-To: <20011015133506.B4269@kushida.jlokier.co.uk> <Pine.GSO.4.21.0110150742230.8707-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110150742230.8707-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Oct 15, 2001 at 07:51:11AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> > This does not work.  Example:
> > 
> >   1. JamieEmacs loads file using MAP_PRIVATE.
> >   2. Something else writes to the file.
> >   3. Scroll to the bottom of the file in JamieEmacs.  It displays some
> >      of the newly written data, though not all of it.
> > 
> > --> Wrong editor semantics.
> 
> --> Wrong permissions or hopelessly crappy source control system.
> 
> At point 2 you are _already_ screwed.  Depending on who hits (hell,
> what's the equivalent of :x in Emacsese?) first, one of you is
> going to lose results of editing.  Doctor, it hurts when I do it...

I am _not_ saving anything.  Viewing
/home/web/automatically_generated_every_hour.html from a particular
moment is a perfectly reasonable thing to do in Emacs, and it's a
perfectly reasonable thing to do in Less and Midnight Commander and
Mozilla for that matter.

_If_ I hit :x (in Vi-mode in Emacs ;-) then I expect the editor to warn
me that the file was updated by some other program.  Some editors will
warn before that.  Some will reload the file automatically if I haven't
made changed within the editor.

However, at all times I expect a consistent display of the file either
from read time, or from the current time.  _Never_ some unparsable,
invalid, mixed up combination of pages.

> If you want versioning - use source control system.  Or go play
> with DEC cra^WOSes.  In RSX that "feature" sucked (and so did
> editor semantics, but that's a separate story).

I do _not_ want versioning.  I want to load a file into an editor and
look at _that_ snapshot, at my leisure.  (Almost) every editor ever
written works this way, and I am quite happy with it.

read() gives the correct semantics.

There is potential to make read() more efficient, both in execution time
and in memory consumption.

Enjoy :-)

-- Jamie
