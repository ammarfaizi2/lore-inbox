Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSFOBif>; Fri, 14 Jun 2002 21:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSFOBie>; Fri, 14 Jun 2002 21:38:34 -0400
Received: from waste.org ([209.173.204.2]:49285 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S314811AbSFOBid>;
	Fri, 14 Jun 2002 21:38:33 -0400
Date: Fri, 14 Jun 2002 20:38:21 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO
  simplification
In-Reply-To: <3D0A833E.3C396756@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206142028170.26335-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002, Andrew Morton wrote:

> A poorly-written gigE driver could zoom in and steal the remaining
> few megabytes from interrupt context.  But even then, the BIO mempools
> would have to be exhausted at the time.  And I don't see a way in which
> they can be exhausted without us having write BIOs in flight.
>
> No, I can't prove it.  But I can't think of a contrary scenario
> either.

NBD and iSCSI are two examples that come to mind. Error-handling on the
SCSI stack might get you into trouble too (though you'd probably lose
there anyway). I suspect LVM might need to alloc memory to back snapshots,
but I haven't looked at that. I won't even mention loopback.

But for all the boring scenarios, you should be fine.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

