Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTBCPVN>; Mon, 3 Feb 2003 10:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbTBCPVN>; Mon, 3 Feb 2003 10:21:13 -0500
Received: from pointblue.com.pl ([62.121.131.135]:43271 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S266615AbTBCPVM>;
	Mon, 3 Feb 2003 10:21:12 -0500
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044285587.2527.4.camel@laptop.fenrus.com>
References: <1044285222.2396.14.camel@gregs>
	 <1044285587.2527.4.camel@laptop.fenrus.com>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1044286557.2402.20.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Feb 2003 15:35:57 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 15:19, Arjan van de Ven wrote:
> > #include <linux/modversions.h>
> don't do that. ever.
why ?

> > #ifdef CONFIG_KMOD
> > #include <linux/kmod.h>
> > #endif
> 
> bullshit ifdef's (and the surrounding code has a whole bunch too
this has been taken from first from edge module, just to put it into example ;)

> btw you do know you can't do vmalloc (or vfree) from interrupt context ?
> And that every vmalloc eats at minimum 8Kb of virtual memory space? Of
> which you can't count on having more than 64Mb on x86 ?
I didn't knew that. I have at least as i said 300 of those, if user
space software is doing something else. In practice i have around 30.
even if 1000 it gives 1000*8kb=8MB so it is not that bad. This mashine
has 128MB atleast.
Whatver, should i consider timer as interrupt too ?

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

