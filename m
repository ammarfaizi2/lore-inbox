Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267998AbRGVPzo>; Sun, 22 Jul 2001 11:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbRGVPze>; Sun, 22 Jul 2001 11:55:34 -0400
Received: from are.twiddle.net ([64.81.246.98]:53898 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267998AbRGVPzZ>;
	Sun, 22 Jul 2001 11:55:25 -0400
Date: Sun, 22 Jul 2001 08:53:30 -0700
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010722085330.A7735@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010721234952.A4349@twiddle.net> <Pine.LNX.4.33.0107220025500.6342-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107220025500.6342-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jul 22, 2001 at 12:44:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 22, 2001 at 12:44:57AM -0700, Linus Torvalds wrote:
> But if you don't do that, you don't need a stack frame. You just reload GP
> and jump back to the caller.

Hmm.  Yes, that could work.  We'd still be changing the ABI, since
the original source "bsr foo" would really mean "bsr foo+skip ldgp".
But perhaps one that wouldn't matter for all practical purposes.

This would need to be done with a new relocation type so that old
linkers that didn't handle this sort of thing choke, but that's not
a big deal.

If I find the time I may give it a shot and see what sort of 
effect it has on typical code.


r~
