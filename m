Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQKHL0b>; Wed, 8 Nov 2000 06:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129975AbQKHL0V>; Wed, 8 Nov 2000 06:26:21 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:51206 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S129348AbQKHL0E>; Wed, 8 Nov 2000 06:26:04 -0500
Date: Wed, 8 Nov 2000 14:25:13 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: axp-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001108142513.A5244@jurassic.park.msu.ru>
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001108013931.A26972@twiddle.net>; from rth@twiddle.net on Wed, Nov 08, 2000 at 01:39:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 01:39:31AM -0800, Richard Henderson wrote:
>   * Replace cropped found_vga detection code.

I wonder where could I lose this, it was in place initially :-)

> +	/* ??? How to turn off a bus from responding to, say, I/O at
> +	   all if there are no I/O ports behind the bus?  Turning off
> +	   PCI_COMMAND_IO doesn't seem to do the job.  So we must
> +	   allow for at least one unit.  */

I relied on DEC^WIntel 21153 datasheet which says that to turn off
io/mem window this bridge must be programmed with base > limit
values (and the code actually did that).
But this could be wrong for other bridges.
OTOH, we turn off prefetchable memory range this way in 2.2, and
it works...

Thanks for the patch,

Ivan.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
