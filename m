Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRFYTUH>; Mon, 25 Jun 2001 15:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFYTT7>; Mon, 25 Jun 2001 15:19:59 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.23]:39638 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S264375AbRFYTTu>; Mon, 25 Jun 2001 15:19:50 -0400
Date: Mon, 25 Jun 2001 15:19:48 -0400
From: Alan Shutko <ats@acm.org>
Subject: Re: sizeof problem in kernel modules
In-Reply-To: <Pine.LNX.3.95.1010625094914.7314A-100000@chaos.analogic.com>
To: root@chaos.analogic.com
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Message-id: <87ithk5px4.fsf@wesley.springies.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.103
In-Reply-To: <Pine.LNX.3.95.1010625094914.7314A-100000@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> > ISO/IEC 9899:1990 6.5.2.1:
> > 
> >   As discussed in 6.1.2.5, a structure is a type consisting of a
> >   sequence of named members, whose storage is allocated in an ordered
> >   sequence, and a union [stuff we don't care about].
> >
> 
> Does "ordered sequence" mean "incremental"? I think not.

It does mean there is an order, as defined below.

>  
> >   Within a structure object, the non-bit-field members and the units
> >   in which bit-fields reside have addresses that increase in the order
> >   in which they declared.
> 
> 
> Really?? Did you TYPE this in or did you copy it from somewhere??

I typed it in and forgot an "are".  Forgive me, but this doesn't
change the point, and you could have easily looked in the standard
yourself to see where I mistyped.

> And... If this was a part of a C specification

Which it is.

> it would prevent the inclusion of const data within a structure
> unless the entire structure was of type const.

No.  The C standard does not guarantee that const items be placed in
RO memory.  It does not even require that the host have RO memory, or
that an implementation do the same thing with a const object as a
const member of a structure.

> >   There may therefore be unnammed padding withing a structure object,

> Unnamed and within are spelled incorrectly. This is not a valid
> document.

Geez, would you rather I scan it for you?  

> This way, the compiler "knows" where things are and handles duplication
> accordingly.

Of course it knows where things are, since a structure is a single
contiguous range of memory, according to the standard.

Would you care to offer counter citations?  Have you even looked at
the standard?

-- 
Alan Shutko <ats@acm.org> - In a variety of flavors!
Please keep your hands off the secretary's reproducing equipment.
