Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSDRQv1>; Thu, 18 Apr 2002 12:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSDRQv0>; Thu, 18 Apr 2002 12:51:26 -0400
Received: from sendmail.avnet.com ([12.9.139.96]:65272 "EHLO lager.avnet.com")
	by vger.kernel.org with ESMTP id <S291401AbSDRQv0> convert rfc822-to-8bit;
	Thu, 18 Apr 2002 12:51:26 -0400
Message-ID: <C08678384BE7D311B4D70004ACA371050B7633CA@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Lars Marowsky-Bree'" <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: RE: Versioning File Systems?
Date: Thu, 18 Apr 2002 09:51:13 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it just me or is this sounding a lot like
ClearCase?  In their filesystem (I don't know
if they implement it in user space or kernel
space, but I do remember ClearCase on Solaris
did do some kernel mods), file names are really
directories, e.g. foo.c is current; foo.c/main/3
is a (perhaps different) specified version.

& for recovering from editor screwups, one could
easily imagine "vi foo.c/-3" to recover the file
from 3 saves ago, etc.

By "deducing change sets", is the question, how
to associate various versions of *different* files?
I.e. recovering an editor screw-up of a single
file is easy, but how do you back out that RPM
you just installed, which might have affected
many files?  Here ClearCase uses "labels",
which associates *one* name with the specified
versions of many files.  So you could set your
"view" (in ClearCase terms) to /tuesday, etc.

When I used ClearCase in prior jobs, I loved
it -- it was a joy *because* it looked like
a plain old filesystem (e.g. vi foo.c) when you
wanted to think of it that way, but it also
had full-featured version control.

Is the idea being discussed to open-source
something of that nature, and make it into
a filesystem?




-----Original Message-----
From: Lars Marowsky-Bree [mailto:lmb@suse.de]
Sent: Thursday, April 18, 2002 8:28 AM
To: linux-kernel@vger.kernel.org
Subject: Re: Versioning File Systems?


On 2002-04-18T08:20:25,
   Larry McVoy <lm@bitmover.com> said:

> It's certainly a fun space, file system hacking is always fun.  There
> doesn't seem to be a good match between file system operations and
> SCM operations, especially stuff like checkin.  write != checkin.
> But you can handle that with

Either that, or heuristics - file not written to / opened for writing in x
minutes -> commit.

That would actually be pretty interesting because it might also allow you to
back out editor screwups ;-)

However, deducing change sets is more difficult.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
