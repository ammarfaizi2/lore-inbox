Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129811AbQK2Dwr>; Tue, 28 Nov 2000 22:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129944AbQK2Dwh>; Tue, 28 Nov 2000 22:52:37 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:8456 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129811AbQK2Dwb>; Tue, 28 Nov 2000 22:52:31 -0500
Date: Tue, 28 Nov 2000 21:21:50 -0600
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Russell King <rmk@arm.linux.org.uk>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001128212150.L8881@wire.cadcamlab.org>
In-Reply-To: <200011272257.eARMvw302186@flint.arm.linux.org.uk> <200011290146.eAT1khL116131@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011290146.eAT1khL116131@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Nov 28, 2000 at 08:46:43PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Albert D. Cahalan]
> Choosing an initializer that tends to catch unintended reliance on
> zeroed data would be good. Too bad it is too late to fix.

Why would that be good?  Why is it bad to accidentally rely on zeroed
data, if the data is in fact guaranteed to be zeroed?  It's not like
this is going to change out from under us in a year.  You said it
yourself: we can do whatever we want here.  And I don't see why we
would ever want to do anything other than zero it.

> Go back and read the rest of this thread. Examples have been provided
> (not by me) of such code leading to latter mistakes.

Oh please, how hard can it be to type

  static int foo; // = 0

as opposed to

  static int foo = 0;

If the two produced the same object code, the second would be better,
but they don't, so it isn't.  Patch gcc, if you care enough (and feel
you can convince the gcc steering committee to care enough).

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
