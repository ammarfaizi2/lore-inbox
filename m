Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281898AbRKUO4c>; Wed, 21 Nov 2001 09:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281434AbRKUO4W>; Wed, 21 Nov 2001 09:56:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:41890 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281395AbRKUO4R>;
	Wed, 21 Nov 2001 09:56:17 -0500
Date: Wed, 21 Nov 2001 09:56:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <Pine.LNX.3.95.1011121085737.21389A-100000@chaos.analogic.com>
Message-ID: <Pine.GSO.4.21.0111210952350.25953-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Nov 2001, Richard B. Johnson wrote:

> On Wed, 21 Nov 2001, Jan Hudec wrote:
> 
> > > >     *a++ = byte_rev[*a]
> > > It looks perferctly okay to me. Anyway, whenever would you listen to a
> > > C++ book talking about good C coding :p
> > 
> 
> It's simple. If any object is modified twice without an intervening
> sequence point, the results are undefined.

That's not all.  There's another case - when modification and use of
the same object happen in undefined order.

And that's precisely what happens here - same as in case of (x + ++x)


