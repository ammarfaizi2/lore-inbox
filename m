Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbWDNKcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWDNKcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 06:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWDNKcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 06:32:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13319 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965141AbWDNKcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 06:32:03 -0400
Date: Fri, 14 Apr 2006 12:32:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/netlink/: possible cleanups
Message-ID: <20060414103202.GF4162@stusta.de>
References: <20060413162710.GE4162@stusta.de> <20060413.132603.94193712.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413.132603.94193712.davem@davemloft.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 01:26:03PM -0700, David S. Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Thu, 13 Apr 2006 18:27:10 +0200
> 
> > This patch contains the following possible cleanups plus changes related 
> > to them:
> > - make the following needlessly global functions static:
> >   - attr.c: __nla_reserve()
> >   - attr.c: __nla_put()
> > - #if 0 the following unused global functions:
> >   - attr.c: nla_validate()
> >   - attr.c: nla_find()
> >   - attr.c: nla_memcpy()
> >   - attr.c: nla_memcmp()
> >   - attr.c: nla_strcmp()
> >   - attr.c: nla_reserve()
> >   - genetlink.c: genl_unregister_ops()
> > - remove the following unused EXPORT_SYMBOL's:
> >   - af_netlink.c: netlink_set_nonroot
> >   - attr.c: nla_parse
> >   - attr.c: nla_strlcpy
> >   - attr.c: nla_put
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Bunk-bot, you have to stop.
> 
> These interfaces were added so that new users of netlink could
> write their code more easily.
> 
> Unused does not equate to "comment out or delete".

Can you give a more detailed answer which parts of my patch you disagree 
with?

Is the export of netlink_set_nonroot that seems to be both present and 
unused since at least kernel 2.6.0 covered by your statement?

Anything else where a removal might be OK?

I'll then send a stripped-down patch (if any non-empty subset of my 
patch is OK).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

