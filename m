Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLaSib>; Sun, 31 Dec 2000 13:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLaSiV>; Sun, 31 Dec 2000 13:38:21 -0500
Received: from mail.zmailer.org ([194.252.70.162]:9479 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130308AbQLaSiR>;
	Sun, 31 Dec 2000 13:38:17 -0500
Date: Sun, 31 Dec 2000 20:07:41 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001231200741.F28963@mea-ext.zmailer.org>
In-Reply-To: <20001231182127.A24348@gruyere.muc.suse.de> <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 31, 2000 at 09:27:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 09:27:23AM -0800, Linus Torvalds wrote:
> On Sun, 31 Dec 2000, Andi Kleen wrote:
> > 
> > Sounds good. It could also be controlled by a CONFIG_SPACE_EFFICIENT for
> > embedded systems, where you could trade a bit of CPU for less memory overhead 
> > even on systems where u8 is slow and atomicity doesn't come into play
> > because it's UP anyways. 
> 
> UP has nothing to do with it.
> The alpha systems I remember this problem on were all SMP.

	Actually nothing SMP specific in that problem sphere.
	Alpha has  load-locked/store-conditional  pair for
	this type of memory accesses to automatically detect,
	and (conditionally) restart the operation - to form
	classical  ``locked-read-modify-write'' operations.

	In what situations the compiler will use those instructions,
	that I don't know.   Volatiles, very least, use them.
	Will closely packed bytes be processed with it without
	them being volatiles ?  How about bitfields ?

	Newer Alphas have byte/short load/store instructions,
	so things really aren't that straight-forward...

....
> I don't think it's a good diea.
> 
> 		Linus

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
