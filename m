Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135548AbRAGWWR>; Sun, 7 Jan 2001 17:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135364AbRAGWV5>; Sun, 7 Jan 2001 17:21:57 -0500
Received: from daikokuya.demon.co.uk ([158.152.184.26]:1796 "EHLO
	monkey.daikokuya.demon.co.uk") by vger.kernel.org with ESMTP
	id <S135304AbRAGWVt>; Sun, 7 Jan 2001 17:21:49 -0500
Date: Sun, 7 Jan 2001 22:21:37 +0000
To: richbaum@acm.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Fix compile warnings in 2.4.0
Message-ID: <20010107222137.B14699@daikokuya.demon.co.uk>
In-Reply-To: <3A589726.5449.291B75@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A589726.5449.291B75@localhost>; from baumr1@coral.indstate.edu on Sun, Jan 07, 2001 at 04:19:50PM -0500
From: Neil Booth <neil@daikokuya.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rich Baum wrote:-

> This patch should fix the rest of the warnings about #endif 
> statements when using the 20001225 gcc snapshot.  Thanks to 
> Keith Owens for providing a script to automate this process.  It got 
> the job done sooner and found warnings to fix for non x86 platforms.

Unfortunately, the script also gets stuff it shouldn't, and in some
cases adds comments within the comments, probably causing stuff to
stop compiling altogether.  Some examples below.

Neil.

> +#                endif	/* # */

[....]

>   * appropriate for an 030 or an 040.  This is useful for debugging purposes
> - * and as such is enclosed in #ifdef MMU_PRINT/#endif clauses.
> + * and as such is enclosed in #ifdef MMU_PRINT/#endif	/* clauses. */
>   *

[...]

>   * is specifically for debugging and can be very useful.  It is surrounded by
> - * #ifdef CONSOLE/#endif clauses so it doesn't have to ship in known-good
> + * #ifdef CONSOLE/#endif	/* clauses so it doesn't have to ship in known-good */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
