Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130093AbQJaXAw>; Tue, 31 Oct 2000 18:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130284AbQJaXAm>; Tue, 31 Oct 2000 18:00:42 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:59409 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S130093AbQJaXA0>; Tue, 31 Oct 2000 18:00:26 -0500
Date: Tue, 31 Oct 2000 17:59:24 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: mingo@elte.hu, Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031175924.A24279@alcove.wittsend.com>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@timpanogas.org>, mingo@elte.hu,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0010312231490.15159-100000@elte.hu> <39FF3F0B.81A1EE13@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <39FF3F0B.81A1EE13@timpanogas.org>; from jmerkey@timpanogas.org on Tue, Oct 31, 2000 at 02:52:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 02:52:11PM -0700, Jeff V. Merkey wrote:

> Ingo Molnar wrote:
> > 
> > On Tue, 31 Oct 2000, Pavel Machek wrote:
> > 
> > > > Excuse me, 857,000,000 instructions executed and 460,000,000
> > > > context switches a second -- on a PII system at 350 Mhz. [...]
> > 
> > > That's more than one context switch per clock. I do not think so.
> > > Really go and check those numbers.
> > 
> > yep, you cannot have 460 million context switches on that system,
> > unless you have some Clintonesque definition for 'context switch' ;-)

> The numbers don't lie.  You know where the code is.  You notice that
> there is a version of
> the kernel hand coded in assembly language.  You'l also noticed that
> it's SMP and takes ZERO LOCKS during context switching, in fact, most of
> the design is completely lockless.

	Ah ha ha ha!!!!  Sure they do!  You're just quoting statistics
measured under whatever conditions you imposed.

	Numbers lying?  I think the famous line has been variously
attributed to either Mark Twain or Disraeli (don't know which really
coined the phrase) but it's been said that there are three kinds of
lies "Lies, Damn Lies, and Statistics".  Yes numbers do lie.  Sometimes
it's the GIGO law and sometimes its just the fact that if you abuse
statistics long enough they will tell you ANYTHING.  Sometimes it merely
the person manipulating^H^H^H^H^H^H^H^H^H^H^H^Hproviding the numbers.

	BTW...  I was going to stay OUT of this rat trap, but since I'm
in for a dime, I might as well be in for a dolar...

	<Minor Rant>

	Comparisons have been made between the performance of Linux with
early (3.x, 4.x) versions of Novell.  ANYONE who wants to compare Linux
with that bug ridden, unreliable swamp of headaches and security holes
(somewhere in my archives I have the virus launcher that BYPASSES the
3.x login program) should be beaten about the head with a good textbook
on reliable coding techniques.  Novell made its hayday by beating the
bejesus out of TCP/IP and others primarily by disabling checksumming,
memory protection, and other reliability techniques.  Yes, they got
better performance on low performace processors, but at what cost?  Now
we cover their performance with reliability and superior hardware.  I
remember one misguided soul wanting to run IPX over SLIP pleading for help
on the Novell mailing list years ago.  Let's see...  SLIP eliminates the
MAC layer checksumming and IPX eliminates the error checking on the next
layer up...  Yup...  There was a receipe for random acts of terrorism.
Now we have PPP (this was in the days BEFORE PPP) and you could do it.
IPX depended on the lower layers for data integrity and and SLIP depended
on the layer above it.  Ooooppppssss....

	Then we had the Novel 5.x NFS server that allow you to create
scripts that were SUID to root just by making them read only to the
Novell workstations (ok - that's not performace related - I just think
that security should be given a LITTLE thought).  I worked at an outfit
(Syntrex) that saw themselves as becoming the "K-Mart of Novell" and I
was told that Novell was the be all and end all of networking and there
was really no future in this antiquated TCP/IP stuff.  I was laid off and
given all sorts of nice neat little toys like an AT&T source license
because they saw no future in Unix or TCP/IP.  (Bitter - no...  I have
had my revenge in spades...  They had no clue what they gave away and
let slip through their fingers!  :-) )

	Now, Novell has been dragged kicking and screaming into the TCP/IP
world, and Novell has been forced to add memory protection (at a performace
cost) to their servers, and the outfit that thought TCP/IP was history
is now history (Syntrex went Chapter 13 about 10 years ago), and I've had
the pleasure of slamming one particularly simple minded Novell rep (another
ex Syntrex inDUHvidual) with more than one security hole (the perl module
on the Novell web server was an absolute classic).

	My point here is that packets per second don't mean jack shit if
you can't do it reliably and you can't do it securely.  Novell failed on
both of those counts and those are a contributing factor in their current
troubles.  They built their reputation on performance that was achieved at
the expense of reliability and security.  Now they have to play with the
big boys and all the nasty kiddies out there who don't play nice.

	Performance is important.  Performance is desirable.  Efforts to
improve performance are worthwhile.  But performance should NEVER come at
the cost of security or reliability or integrity.  Comparisions with high
performance systems which lacked security, reliability, and data integrity
are suspect AT BEST.  We should NEVER give up the quest for better
performance but comparisons to an inferior operating system which can pump
out packets faster than us is not the threat some people would like it to be.

	</Minor Rant>

	My regards and respects to Jeff.  He says he was responsible for the
Novell 4.x and 5.x systems.  I note that he omitted the 3.x OS.  Acknowledged
and respected!  In my earlier days, I was the kernel jock responsible for a
proprietary version of XENIX and worked on Microport UNIX (may someone
forever drive a stake through that bastard's heart) and SCO Unix.  I'm
"contaminated goods" for certain projects so I can't contribute to certain
applications like Taylor UUCP because I have legal source code to HDB UUCP
(as if UUCP means jack in today world).  Does the current taylor UUCP have
the most possible efficient checksumming algorithm for the UUCP 'g' protocol?
No...  No way...  I've seen one that stomps Taylor UUCP's ass and takes names
from the AT&T SVR5 release 3.2 source tapes (took me a week to figure out just
how it worked - damn those comment strippers).  Does it matter?  Not one bit.

	I want to see Linux excel.  Does that mean that it has to beat
every benchmark set by an operating system that cut every corner that
would cause Linus to turn into a Quake Balrog?  I think not.

> Jeff

> >         Ingo

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
