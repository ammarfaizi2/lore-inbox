Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263423AbRFEXtN>; Tue, 5 Jun 2001 19:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263426AbRFEXtD>; Tue, 5 Jun 2001 19:49:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1545 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263423AbRFEXsr>; Tue, 5 Jun 2001 19:48:47 -0400
Date: Wed, 6 Jun 2001 01:48:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd and MM overload fix
Message-ID: <20010606014839.A24257@athlon.random>
In-Reply-To: <20010606004450.C27651@athlon.random> <Pine.LNX.4.31.0106051612500.9908-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0106051612500.9908-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jun 05, 2001 at 04:16:57PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 04:16:57PM -0700, Linus Torvalds wrote:
> but I think we should also make the init code clear the zone data for
> empty zones so that these kinds of "use uninitialized stuff" things cannot
> happen. No?

that would fix it too indeed, OTOH I think changing the empty zone
handling in the kernel is beyond the scope of the bugfix (grep for
zone->size in mm/*.c :). Certainly making empty zones transparent to the
vm sounds much cleaner from a mm/*.c point of view but it may be faster
to skip the block with a branch instead of always computing it.

Andrea
