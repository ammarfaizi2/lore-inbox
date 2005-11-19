Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVKSUvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVKSUvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKSUvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:51:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55813 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750823AbVKSUvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:51:21 -0500
Date: Sat, 19 Nov 2005 21:51:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20051119205120.GQ16060@stusta.de>
References: <20051118024433.GN11494@stusta.de> <20051117185529.31d33192.akpm@osdl.org> <20051118031751.GA2773@redhat.com> <20051117.194239.37311109.davem@davemloft.net> <20051117200354.6acb3599.akpm@osdl.org> <20051119003435.GA29775@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119003435.GA29775@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 01:34:35AM +0100, Sam Ravnborg wrote:
> On Thu, Nov 17, 2005 at 08:03:54PM -0800, Andrew Morton wrote:
> > "David S. Miller" <davem@davemloft.net> wrote:
> > >
> > > The deprecated warnings are so easy to filter out, so I don't think
> > >  noise is a good argument.  I see them all the time too.
> > 
> > That works for you and me.  But how to train all those people who write
> > warny patches?
> 
> Would it work to use -Werror only on some parts of the kernel.
> Thinking of teaching kbuild to recursively apply a flags to gcc.
> 
> Then we could say that kernel/ should be warning free (to a start).

We can do better as we do currently, but we cannever get the kernel 100% 
warning free for all supported kernel configurations and all supported 
gcc versions.

E.g. gcc emitting some "unused variable" warnings when compiling with 
CONFIG_PCI=n is quite common, and although they could all be fixed there 
will always be some warnings with unusual kernel configurations.

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

