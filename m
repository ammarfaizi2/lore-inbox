Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130866AbQLaUUt>; Sun, 31 Dec 2000 15:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130895AbQLaUU3>; Sun, 31 Dec 2000 15:20:29 -0500
Received: from Cantor.suse.de ([194.112.123.193]:6155 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130866AbQLaUUV>;
	Sun, 31 Dec 2000 15:20:21 -0500
Date: Sun, 31 Dec 2000 20:49:53 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
Message-ID: <20001231204953.A25617@gruyere.muc.suse.de>
In-Reply-To: <20001231182127.A24348@gruyere.muc.suse.de> <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com> <20001231200741.F28963@mea-ext.zmailer.org> <92o0l7$h5v$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <92o0l7$h5v$1@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 31, 2000 at 11:15:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 11:15:51AM -0800, Linus Torvalds wrote:
> In article <20001231200741.F28963@mea-ext.zmailer.org>,
> Matti Aarnio  <matti.aarnio@zmailer.org> wrote:
> >
> >	Actually nothing SMP specific in that problem sphere.
> >	Alpha has  load-locked/store-conditional  pair for
> >	this type of memory accesses to automatically detect,
> >	and (conditionally) restart the operation - to form
> >	classical  ``locked-read-modify-write'' operations.
> 
> Sure, we could make the older alphas use ldl_l stl_c for byte accesses,
> but if you thought byte accesses on those machines were kind-of slow
> before, just WAIT until that happens.

The older Alphas would just typedef x8/x16 (or granular_u8, granular_u16
or whatever it is called) to u32 and be the same as today. Just most
other boxes would benefit.

This actually all assumes that gcc really uses the byte instructions
for byte stores in structures, which is to be determined.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
