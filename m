Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136871AbRAHFmo>; Mon, 8 Jan 2001 00:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136944AbRAHFmf>; Mon, 8 Jan 2001 00:42:35 -0500
Received: from Cantor.suse.de ([194.112.123.193]:62478 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136871AbRAHFm2>;
	Mon, 8 Jan 2001 00:42:28 -0500
Date: Mon, 8 Jan 2001 06:42:25 +0100
From: Andi Kleen <ak@suse.de>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, "William A. Stein" <was@math.harvard.edu>
Subject: Re: Subtle MM bug
Message-ID: <20010108064225.B29026@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.30.0101072014300.17414-100000@mf1.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101072014300.17414-100000@mf1.private>; from whitney@math.berkeley.edu on Sun, Jan 07, 2001 at 09:29:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 09:29:29PM -0800, Wayne Whitney wrote:
> The application is some mathematics computations (modular symbols) using a
> package called MAGMA;  at times this requires very large matrices.  The
> RSS can get up to 870MB; for some reason a MAGMA process under linux
> thinks it has run out of memory at 870MB, regardless of the actual
> memory/swap in the machine.  MAGMA is single-threaded.

I think it's caused by the way malloc maps its memory. 
Newer glibc should work a bit better by falling back to mmap even for smaller
allocations (older does it only for very big ones) 



-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
