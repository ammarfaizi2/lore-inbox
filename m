Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132676AbQL1XfI>; Thu, 28 Dec 2000 18:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132689AbQL1Xe6>; Thu, 28 Dec 2000 18:34:58 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:46831 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132676AbQL1Xen>; Thu, 28 Dec 2000 18:34:43 -0500
Date: Thu, 28 Dec 2000 21:03:56 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andi Kleen <ak@suse.de>
cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
In-Reply-To: <20001228235836.A25388@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0012282102130.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Andi Kleen wrote:
> On Thu, Dec 28, 2000 at 02:33:07PM -0800, David S. Miller wrote:
> >    Date: 	Thu, 28 Dec 2000 23:17:22 +0100
> >    From: Andi Kleen <ak@suse.de>
> > 
> >    Would you consider patches for any of these points? 
> > 
> > To me it seems just as important to make sure struct page is
> > a power of 2 in size, with the waitq debugging turned off this
> > is true for both 32-bit and 64-bit hosts last time I checked.
> 
> Why exactly a power of two ? To get rid of ->index ? 

Most likely to minimise the number of cache misses needed
to access a complete page_struct.

Then again, I guess 48 bytes would _also_ guarantee that
we never need more than 2 cache misses to access every
part of the page_struct.

And the memory wasted in the page_struct may well be a
bigger factor than the cache misses on lots of systems...

(time for another CONFIG option? ;))

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
