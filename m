Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272315AbRHXUWL>; Fri, 24 Aug 2001 16:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272316AbRHXUWB>; Fri, 24 Aug 2001 16:22:01 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:22182 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S272315AbRHXUVs>;
	Fri, 24 Aug 2001 16:21:48 -0400
Date: Fri, 24 Aug 2001 22:22:02 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software raid does not do parallel reads under 2.4?
Message-ID: <20010824222202.B12903@fuji.laendle>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010823234218.B12873@cerebro.laendle> <15238.11161.492557.264988@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15238.11161.492557.264988@notabene.cse.unsw.edu.au>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 08:25:29PM +1000, Neil Brown <neilb@cse.unsw.edu.au> wrote:
> For raid0, the md driver just redirects requests to the right drive.
> It doesn't explicitly serialise or parallelise anything. 2.4 works in
> exactly the same was as 2.2.

then why is 2.2 so much faster?

> With a 2MB chunksize, I would expect a linear read to touch just one
> drive at a time.

why? i read 8mb cvhunks a time (see the dd) so it should read 3x2mb
chunks easily. anyway, i get the same throughput with 64k, 16k etc..
chunksize.

> With a 4K chunk size, I suspect that an linear read would read from
> all the drives in parallel.

maybe, but it's still exactly as fast: 30mb/s, which is slower than one drive
can do.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
