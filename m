Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285022AbSADXLX>; Fri, 4 Jan 2002 18:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbSADXLO>; Fri, 4 Jan 2002 18:11:14 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:8177 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S285022AbSADXLD>; Fri, 4 Jan 2002 18:11:03 -0500
Date: Fri, 4 Jan 2002 23:51:58 +0100
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
Message-ID: <20020104235157.A1927@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.33.0201041751360.5790-100000@opal.biophys.uni-duesseldorf.de> <Pine.GSO.4.21.0201041818580.12102-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0201041818580.12102-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Fri, Jan 04, 2002 at 06:20:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 06:20:11PM +0100, Geert Uytterhoeven wrote:
> On Fri, 4 Jan 2002, Michael Schmitz wrote:
> > > > For 2.5 would it perhaps be cleaner if we had a bswapping loop device. Sort
> > > > of very bad crypto mode ?
> > >
> > > Don't mention crypto, or Atari will come after us with the DMCA sword, claiming
> > > they deliberately implemented access control? ;-)
> > 
> > Caution - I recall that on some m68k boxes we had to further byteswap
> > specific parts of the identify data or they wouldn't make sense. The IDE
> > driver will still have to be aware of these exceptions. I can't recall the
> > particulars anymore - Geert?
> 
> That's the drive identification. It indeed shouldn't be swapped once again when
> accessing a `non-native' IDE disk.

sometimes it should, eg some of the ioctls that read data via special
commands from the drive that could also use byteswapping - ide-smart 
comes to my mind.

Btw the Q40 has also byteswapped IDE bus like the atari.

We already have atapi_{input|output}_bytes bytes that does the
swapping, and m68k has {ins|outs}[wl]_swapw. Perhaps one of this 
could be reused to do the bswap?

Bye
Richard
