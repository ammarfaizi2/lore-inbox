Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263078AbRE1Pck>; Mon, 28 May 2001 11:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263079AbRE1Pca>; Mon, 28 May 2001 11:32:30 -0400
Received: from albireo.ucw.cz ([62.168.0.14]:55044 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S263078AbRE1PcN>;
	Mon, 28 May 2001 11:32:13 -0400
Date: Mon, 28 May 2001 17:31:52 +0200
From: Martin Mares <mj@suse.cz>
To: pazke@orbita1.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC][REPOST] __init_msg(x) and friends macro
Message-ID: <20010528173152.A808@albireo.ucw.cz>
In-Reply-To: <20010528155841.A24736@orbita1.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010528155841.A24736@orbita1.ru>; from pazke@orbita1.ru on Mon, May 28, 2001 at 03:58:41PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Patch adds __init_msg (and friends) macro that places its argument 
> (string constant) into corresponding .data.init section and returns
> pointer to it. The goal of this patch is to allow constructions like this:
> 
>         static void __init foo(void)
> 	{
> 		printk(__init_msg(KERN_INFO "Some random long message "
> 				  "going to .data.init and then to bit bucket\n"));
> 	}
> 
> I hope this patch can save some memory and will be usefull :))

I think it's better to teach GCC understanding another function attribute
defining the default section of all read-only data defined in the function.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
Even nostalgia isn't what it used to be.
