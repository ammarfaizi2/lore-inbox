Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUCMX75 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 18:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbUCMX75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 18:59:57 -0500
Received: from waste.org ([209.173.204.2]:39617 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263219AbUCMX7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 18:59:55 -0500
Date: Sat, 13 Mar 2004 17:59:40 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040313235940.GQ20174@waste.org>
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org> <20040313170839.GV14833@fs.tum.de> <20040313173331.GO20174@waste.org> <20040313175712.GY14833@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313175712.GY14833@fs.tum.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 06:57:13PM +0100, Adrian Bunk wrote:
> On Sat, Mar 13, 2004 at 11:33:32AM -0600, Matt Mackall wrote:
> > 
> > I actually did explicitly note this problem in the part you clipped.
> 
> I clipped nothing, I quoted your _complete_ mail.

Oh, sorry, indeed you did. And it was this bit:

 > And what's happening with some of the new symbols is that they're
 > off in defconfig but on in Kconfig. So I need to come up with a way
 > to take the old defconfig and merge in new symbols from the new
 > defconfig. Then throw it at make oldconfig to drop out any obsolete
 > symbols.

> > But I think it's fair to say that new features that are on by default
> > are in fact bloat in some sense.
> 
> Perhaps in some sense, but not in any interesting sense.
> 
> For the average computer you can buy at your supermarket today it isn't 
> very interesting whether the kernel is bigger by 1 MB or not.
>
> People who need to care about the size of the kernel [1] use hand-tuned 
> .config's that are far away from defconfig - and those people wouldn't 
> enable unneeded features that are on by default.

And my coverage of creep in other _commonly used_ parts of the kernel
would then be nil. Given that allyesconfig can't be expected to build
a kernel on any given day, defconfig is the least arbitrary and most
useful of arbitrary choices.

> You use a metric "size increase of a defconfig kernel [2]", and I simply 
> claim that this metric doesn't measure anything useful for practical 
> purposes.

defconfig is not an unreasonable approximation of features people use. 
If something is added to defconfig, odds are that people will start
using it. Not perfect, obviously, but I've yet to see anyone suggest
anything else that actually provides some coverage.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
