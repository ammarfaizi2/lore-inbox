Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbRGYXtP>; Wed, 25 Jul 2001 19:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbRGYXtE>; Wed, 25 Jul 2001 19:49:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3081 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267440AbRGYXsr>; Wed, 25 Jul 2001 19:48:47 -0400
Subject: Re: user-mode port 0.44-2.4.7
To: cfriesen@nortelnetworks.com (Chris Friesen)
Date: Thu, 26 Jul 2001 00:49:26 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <no.id> from "Chris Friesen" at Jul 25, 2001 07:37:20 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PYP8-0002uX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > This is not a gcc issue. Even if gcc _were_ to generate bad code, the
> > global volatile _still_ wouldn't be the correct answer.
> 
> I think his worry is the pedantic reason that without the volatile gcc is
> allowed to write code that chokes and dies if xtime happens to change in a
> volatile manner.  The example given earlier was:

Make the volatility explicit where it is needed, either to express a barrier
with barrier() or an assignment as in

	foo = (volatile)xtime

This makes it clear where the barriers are and avoids unpleasant
optimisation hits elsewhere.

Alan
