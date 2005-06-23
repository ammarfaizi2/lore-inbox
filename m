Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVFWCQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVFWCQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVFWCNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:13:53 -0400
Received: from everest.sosdg.org ([66.93.203.161]:7149 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261930AbVFWCEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:04:54 -0400
Date: Wed, 22 Jun 2005 21:04:45 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: lkml@dervishd.net
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [question] pass CONFIG_FOO to CC problem
Message-ID: <20050623020445.GA19528@everest.sosdg.org>
Reply-To: coywolf@lovecn.org
References: <2cd57c90050622013937d2c209@mail.gmail.com> <20050622181207.GC57@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622181207.GC57@DervishD>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 08:12:07PM +0200, DervishD wrote:
>     Hi Coywolf :)
> 
>  * Coywolf Qi Hunt <coywolf@gmail.com> dixit:
> > I was expecting kbuild passes CONFIG_FOO from .config to CC
> > -DCONFIG_FOO, but it doesn't.  So I have to add
> > 
> > ifdef CONFIG_FOO
> > EXTRA_CFLAGS += -DCONFIG_FOO
> > endif
> 
>     NO! You don't do it that way in the kernel. Think: if you have to
> pass a '-D' option for each config item you set, you will end up with
> TONS of '-D' options, in fact you probably exceed the command line
> size limit.

I see. It's not only ugly, but also harmful.

> 
>     You have to include <linux/config.h> if I recall correctly ;)
> 

<linux/config.h> is for this purpose, if I understand correctly.


		Coywolf
