Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129767AbQKBWcg>; Thu, 2 Nov 2000 17:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129787AbQKBWc0>; Thu, 2 Nov 2000 17:32:26 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42258 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129767AbQKBWcR>;
	Thu, 2 Nov 2000 17:32:17 -0500
Message-ID: <3A01EB44.924D164A@mandrakesoft.com>
Date: Thu, 02 Nov 2000 17:31:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hugh@mimosa.com
CC: Tim Riker <Tim@Rikers.org>, Andrea Arcangeli <andrea@suse.de>,
        Andi Kleen <ak@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <Pine.LNX.4.21.0011021655260.8398-100000@redshift.mimosa.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hugh Redelmeier" wrote:
> Being GCC-dependent is rather parochial.  Being GCC-version-dependent
> is downright embarrassing.
> 
> Summary: spurious GCC-isms are a bad thing.

Summary:  You have no clue about kernel<->gcc interdependencies and
issues.


> - use ISO C 89 when possible (without undue pain)
> 
> - use IOS C 99 when advantageous
> 
> - use GCCisms for the remainder of appropriate things BUT embed them
>   in macros defined in header so that they can be systematically
>   replaced.  Using these macros probably makes the code more readable.
>   Use of any GCCism should probably be justified in commentary.
> 
> This would improve the code *and* make it more portable.

Why does this improve the code?  It gets slower and uglier and more
difficult to maintain.

Why does this make the code more portable?  gcc is already highly
portable, and so it the kernel.  This too gains us nothing.

Removing gcc-isms without a pragmatic reason -- and no, ISO C compliancy
is not a pragmatic reason -- is silly, extra work for little or no
value.

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
