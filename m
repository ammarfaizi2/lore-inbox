Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVKSVAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVKSVAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKSVAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:00:00 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:41539 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750829AbVKSU77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:59:59 -0500
Date: Sat, 19 Nov 2005 22:01:11 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051119210110.GA7799@mars.ravnborg.org>
References: <20051118024433.GN11494@stusta.de> <20051117185529.31d33192.akpm@osdl.org> <20051118031751.GA2773@redhat.com> <20051117.194239.37311109.davem@davemloft.net> <20051117200354.6acb3599.akpm@osdl.org> <20051119003435.GA29775@mars.ravnborg.org> <20051119205120.GQ16060@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119205120.GQ16060@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 09:51:20PM +0100, Adrian Bunk wrote:
> On Sat, Nov 19, 2005 at 01:34:35AM +0100, Sam Ravnborg wrote:
> > On Thu, Nov 17, 2005 at 08:03:54PM -0800, Andrew Morton wrote:
> > > "David S. Miller" <davem@davemloft.net> wrote:
> > > >
> > > > The deprecated warnings are so easy to filter out, so I don't think
> > > >  noise is a good argument.  I see them all the time too.
> > > 
> > > That works for you and me.  But how to train all those people who write
> > > warny patches?
> > 
> > Would it work to use -Werror only on some parts of the kernel.
> > Thinking of teaching kbuild to recursively apply a flags to gcc.
> > 
> > Then we could say that kernel/ should be warning free (to a start).
> 
> We can do better as we do currently, but we cannever get the kernel 100% 
> warning free for all supported kernel configurations and all supported 
> gcc versions.
> 
> E.g. gcc emitting some "unused variable" warnings when compiling with 
> CONFIG_PCI=n is quite common, and although they could all be fixed there 
> will always be some warnings with unusual kernel configurations.

I had no issue with adding more gcc flags, but this is a very valid
argument. So I will for now not do it.
>From a kbuild perspective it could be useful in other situations
to have the possibility to add a variable that was set also and only in
sub-directories. But I will not dive into it before a better reason show
up.

	Sam
