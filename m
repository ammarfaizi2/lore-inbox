Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270102AbRHUBMy>; Mon, 20 Aug 2001 21:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270236AbRHUBMo>; Mon, 20 Aug 2001 21:12:44 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:30989 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S270102AbRHUBMc>;
	Mon, 20 Aug 2001 21:12:32 -0400
Date: Mon, 20 Aug 2001 21:11:07 -0400
From: Theodore Tso <tytso@mit.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Johan Adolfsson <johan.adolfsson@axis.com>,
        Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <20010820211107.A20957@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	Johan Adolfsson <johan.adolfsson@axis.com>,
	Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
	linux-kernel@vger.kernel.org, riel@conectiva.com.br
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com> <2248596630.998319423@[10.132.112.53]> <3B811DD6.9648BE0E@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B811DD6.9648BE0E@evision-ventures.com>; from dalecki@evision-ventures.com on Mon, Aug 20, 2001 at 04:25:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 04:25:26PM +0200, Martin Dalecki wrote:
> 
> The primary reson of invention of /dev/random was the need
> for a bit of salt to the initial packet sequence number inside
> the networking code in linux. And for this purspose the
> whole /dev/*random stuff is INDEED a gratitious overdesign.

That simply isn't true.  The original reason that I wrote the
/dev/random driver is that was for crypto key gneration.  The primary
use environment was to provide better key generation routines for user
applications such as PGP, etc., which is the first devices that I
implemented for entropy collection was the keyboard and mouse devices.

The use of the /dev/random code for other purposes (generating initial
packet sequence numbers for networking, generating a unique
boot-session identifier which was requested by the emacs folks, etc.),
all came later.

> For anything else crypto related it just doesn't cut the corner.

A number of other people helped me with the design and development of
the /dev/random driver, including one of the primary authors of the
random number generation routines in PGP 2.x and 5.0.  Most folks feel
that it does a good job.


						- Ted
