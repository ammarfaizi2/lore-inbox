Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264520AbRFYNij>; Mon, 25 Jun 2001 09:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264525AbRFYNi3>; Mon, 25 Jun 2001 09:38:29 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:28131 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S264520AbRFYNiR>; Mon, 25 Jun 2001 09:38:17 -0400
Date: Mon, 25 Jun 2001 09:38:16 -0400
From: Alan Shutko <ats@acm.org>
Subject: Re: sizeof problem in kernel modules
In-Reply-To: <Pine.LNX.3.95.1010625072259.5434A-100000@chaos.analogic.com>
To: root@chaos.analogic.com
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Message-id: <87ofrcbryf.fsf@wesley.springies.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.103
In-Reply-To: <Pine.LNX.3.95.1010625072259.5434A-100000@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> This means that it must be some place else than where it's denoted
> in a visual representation of the structure.

No, that's not true.

ISO/IEC 9899:1990 6.5.2.1:

  As discussed in 6.1.2.5, a structure is a type consisting of a
  sequence of named members, whose storage is allocated in an ordered
  sequence, and a union [stuff we don't care about].

  Within a structure object, the non-bit-field members and the units
  in which bit-fields reside have addresses that increase in the order
  in which they declared.    A pointer to a structure object, suitably
  converted, points to its initial member (or if that member is a
  bit-field, then to the unit in which it resides, and vice versa.
  There may therefore be unnammed padding withing a structure object,
  but not at its beginning, as necessary to achieve the appropriate
  alignment.

  There may also be unnamed padding at the end of a structure or
  union, as necessary to achieve the appropriate alignment were the
  structure or union to be an element of an array.

You can look at other things too... you can memcpy structures, pass
them into functions, call sizeof, put them in arrays... it _is_ a
physical representation.

-- 
Alan Shutko <ats@acm.org> - In a variety of flavors!
Conscience is what hurts when everything else feels so good.
