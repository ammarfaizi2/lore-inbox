Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbTBJBg6>; Sun, 9 Feb 2003 20:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTBJBg6>; Sun, 9 Feb 2003 20:36:58 -0500
Received: from dp.samba.org ([66.70.73.150]:37805 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267498AbTBJBg4>;
	Sun, 9 Feb 2003 20:36:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: re: smctr patch (with no subect)
In-reply-to: Your message of "Fri, 07 Feb 2003 12:05:28 CDT."
             <Pine.LNX.4.44.0302071204270.6917-100000@master> 
Date: Mon, 10 Feb 2003 11:20:02 +1100
Message-Id: <20030210014640.D2DD72C078@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302071204270.6917-100000@master> you write:
> Hello all,
>    The following patch addresses buzilla bug # 312, and removes an
> offending semicolon. Please review for inclusion.
> 
> Regards,
> Frank
> 
> --- linux/drivers/net/tokenring/smctr.c.old	2003-01-16 21:22:09.000000000 -
0500
> +++ linux/drivers/net/tokenring/smctr.c	2003-02-07 03:10:50.000000000 -
0500
> @@ -3064,7 +3064,7 @@
>          __u8 r;
>  
>          /* Check if node address has been specified by user. (non-0) */
> -        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++);
> +        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++)
>          {
>                  if(i != 6)
>                  {

NAK, I believe this is the way the code is supposed to work.

Of course, opening a new block after the for is completely gratuitous
and designed to fool the reader.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
