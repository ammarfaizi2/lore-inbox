Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289000AbSAZDMb>; Fri, 25 Jan 2002 22:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289003AbSAZDMU>; Fri, 25 Jan 2002 22:12:20 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:26242 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289000AbSAZDMK>; Fri, 25 Jan 2002 22:12:10 -0500
Date: Sat, 26 Jan 2002 03:08:41 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020126030841.C5730@kushida.apsleyroad.org>
In-Reply-To: <3C513CD8.B75B5C42@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C513CD8.B75B5C42@aitel.hist.no>; from helgehaf@aitel.hist.no on Fri, Jan 25, 2002 at 12:09:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Why would anyone want to write   if (X==false) or if (X==true) ?
> It is the "beginner's mistake" way of writing code.  Then people learn,
> and write if (X) or if (!X).  Comparing to true/false is silly.
> Nobody writes  if ( (a==b) == true) so why do it in the simpler cases?

I usually without the == in these cases:

  if (pointer)  // test for non-0.
  if (condition)
  if (condition-valued-variable)

but not in these (although I am not very consistent):

  if (integer != 0)
  if (char != 0)

When using bool, I'm happy to write "if (X)" where X is a truth value
indicating a condition that has been tested, but if X were used as an
enumeration of truth values e.g. as in a theorem prover or a logic
simulator, I would tend to write ==, for example:

  if (X == true && ptr && *ptr > 1)

The point being to illustrate the intent of the test (i.e. is it a
boolean test or a comparison against a point in a range of values), not
simply for it to be semantically correct.

Just to break that rule, however, if p were a pointer and x were an
integer, I would write:

  x = (p != 0);

rather than

  x = p;

:-)

enjoy,
-- Jamie
