Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161112AbWF0Ple@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbWF0Ple (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbWF0Pld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:41:33 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:24529 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1161112AbWF0Plb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:41:31 -0400
Date: Tue, 27 Jun 2006 17:41:30 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Brad Campbell <brad@wasp.net.au>
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm
Message-ID: <20060627154130.GA31351@rhlx01.fht-esslingen.de>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A14D3D.8060003@wasp.net.au>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 27, 2006 at 07:22:37PM +0400, Brad Campbell wrote:
> Pavel Machek wrote:
> >>Some of the advantages of suspend2 over swsusp and uswsusp are:
> >>
> >>- Speed (Asynchronous I/O and readahead for synchronous I/O)
> >
> >uswsusp should be able to match suspend2's speed. It can do async I/O,
> >etc...
> 
> ARGH!
> 
> And the next version of windows will have all the wonderful features that 
> MacOSX has now so best not upgrade to Mac as you can just wait for the 
> next version of windows.
> 
> suspend2 has it *now*. It works, it's stable.

I have to admit that this posting has touched a nerve.

> Brad (suspend user since 2.2.17 - and suspend2 is a heck of a lot more 
> reliable/usable than the in-kernel version ever has been for me)

I've also been a suspend user in the very early 2.2.x days (where it actually
worked pretty well for its early development stage).

However since it's always been a hassle to apply extra patches which then
never worked fully sufficiently without a lot of fiddling (which is not
really completely the fault of the swsusp code due to very incomplete
driver support, though) I've almost completely given up on it and don't
even run it any more on any of my machines currently.

> uswsusp is a great idea, really.. I love it.. but suspend2 is here, it 
> works, it's stable and it's now. Why continue to deprive the mainstream of 
> these features because "uswsusp should".. as yet it doesn't.. and when it 
> does then we can phase out the currently stable, working alternative that 
> has all these features that uswsusp _will_ have, after it's had them for a 
> year or so and its been proven stable. Not only that, I'll be happy to 
> migrate over to it. Until then however, you can pry suspend2.. cold, 
> dead.. blah blah..

Given the above explanation, it's obvious that I'm an outside watcher now,
but if swsusp2 success rate is clearly higher than the standard version,
then I'd also strongly advocate this direction since, quite frankly,
I'm sick and tired of waiting for suspend-to-disk software functionality.
It's been 6(*SIX*!) years already since a development version worked
quite well for me with >> 30 cycles until a crash, and I'm afraid that
since then on several PCs in the many years in between it was almost always
a miss rather than a hit.

Suspend/resume is an incredibly problematic area (any single mis-behaving
driver can kill it), we've been missing it for far too long already,
and if the swsusp2 codebase currently works much better than alternatives
(in this area we need as much reliability and thus success rate as possible)
then IMHO it's more than high time to get something of that in-kernel.

We can get things into perfection later IMHO, given that development
has taken that extremely long already.

Finally, I'm sure you're all doing wonderful work, but let's try to find
a solution that finally works for most people (I'm sure many people would
be extremely interested to have this working by default with >= 80%
reliability on an average desktop box).

Andreas Mohr
