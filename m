Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVG2Tzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVG2Tzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVG2TzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:55:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18098 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262779AbVG2TxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:53:04 -0400
Date: Fri, 29 Jul 2005 12:51:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cal Peake <cp@absolutedigital.net>
Cc: torvalds@osdl.org, perex@suse.cz, linux-kernel@vger.kernel.org,
       rostedt@goodmis.org
Subject: Re: Linux 2.6.13-rc4 (snd-cs46xx)
Message-Id: <20050729125135.19205830.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507291315010.869@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>
	<Pine.LNX.4.61.0507282328520.966@lancer.cnet.absolutedigital.net>
	<20050728213543.6264ca60.akpm@osdl.org>
	<Pine.LNX.4.61.0507291315010.869@lancer.cnet.absolutedigital.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake <cp@absolutedigital.net> wrote:
>
> On Thu, 28 Jul 2005, Andrew Morton wrote:
> 
>  > The procfs inode IDR tree is scrogged.  I'd be suspecting a random memory
>  > scribble.  I'd suggest that you enable CONFIG_DEBUG_SLAB,
>  > CONFIG_DEBUG_PAGEALLOC, CONFIG_DEBUG_everything_else and retest.
>  > 
>  > If that doesn't show anything, try eliminating stuff from your kernel
>  > config.
>  > 
>  > If it _is_ a scribble then there's a good chance that changing the config
>  > will simply make it disappear, or will make it manifest in different ways.
> 
>  Thanks Andrew! Indeed your suspicions are correct. Adding in all the 
>  debugging moved the problem around, it now shows itself when probing 
>  parport. Upon further investigation reverting the commit below seems to 
>  have nixed the problem.
> 
>  [PATCH] speed up on find_first_bit for i386 (let compiler do the work)

Thanks a million for that.
