Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262345AbRENRgr>; Mon, 14 May 2001 13:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbRENRgi>; Mon, 14 May 2001 13:36:38 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:49669 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S262345AbRENRgY>; Mon, 14 May 2001 13:36:24 -0400
Date: Mon, 14 May 2001 13:16:38 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Wayne.Brown@altec.com, Hacksaw <hacksaw@hacksaw.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Not a typewriter
Message-ID: <20010514131638.B12046@munchkin.spectacle-pond.org>
In-Reply-To: <20010514112554.A10909@munchkin.spectacle-pond.org> <E14zLj4-0000zO-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14zLj4-0000zO-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, May 14, 2001 at 06:01:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 06:01:42PM +0100, Alan Cox wrote:
> > IIRC, the 6 character linker requirement came from when the Bell Labs folk
> > ported the C compiler the IBM mainframe world, not from the early UNIX (tm)
> > world.  During the original ANSI C meetings, I got the sense from the IBM rep,
> 
> 6 character linker name limits are very old. Honeywell L66 GCOS3/TSS which I
> had the dubious pleasure of experiencing and which is a direct derivative of
> GECOS and thus relevant to the era like many 36bit boxes uses 6 char link names
> 
> Why - well because 6 BCD characters fit in a 36bit word and its a single compare
> to check symbol matches

Another old system that I recall was the CDC Cyber systems, which when I
encountered them used 6-bit 'bytes' (the null byte meaning ':' in some cases,
and null in others).  The linker resolved names to 7 characters, so it could
fit the name (42 bits) + an 18 bit address into a single 60 bit word.

One of the most useful rules of the GNU coding standards is that it asks people
to avoid putting arbitrary limits in their code:

	For example, Unix utilities were generally optimized to minimize memory
	use; if you go for speed instead, your program will be very different.
	You could keep the entire input file in core and scan it there instead
	of using stdio.  Use a smarter algorithm discovered more recently than
	the Unix program.  Eliminate use of temporary files.  Do it in one pass
	instead of two (we did this in the assembler).

	Or, on the contrary, emphasize simplicity instead of speed.  For some
	applications, the speed of today's computers makes simpler algorithms
	adequate.

	Or go for generality.  For example, Unix programs often have static
	tables or fixed-size strings, which make for arbitrary limits; use
	dynamic allocation instead.  Make sure your program handles NULs and
	other funny characters in the input files.  Add a programming language
	for extensibility and write part of the program in that language.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
