Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbTAFIaL>; Mon, 6 Jan 2003 03:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbTAFIaK>; Mon, 6 Jan 2003 03:30:10 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55306
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266310AbTAFIaH>; Mon, 6 Jan 2003 03:30:07 -0500
Date: Mon, 6 Jan 2003 00:37:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
cc: Stephen Satchell <list@fluent2.pyramid.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Honest does not pay here ...
In-Reply-To: <1041838816.1045.4.camel@aurora.localdomain>
Message-ID: <Pine.LNX.4.10.10301060001040.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2003, Trever L. Adams wrote:

> I guess a question then might be this:  Andrea, I understand your stance
> of needing to make a decent living and fund development.  I think Satch
> has a point about the company going away (or the Bus problem... as in
> something happens to you).  Is there any way you can feasibly (legal and

Oh, like when I totalled my Porsche 928 and should have died hitting nose
first into a retaining wall @ 5Krpm in 3rd after somebody ran me off the
interstate ?

> monetary concerns included) do a kind of code escrow so if such happens,
> your code becomes GPL/BSD?  

This is all dependent on the issue below.

> BTW, I may be somewhat out of understanding here.  From what I have been
> reading it seems the following is true:
> 
> 1) Andre is making drivers for hardware or protocols
> 2) He is making them closed until he recoups his costs (I saw 18 mos
> somewhere as the time needed...)
> 3) He then will open them up
> 
> If I am wrong, sorry, but this should say where I am seeing all this
> from.
> 
> Also, I see the following...
> 
> 1) The problem lies with him including kernel headers (I didn't think
> magic numbers and such were really coverable by copyright... so unless
> we are talking macros... where is the problem).

If this is a problem, there will be no project to open source.

> 2) Interfaces are reverse engineer-able under US law for
> interoperability purposes (DMCA may have muddied this)
> 3) The Interface calls (sys-calls etc.) are LGPL...

(target)
It calls net, mm, slab, timer, spinlock, semaphore, scsi (structs and
about 5 or 6 functions), misc/char device, module the basics.
ZERO .c files period for the target protocol transport.  ata+sata can
substitute for scsi if selected.

(initiator)
All of the above, and the critical point is "scsi_module.c", but I can
write my own version of the functions below.

This is why I initially put forward this half of the protocol as an issue.
Now since it is only combining and not changing or derived from that file,
GPL has no say or position of adding that copyright to mine.
Regardless, this is a concern as to be totally above board.

Now there are several vendors who attach this file by one means or
another, so this is very gray.

Additionally there is no license in the file, only Copyright.

This is a concern but the logic is simple,

Actually I just realized I have copyright ownership of similar logic in
another file.  WOOHOO !

Therefore, I now no longer have an issue with "scsi_module.c", so I am
totally .c free regardless.  I had taken the precaution to place the the
include line in one of my .h files to insure that object was created first
and my .o's for the protocol are summed first then the two are LD'd at the
very end.  Now I do not have this difficult makefile and order of
operations to worry about now!

Thanks :-)

> So where is the real problem here?

Paranoia of accidently doing something wrong.
Concerned to the Nth degree that I follow the rules of binary module usage
toed exactly to the line, not short not over but exact.  Zero margin for
error is allowed.  Since I know better, I have to be that more careful.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

If there are no problems and I do not have to switch platforms, I have my
sights set on the next generation of storage about three years out.  iSCSI
is expected to fully mature in 2006/2008, its value is reduced.  My
chances of recovering my costs are slipping right now, as customers are
waiting now.

