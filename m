Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUIFIAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUIFIAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUIFIAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:00:41 -0400
Received: from main.gmane.org ([80.91.224.249]:38101 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267592AbUIFH6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:58:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH] removes unnessary print of space
Date: Mon, 06 Sep 2004 16:57:55 +0900
Message-ID: <chh5a5$tle$1@sea.gmane.org>
References: <413C0CC5.4000807@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <413C0CC5.4000807@sw.ru>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> This patch removes unnessary print of space in bust_spinlocks().
> printk("") wakeups klogd as well, no need to print a space
> and make a mess.
> 
I may be just a newbie, but why call prink with no arguments?
Does it do something?

> ------------------------------------------------------------------------
> 
> --- ./arch/i386/mm/fault.c.printk	2004-08-14 14:54:46.000000000 +0400
> +++ ./arch/i386/mm/fault.c	2004-09-06 11:02:32.730550352 +0400
> @@ -51,7 +51,7 @@ void bust_spinlocks(int yes)
>  	 * a poke.  Hold onto your hats...
>  	 */
>  	console_loglevel = 15;		/* NMI oopser may have shut the console up */
> -	printk(" ");
> +	printk("");
>  	console_loglevel = loglevel_save;
>  }
>  

Kalin.
-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

