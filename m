Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129473AbQJaU4T>; Tue, 31 Oct 2000 15:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129371AbQJaU4C>; Tue, 31 Oct 2000 15:56:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30980 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129596AbQJaUzx>;
	Tue, 31 Oct 2000 15:55:53 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200010311928.e9VJS2d08641@flint.arm.linux.org.uk>
Subject: Re: test10-pre7
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 31 Oct 2000 19:28:01 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10010310930110.6866-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 31, 2000 09:31:09 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Wed, 1 Nov 2000, Keith Owens wrote:
> > LINK_FIRST is processed in the order it is specified, so a.o will be
> > linked before z.o when both are present.  See the patch.
> 
> So why don't you do the same thing for obj-y, then?
> 
> Why can't you do
> 
> 	LINK_FIRST=$(obj-y)
> 
> and be done with it?

Hmm, so why don't we just call it obj-y and be done with it? ;)

Since someone kindly enlightened me that LINK_FIRST was unsorted, I'm finding
it very hard to grasp what the difference is between an unsorted LINK_FIRST
and unsorted LINK_LAST list, and an unsorted obj-y list.  From what I
understand, obj-y = $(LINK_FIRST) $(LINK_LAST) ?

Therefore, there is little difference between:

LINK_FIRST = a.o z.o
LINK_LAST = y.o p.o

and

obj-y = a.o z.o y.o p.o

I still don't see what LINK_FIRST and LINK_LAST gains us, other than
potentially more confusion.  Instead of having one order-dependent
variable, we now have 2.  Please enlighten me further!
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
