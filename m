Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSGZNk3>; Fri, 26 Jul 2002 09:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317748AbSGZNk3>; Fri, 26 Jul 2002 09:40:29 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60939 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317742AbSGZNk2>; Fri, 26 Jul 2002 09:40:28 -0400
Date: Fri, 26 Jul 2002 09:38:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code
In-Reply-To: <E17Xw0V-0004f8-00@starship>
Message-ID: <Pine.LNX.3.96.1020726091213.16487A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, Daniel Phillips wrote:

> On Thursday 25 July 2002 14:51, Bill Davidsen wrote:
> > On Fri, 19 Jul 2002, Alan Cox wrote:
> > 
> > > > +static const char * morse[] = {
> > > > +	".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */
[...snip...]
> > > 
> > > How about using bitmasks here. Say top five bits being the length, lower
> > > 5 bits being 1 for dash 0 for dit ?
> > 
> > ??? If the length is 1..5 I suspect you could use the top two bits and fit
> > the whole thing in a byte. But since bytes work well, use the top three
> > bits for length without the one bit offset. Still a big win over strings,
> > although a LOT harder to get right by eye.
> 
> Please read back through the thread and see how 255 different 7 bit codes
> complete with lengths can be packed into 8 bits.

???
 1 - there are not 255 different 7 bit values, there are 128
 2 - morse code has a longest value of 5 elements not 7
 3 - Alan was talking about len+val representation, not stop-bit patterns,
     which is what I guess you mean

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

