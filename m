Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279738AbRJ3Bsk>; Mon, 29 Oct 2001 20:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279739AbRJ3Bsb>; Mon, 29 Oct 2001 20:48:31 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:54609 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279738AbRJ3BsZ>; Mon, 29 Oct 2001 20:48:25 -0500
Date: Mon, 29 Oct 2001 20:49:01 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: riel@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029204901.A17506@redhat.com>
In-Reply-To: <20011029.155056.23033599.davem@redhat.com> <Pine.LNX.4.33L.0110292329560.2963-100000@imladris.surriel.com> <20011029.173400.35036258.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011029.173400.35036258.davem@redhat.com>; from davem@redhat.com on Mon, Oct 29, 2001 at 05:34:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 05:34:00PM -0800, David S. Miller wrote:
> I'm asking him to show the case that "breaks for something
> else".

Why don't you try lifting your fingers to defend your position?  We know 
that:

	1. the change introduces state data to tlb with no limits on the 
	   duration of said stale data
	2. some architectures have large tlbs.

For the sake of (2), hashed tlbs count as excessively large tlbs.  See the 
UML, ia64 and powerpcs for this kind of setup.

Now, if you want to live in microbenchmark land, then, yes, the "optimized" 
but invalid behaviour will *always* win.  Back in the real world, sure, I can 
construct a microbenchmark that will sit on 2 pages of memory spinning until 
the pages get swapped out.  What does that buy us?  Nothing other than 
placating you.

I've already pointed out that the optimization can be done in a valid way.  If 
you can't go through the effort of completing the above thought experiment on 
your own, then I really have no reason to care about your opinion any further.  
You've already stated you don't care about mine, and I've stated that I don't 
feel like going to the effort to placate you.  Where does that leave us?  
Nowhere, I guess.

		-ben
