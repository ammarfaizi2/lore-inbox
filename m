Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271661AbRHQOUc>; Fri, 17 Aug 2001 10:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271663AbRHQOUW>; Fri, 17 Aug 2001 10:20:22 -0400
Received: from borg.org ([208.218.135.231]:30995 "HELO borg.org")
	by vger.kernel.org with SMTP id <S271661AbRHQOUL>;
	Fri, 17 Aug 2001 10:20:11 -0400
Date: Fri, 17 Aug 2001 10:20:24 -0400
From: Kent Borg <kentborg@borg.org>
To: Andi Kleen <freitag@alancoxonachip.com>
Cc: linux-kernel@vger.kernel.org, ehaase@inf.fu-berlin.de
Subject: Re: ext2 not NULLing deleted files?
Message-ID: <20010817102024.A19505@borg.org>
In-Reply-To: <01081709381000.08800@haneman.suse.lists.linux.kernel> <oupitfnw1st.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <oupitfnw1st.fsf@pigdrop.muc.suse.de>; from freitag@alancoxonachip.com on Fri, Aug 17, 2001 at 10:03:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <freitag@alancoxonachip.com> writes:
>Just NULLing alone is quite useless anyways; just 0ed data can be
>easily recovered in a special laboratory by using old traces of
>magnetism on the surfaces.  If you care about real data deletion you
>should probably use an utility like wipe which does about 20-30
>passes with random data.

The services of such a laboratory are quite expensive, and invasive
(they need the disk).  An unerase utility is quite cheap (free) and
can be quietly run from the other side of the planet.

It seems to me there be room for something simple that raises the cost
of recovering deleted files to a price significantly above the current
sale price of "free".  Simple NULLing would do that and it could be
done cheaply by a low priority daemon that goes around sweeping up
deleted bits when nothing much else is happening.

Yes, there would still be a window when files will not have been
NULLed, and some machines are too busy to allow such a daemon to run
(are those machines also too busy to do encryption?), but it would be
much better than the case now where nearly all of us have tons of
deleted stuff just sitting there.  (Do you?)

In the physical world documents are sometimes shredded.  Yes, there is
a window between when a document is designated to be shredded and when
it can be shredded, and, yes, most shredders leave big enough pieces
to reassemble the original.  But shredders significantly lower one's
exposure and they significantly raise the cost of recovering that
data.  Just because they are not perfect doesn't mean they are "quite
useless".  The same is true of NULLing deleted files.

Also, I note that such a userland daemon is not a kernel issue.


-kb, the Kent who doesn't consider seatbelts "quite useless" just
because there are accidents for which they will not save his life.


P.S.  We still don't know what was in the 18-1/2 minute gap.  Maybe,
after all these years, we will soon find out, but most of the folks
involved are now dead.  (How many on this list were not yet born then?
Do they even know what I am talking about?  That's pretty good
security for daily use.)  Simple erasure is not perfect security, but
it is pretty damn good, and all it took was Rosemary Woods stretching
to reach that "record" button.
