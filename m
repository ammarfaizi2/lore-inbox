Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKHPXq>; Wed, 8 Nov 2000 10:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbQKHPXh>; Wed, 8 Nov 2000 10:23:37 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:15113 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129076AbQKHPXU>;
	Wed, 8 Nov 2000 10:23:20 -0500
Date: Wed, 8 Nov 2000 16:23:13 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Robert Morris <rtm@amsterdam.lcs.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gigabit ethernet small-packet performance
Message-ID: <20001108162313.C2430@pcep-jamie.cern.ch>
In-Reply-To: <200011051507.eA5F7KX30823@amsterdam.lcs.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011051507.eA5F7KX30823@amsterdam.lcs.mit.edu>; from rtm@amsterdam.lcs.mit.edu on Sun, Nov 05, 2000 at 10:07:20AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Morris wrote:
> The short version is that the Intel Pro/1000 seems to be a lot faster
> than the Alteon Tigon-II or the SysKonnect card for small (60-byte)
> packets. The Intel card can send or receive at least 500,000 60-byte
> packets per second (about 1/3 of a gigabit/second). On the other hand,
> the Intel Linux driver requires a lot of hacking to achieve that rate;
> with the unmodified driver the board is about half that fast.

Fwiw, the Alteon Tigon-II can send & receive 60-byte packets at line
rate if you assemble them on the card, but I've not tried pushing that
over the PCI bus.  As Jes said, that's the slow part.  Special firmware
to use fewer DMAs than packets (i.e. grouping small packets) might do
the trick.  The firmware kit is open source; enjoy :-)

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
