Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWIASJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWIASJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWIASJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:09:50 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:27624 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750706AbWIASJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:09:49 -0400
Date: Fri, 1 Sep 2006 20:14:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Adrian Bunk <bunk@stusta.de>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060901181435.GA21187@uranus.ravnborg.org>
References: <20060830214356.GO18276@stusta.de> <Pine.LNX.4.64.0608310039440.6761@scrub.home> <1157069717.2347.13.camel@shinybook.infradead.org> <20060831174852.18efec7e.rdunlap@xenotime.net> <1157074048.2347.24.camel@shinybook.infradead.org> <20060901134425.GA32440@wohnheim.fh-wedel.de> <44F85267.1000607@s5r6.in-berlin.de> <20060901161920.GB32440@wohnheim.fh-wedel.de> <20060901163403.GC18276@stusta.de> <44F8732B.8080102@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F8732B.8080102@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 07:51:39PM +0200, Stefan Richter wrote:
> 
> It will get difficult to entirely please users who don't use these 
> interfaces to .config.

We have a number of more or less friendly interfaces to configure
the kernel. Yet some people prefer to directly modify the .config.
That is fine let them do so.
But to get an overview over the sometimes complex logic thay have
to turn to move powerfull tools such as menuconfig.

Editing .config is a second class citizen way of configuring the
kernel, and menuconfig is first class IMHO.

So enhancing the .config file to express the dependencies
is not the way forward. We should do this in menuconfig (and friends)
and let users use the dedicated interface to edit their kernel
configuration using the dedicated tools and not by editing .config.

Much of the discussion are centered about "select" which is indeed
ugly are in some cases ill-used.
But prime issue is that using select makes it hard to
un-select certain configuration items. And avoiding select makes it
un-intuitive to enable some configuration items.
So we simple needs to:
1) Make is easy to un-select selected configuration items by unselecting
   the relevant items
2) Make it possible to select 'non-visible' options by providing a way
   to satisfy the dependencies.

And maybe 2) makes select almost obsolete..

	Sam
