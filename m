Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312431AbSDEJxh>; Fri, 5 Apr 2002 04:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312442AbSDEJx2>; Fri, 5 Apr 2002 04:53:28 -0500
Received: from gold.muskoka.com ([216.123.107.5]:51471 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S312431AbSDEJxX>;
	Fri, 5 Apr 2002 04:53:23 -0500
Message-ID: <3CAD6D74.6E834BC5@yahoo.com>
Date: Fri, 05 Apr 2002 04:25:08 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.18 i586)
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.44L.0204041217290.18660-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As it stands right now it is IMPOSSIBLE to support binary only
> drivers and I can only see two ways out of this situation:

Two different things "supporting" and "allowing".  Currently it is that BOM 
are "allowed".  (I am not entering the discussion on whether this is good 
or bad.)  Note that you will not find too many volunteer hackers jumping
in to help "support" users with BOMs - the lk archives will reflect this.

If a vendor decides to release a BOM, then it is implicit in their decision 
that by doing so, they have voluntarily denied to accept the support that 
comes from having many different persons auditing their code, if it was 
available.  Hence the issue of "support" lies on their shoulders entirely.

> (1) don't allow binary only modules at all
> 
> (2) have a stable ABI for binary only modules and don't allow
>     these binary only modules to use other symbols, so people
>     in need of binary only modules won't be locked to one
>     particular version of the kernel (or have two binary only
>     modules locked to _different_ versions of the kernel)

One of the great things about linux is that code quality and performance 
have always taken precedence over keeping an interface carved in stone.  
We've tried to not make radical inteface changes in stable relases, but 
where necessary it has been done, and we were free to do so.  If a vendor
with a BOM can't take the time to appropriately update their code and 
release a new BOM, then it is clear that they don't really support linux.

If someone has chosen hardware for which a BOM is the only option, then 
they need to investigate in detail that vendor's support policy, and get 
things in writing if need be (e.g.  large installation base, etc) detailing 
just how current bugs and new drivers for future kernels will be handled.
If a vendor wants $$$ for such a written support policy, then you have to
factor that into the overall cost of what you are setting up.

If someone is stuck with _two_ unsupported BOMs that are for two different 
kernels, then I'd have to say they didn't do their homework when choosing 
the hardware and/or determining if the level of support the vendor was 
offering was adequate for their particular application.  Caveat emptor.

Paul.


