Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267837AbRGUWNH>; Sat, 21 Jul 2001 18:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267838AbRGUWM5>; Sat, 21 Jul 2001 18:12:57 -0400
Received: from [64.81.246.98] ([64.81.246.98]:29834 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267837AbRGUWMx>;
	Sat, 21 Jul 2001 18:12:53 -0400
Date: Sat, 21 Jul 2001 15:10:55 -0700
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010721151055.A3676@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200107040337.XAA00376@smarty.smart.net> <20010703233605.A1244@zalem.puupuu.org> <20010704002436.C1294@ftsoj.fsmlabs.com> <9hvjd4$1ok$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9hvjd4$1ok$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jul 04, 2001 at 05:22:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 04, 2001 at 05:22:44PM +0000, Linus Torvalds wrote:
> [ And yes, I know there are optimizing linkers for the alpha around that
>   improve this and notice when they don't need to change GP and can do a
>   straight branch etc.  I don't think GNU ld _still_ does that, but who
>   knows.

GNU ld does it with the "-relax" flag.

>   Even the "good" Digital compilers tended to nop out unnecessary
>   instructions rather than remove them, causing more icache pressure on
>   a CPU that was already famous for needing tons of icache ]

But you're absolutely right about the nopping -- removing the nops would
require debug info and EH info to be re-coded.  The later being a matter
of correctness.  This is a bit nastier than I ever cared to deal with.


r~
