Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUISSQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUISSQI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 14:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUISSQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 14:16:08 -0400
Received: from mail.dif.dk ([193.138.115.101]:61075 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261602AbUISSQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 14:16:03 -0400
Date: Sun, 19 Sep 2004 20:22:41 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: plt@taylorassociate.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <1095596968.414d7ba88efc1@webmail.taylorassociate.com>
Message-ID: <Pine.LNX.4.61.0409191739140.2758@dragon.hygekrogen.localhost>
References: <1095596968.414d7ba88efc1@webmail.taylorassociate.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 plt@taylorassociate.com wrote:

> Question: Are you guys going to work on please cleaning up some of the errors in
> the code so we can get please get a more clean compile?
> 
I think it's safe to say that there is an ongoing effort to do that.

Some more strict typechecking has recently been introduced (read more 
here: http://kerneltrap.org/node/view/3848 ) and this currently cause a 
lot of compiler warnings that have yet to be cleaned, but that will happen 
in time - faster if you lend a hand.

> 
> drivers/mtd/nftlmount.c:44: warning: unused variable `oob'
> 
This is due to the fact that the code using that variable is currently 
within an  #if 0  block. I am not familiar with the mtd code, but the 
comment in there has this to say :

#if 0 /* Some people seem to have devices without ECC or erase marks
         on the Media Header blocks. There are enough other sanity
         checks in here that we can probably do without it.
      */

...

#endif

So it would seem that this bit of code could be on its way out. I'd assume 
that once it goes (if it does) that the variable will then be removed as 
well.


Ohh and btw, if you want people to pay attention to your emails you should 
try adding a descriptive Subject:  :)


--
Jesper Juhl

