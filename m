Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272549AbRJPXiu>; Tue, 16 Oct 2001 19:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272620AbRJPXil>; Tue, 16 Oct 2001 19:38:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272549AbRJPXic>; Tue, 16 Oct 2001 19:38:32 -0400
Date: Wed, 17 Oct 2001 01:38:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Patrick McFarland <unknown@panax.com>, linux-kernel@vger.kernel.org
Subject: Re: VM
Message-ID: <20011017013856.R2380@athlon.random>
In-Reply-To: <20011015211216.A1314@localhost> <9qg46l$378$1@penguin.transmeta.com> <20011015230836.B1314@localhost> <20011016122627.110964ec.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011016122627.110964ec.skraw@ithnet.com>; from skraw@ithnet.com on Tue, Oct 16, 2001 at 12:26:27PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 12:26:27PM +0200, Stephan von Krawczynski wrote:
> On Mon, 15 Oct 2001 23:08:38 -0400 Patrick McFarland <unknown@panax.com> wrote:
> 
> > reading what lang wrote, ive been thinking
> > 
> > Im on the type of machine that swapping the least is most favorable. rik's vm
> seems that it would be able to swap less, and not swap the wrong things enough
> of the time.
> 
> Well, I cannot really comment on who does what based on the code. But I can see
> the results on my machine(s). And what I see is that the current linus-tree
> does not swap at all in my environment. Maybe one could say that 1 GB of RAM is

I was also surprised that mainline was swapping more, it shouldn't
really be the case. Infact in 2.4.13pre3aa1 I'm using shrink_cache to
probe when it's time to start paging, instead of waiting shrink_cache to
fail, this to avoid being too aggressive against the cache. So with
those recent changes it should start swapping earlier and it should swap
more.  But if it's now swapping too much it will be very easy to turn it
down the swap rate as worse with a few liner that removes such
cache-probe early-swap logic.

Andrea
