Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbTBJBiN>; Sun, 9 Feb 2003 20:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTBJBhC>; Sun, 9 Feb 2003 20:37:02 -0500
Received: from dp.samba.org ([66.70.73.150]:42157 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267500AbTBJBg4>;
	Sun, 9 Feb 2003 20:36:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 : drivers/char/ip2/i2lib.c 
In-reply-to: Your message of "Fri, 07 Feb 2003 12:17:45 CDT."
             <Pine.LNX.4.44.0302071214440.6917-100000@master> 
Date: Mon, 10 Feb 2003 11:27:24 +1100
Message-Id: <20030210014641.206E42C0D1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302071214440.6917-100000@master> you write:
> Hello all,
>    The following patch addresses buzilla bug # 320, and separates 1 test 
> into 2 separate 2 tests. Please review for inclusion.

The old code was nonsensical, so I can't trivially tell if the new
code is right.  This has to be done by the author.

With no '@' sign anywhere in the char/ip2 subdirectory, I have no idea
who to send this to 8(

Rusty.

> --- linux/drivers/char/ip2/i2lib.c.old	2003-01-16 21:22:57.000000000 -0500
> +++ linux/drivers/char/ip2/i2lib.c	2003-02-07 02:54:36.000000000 -0500
> @@ -1251,7 +1251,7 @@
>  
>  	}
>  	if ( old_flags & STOPFL_FLAG ) {
> -		if ( 1 == i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL) 
> 0 ) {
> +		if ((1 == i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL)) && (i2QueueCommands(PTYPE_INLINE, pCh, 0, 1, CMD_STOPFL) > 0 )) {
>  			old_flags = 0;	// Success - clear flags
>  		}
>  
> 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
