Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264476AbRFYEuU>; Mon, 25 Jun 2001 00:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265881AbRFYEuK>; Mon, 25 Jun 2001 00:50:10 -0400
Received: from adsl-65-68-16-200.dsl.ltrkar.swbell.net ([65.68.16.200]:21028
	"EHLO etmain.edafio.com") by vger.kernel.org with ESMTP
	id <S264476AbRFYEuA> convert rfc822-to-8bit; Mon, 25 Jun 2001 00:50:00 -0400
Subject: RE: Crash on boot (2.4.5)
Date: Sun, 24 Jun 2001 23:45:10 -0500
Message-ID: <3BDF3E4668AD0D49A7B0E3003B294282BC93@etmain.edafio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Thread-Topic: Crash on boot (2.4.5)
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
content-class: urn:content-classes:message
Thread-Index: AcD87Wj3/yT+WDukSn6abZe3UR+/6wARBzDQ
From: "Andy Ward" <andyw@edafio.com>
To: "Steven Walter" <srwalter@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmmm...  haven't tried changing to non-AMD for the chip type...  I'll
try pentium later tonight and see if it works better.  Thanks for the
insight....

-- andyw

-----Original Message-----
From: Steven Walter [mailto:srwalter@yahoo.com]
Sent: Sunday, June 24, 2001 3:42 PM
To: Andy Ward
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash on boot (2.4.5)


On Sun, Jun 24, 2001 at 01:51:09PM -0500, Daniel Fraley wrote:
> Hi, everyone..  I'm borrowing my roommate's email, so please send
replies to
> andyw@edafio.com.  Thanks!
> 
> Here's my problem...  when I boot anything 2.4, I get several oopsen
in a
> row, all of which are either (most commonly) kernel paging request
could not
> be handled, or (much less common) unable to handle kernel Null pointer
> dereference.  I will send any info on request, but here's my hardware
and
> kernel config:
> 
> iWill KKR-266R (Via 8363 Northbridge, 686B south)
> AMD tbird 1GHz
> 256MB cas2 pc133 sdram
> ATI Radeon DDR 64MB VIVO
> Kingston KNE120TX (Realtek 8139 chip)
> SBLive! 5.1
> IBM GXP75 30GB (on the via ide controller)
> Pioneer 16x dvd
> ls120
> 
> This happens regardless if I turn on swap or not.  When swap is on, it
is a
> 128MB partition (and yes, I'm aware of the recommendation of 2x RAM,
but I
> believe I read somewhere that someone was working on that, and I
didn't want
> to waste the extra 384MB on swap).
> 
> Is there anything I can do to fix this?
> 
> -- andyw
> 
> p.s., booting with devfs=nomount is better, but still causes oopsen (I
get
> to a login prompt, but if I do much more than mount a disk a copy to
it, the
> system freaks)

>From the look of things, you're being bitten by the VIA southbridge
problem.  As I've gathered, its some sort of interaction with that chip
and the 3DNow! fast copy routines the kernel uses.

If you compile the kernel for a 686, does the problem go away?  What
about 586 or lower?  If so, I believe there are some people working on
finding common aspects of the hardware that experience this problem,
though I don't remember who.  You should get in contact with them, or
they might get into contact with you.

Good luck on working this out.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
