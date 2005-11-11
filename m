Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVKKRiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVKKRiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVKKRiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:38:03 -0500
Received: from i121.durables.org ([64.81.244.121]:2023 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750951AbVKKRiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:38:01 -0500
Date: Fri, 11 Nov 2005 09:37:37 -0800
From: Matt Mackall <mpm@selenic.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] misc: Configurable number of supported IDE interfaces
Message-ID: <20051111173737.GY11462@waste.org>
References: <14.282480653@selenic.com> <15.282480653@selenic.com> <58cb370e0511110214i33792f33y1b44410d3006fd5f@mail.gmail.com> <20051111171842.GW11462@waste.org> <Pine.LNX.4.61.0511111830140.1610@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511111830140.1610@scrub.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 06:34:27PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Fri, 11 Nov 2005, Matt Mackall wrote:
> 
> > It's intentional. The current CONFIG_IDE_MAX_HWIFS is a hidden
> > variable that sets a per architecture maximum. To the best of my
> > knowledge, there's no way to do, say:
> > 
> >    default 4 if ARCH_FOO
> >    default 1 if ARCH_BAR
> > 
> > ..so I'm stuck with using two config symbols anyway.
> 
> Where is the problem? This should work fine.

Does it? Didn't work when last I checked (which was a while ago).

> With the latest kernel you can even use a dynamic range:
> 
> config IDE_HWIFS
> 	int "..."
> 	range 1 IDE_MAX_HWIFS

But this suggests a good reason to hold on to both variables.

-- 
Mathematics is the supreme nostalgia of our time.
