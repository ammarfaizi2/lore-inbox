Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVCZM1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVCZM1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 07:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVCZM1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 07:27:18 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:9992 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261752AbVCZM1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 07:27:14 -0500
Date: Sat, 26 Mar 2005 13:27:06 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc2
Message-ID: <20050326122706.GA14756@alpha.home.local>
References: <20050326004631.GC17637@logos.cnet> <20050326112256.GN30052@alpha.home.local> <1111837493.8042.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111837493.8042.2.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 12:44:53PM +0100, Arjan van de Ven wrote:
> On Sat, 2005-03-26 at 12:22 +0100, Willy Tarreau wrote:
> > Marcelo,
> > 
> > here's a patch from Dave Jones, which is already in 2.6 and which I've
> > used in my local tree for 6 months now. It removes a useless NULL check
> > in zlib_inflateInit2_(), since 'z' is already dereferenced one line
> > before the test. Can in go in 2.4.30 please ?
> 
> I don't see how such a cleanup-only patch would be a candidate for 2.4
> at all, let alone to go into a -rc3 or a 2.4.30 final at this stage...
> 
> Can you explain why this one is so important that it has to go in so
> late?

On the contrary, it's just because it's not important at all that I
thought it could go in, the same way as other parts of unused code
got removed in rc2 (eg: jfs aops). As to the fact that it's late,
well, I would have prefered sending it sooner, but I simply don't
decide when I have spare time for this.

I have no problem at all with all these patches not merged, I simply
think that it makes maintainers' work easier to support homogeneous
code across versions with the least possible dead code, especially
when it comes to simple patches like this one. If you think it's better
to keep unused code because it makes debugging funnier, OK, that's fine.
Anyway, I'm just proposing, maintainers decide.

Willy

