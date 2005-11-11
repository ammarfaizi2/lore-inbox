Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVKKRTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVKKRTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 12:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVKKRTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 12:19:24 -0500
Received: from i121.durables.org ([64.81.244.121]:10908 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750936AbVKKRTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 12:19:23 -0500
Date: Fri, 11 Nov 2005 09:18:42 -0800
From: Matt Mackall <mpm@selenic.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] misc: Configurable number of supported IDE interfaces
Message-ID: <20051111171842.GW11462@waste.org>
References: <14.282480653@selenic.com> <15.282480653@selenic.com> <58cb370e0511110214i33792f33y1b44410d3006fd5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0511110214i33792f33y1b44410d3006fd5f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 11:14:08AM +0100, Bartlomiej Zolnierkiewicz wrote:
[top-posting adjusted]
> > This overrides the default limit (which may be set per arch with
> > CONFIG_IDE_MAX_HWIFS). This is the result of setting interfaces to 1:
>
> You are duplicating functionality of CONFIG_IDE_MAX_HWIFS,
> please find a way to use it for EMBEDDED.

It's intentional. The current CONFIG_IDE_MAX_HWIFS is a hidden
variable that sets a per architecture maximum. To the best of my
knowledge, there's no way to do, say:

   default 4 if ARCH_FOO
   default 1 if ARCH_BAR

..so I'm stuck with using two config symbols anyway.

I've thought about it, this is the best I could come up with. If you
can come up with something cleaner, I'm all ears.

-- 
Mathematics is the supreme nostalgia of our time.
