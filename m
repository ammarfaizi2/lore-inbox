Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131837AbRACAQ6>; Tue, 2 Jan 2001 19:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131952AbRACAQi>; Tue, 2 Jan 2001 19:16:38 -0500
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:62625 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S131950AbRACAQa>; Tue, 2 Jan 2001 19:16:30 -0500
Message-ID: <3A5269DF.588D2C3F@flash.net>
Date: Tue, 02 Jan 2001 18:53:03 -0500
From: Rob Landley <landley@flash.net>
X-Mailer: Mozilla 4.7 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: CPRM copy protection for ATA drives
In-Reply-To: <Pine.LNX.4.10.10101021442010.26680-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andre Hedrick wrote:
> 
> On Tue, 2 Jan 2001, Rob Landley wrote:
> 
> > And we all remember how the pirates got around this, don't we?  The easy
> > way: crack the program.
> 
> Nope...it is embedded to the vender portion of the media.

My point was that using this kind of thing to protect applications is
just as pointless as any other kind of copy protection in a debuggable
and editable binary.  (And if it's not debuggable and editable, it's
kind of hard to make it runnable.  Even if you encrypt it, it has to
decrypt itself in memory to run.)

If it's protecting content (DVD css again), the actual PIRATES will do
what they did before decss: put their non-interfering interception layer
between the program and the media so that the program unlocks the media
for them and they snoop and record the data going by as part of normal
operation.  And if the data goes into the binary in encrypted form, the
binary must be able to encrypt it.  Then they convert it to whatever
other form they like (mp3, mpeg 4, etc) before throwing it on irq and
bragging about it to their other 14 year old friends.  Before decss, the
pirates hacked some software dvd player to do this, or wrote their own
video/audio driver that intercepted the data that thought it was going
to the display.

A combination of the two (interactive game like Dragon's Lair, for
example) could be cracked with a combination of the approaches.  Might
take a month or two, but there honestly are people with nothing better
to do with their time.  (A decande or so back I actually knew some of
them.)

So it's not even going to dent ACTUAL piracy.

> You were not listening, SCSI/MMC grabbed their ankles already!

Missed that part.  (Mostly read the zdnet stuff, serves me right.)  Read
read read...  Fun.

So are applications expected to bare metal talk to the hardware straight
from user space like the days of DOS, or are people going to hack device
drivers to emulate and undermine this magic extra storage space?  (Read
the read-only data, and then supply the same data for another drive? 
You don't HAVE to crack if your intention is simply to copy verbatim, or
fake a verbatim copy anyway...)  Sheesh, you could do that sort of thing
with a hacked version of plex86 or something even if they DO read the
bare metal.  And yes, somebody WILL do that eventually if this actually
ships.
 
> > Has anybody brought up the LEVELS of nested stupidity in this particular
> > proposal to the committe?  (Committee iq: average intelligence of
> > members, divide by headcount.  Nice to see that holds true.)
> 
> Yes, it is not part of the STANDARD because I successfully stopped it for
> now until February.  Oh and I sit and vote on that committee.

I've since read your message on that, yes.  (As I said, the individuals
are smarter than the committee. :)

> > users.  A GPLed program isn't likely to depend on this "feature", is
> > it?  Or the Intel CPU ID...).
> 
> It requires a licensed HOST/Application like a JAVA-thingy, or a
> real-local one.
> 
> If you want to kill it somebody create a GNU-CPRM and open-source it.
> License it for FREE.

Or, for the pirates, hack somebody else's CPRM into a pesudo-generic
tool to read the data, and/or intercept an application's "here's my key,
now give me the data" requests.

The register thing IS a bit vague on what this proposal actually DOES. 
(Okay, read-only key space initialized by manufacturer.  Got it. 
Compliant application required to read (unlock/decrypt?) the data. 
Okaaay...  Is the application providing a decryption key (er, not
writing it into the read-only space...  Ummm...  "Not usually accessed
by the end user", oh yeah like that's going to true for longer than 15
minutes once it ships...)

How does it actually WORK?  (Is there some kind of one-time write into
one of these slots?  What happens when you run out of slots?  It says it
makes use of the physical location of the info on the drive, but doesn't
say HOW...  (These slot thingies?  Sector address of the file being
read?))

I've read the register's "how it works" section, and I'm not sure I'm
much more informed than I started...

Here's from The Register article that started this thread:

> But for home users, the party's over. CRPM paves the way for
> CPRM-compliant audio CDs, and the free exchange of digital
> recordings will be limited to non-CPRM media. 

Play the thing using an "approved" player into an audio driver of my own
devising which records the data, then make a normal MP3 out of it.  How
does the system intend to stop this?  (Even if the "approved" player has
to be some kind of boom box, stick the headphone jack into the sound
card's "in" jack, reducing the "how many mathematicians" light bulb joke
to an earlier joke.)

I'm still unclear on exactly what they're trying to DO.  Either the
"protected" data cannot be used from software at ALL, or the software
designed to use the data legitimately can be compromised by a determined
14 year old in croatia with a hex editor/debugger, thus extracting the
data and allowing its conversion to a more conveniently portable
format.  (I.E. decss isn't necessary to PIRATE -anything-.  Just to
conveniently use the original format in a different context WITHOUT
converting it first using, ahem, "impolite" tools.)

Where's the middle ground here?  What did I miss?  I'm confused.

> Cheers,

LeChiem.

> Andre Hedrick

Rob
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
