Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVCJFYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVCJFYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVCJFUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:20:35 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:23047 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261728AbVCJFRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:17:14 -0500
Date: Thu, 10 Mar 2005 06:16:46 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050310051646.GC30052@alpha.home.local>
References: <20050309083923.GA20461@kroah.com> <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt> <20050309111102.GA30119@elf.ucw.cz> <20050309235716.GZ3163@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309235716.GZ3163@waste.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 03:57:16PM -0800, Matt Mackall wrote:
 
> Imagine we want to go from 2.6.11.3 to 2.6.12

The easiest way would be to keep a local fresh copy of 2.6.11 before
applying 2.6.11.3 anyway.  That would solve a) and b) even more easily.
And yes, I find a) more logical. This is the way all private trees have
been working for ages. When you download 2.6.11-ac2, it's not a patch
against -ac1, but against 2.6.11. If you want to start from -ac1, you
get the 2.6.11-ac1-ac2 patch.

And last, since these patches are mostly bugfixes for the reference kernel
(eg: 2.6.11), it seems logical to be able to patch that kernel with the
latest bug fix.

cheers,
willy

> case a)
> revert patch 2.6.11.3
> get and apply 2.6.12
> 
> case b)
> revert patch 2.6.11.3
> revert patch 2.6.11.2
> revert patch 2.6.11.1
> get and apply 2.6.12
> 
> case c)
> poke around on kernel.org and figure out that the last kernel in .11 is .11.5
> get and apply 2.6.11.4
> get and apply 2.6.11.5
> get and apply 2.6.12
> 
> Note this gets increasingly more painful in cases b and c when there
> are a large number of post-releases. And case c) is really stupid when
> you want to go from 2.6.12 to 2.6.11.
> 
> Also note that -pre, -rc, -bk, -mm, -ac, and every other branch off a
> release has worked the a) way.
> 
> -- 
> Mathematics is the supreme nostalgia of our time.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
