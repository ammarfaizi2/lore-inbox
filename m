Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265170AbSJRPMa>; Fri, 18 Oct 2002 11:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSJRPM3>; Fri, 18 Oct 2002 11:12:29 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:3085 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265170AbSJRPM2>; Fri, 18 Oct 2002 11:12:28 -0400
Date: Fri, 18 Oct 2002 16:18:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018161828.A5523@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu> <3DAFCE1B.805@wirex.com> <20021018140543.C1670@infradead.org> <200210181514.g9IFEErG006526@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210181514.g9IFEErG006526@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, Oct 18, 2002 at 11:14:14AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 11:14:14AM -0400, Valdis.Kletnieks@vt.edu wrote:
> OK.. I'll grant that a lot of things done here are fixing the fact that
> there are some really fundamental botches in the Linux kernel, such as
> the fact that there isn't a long history of Posix-capability flavor
> separation (so processes need to start as root just so they can bind
> a low-number port - blech).
> 
> Would fixing *ALL* of that history (and all the userspace crap that has
> grown on top of it) be *LESS* invasive/disruptive than what LSM does?

It would most certainly not be less invasive.  But that's okay.
We want stuff fixed properly, not least invasive.

> Do you have a projected timeline of when this mythical "all the warts in the
> kernel are fixed and all the userspace cruft is cleaned up" world will happen?

It depends on how many people actually work on it..

> I'd like some sort of reasonable estimate, so I know whether this will be
> before or after I retire. (While we're at it, can we reverse the definition
> of the 'r' and 'x' permissions on directories, so 'umask 037' doesn't result
> in directories with borked permissions?  I'm actually somewhat serious here -
> this is the sort of thing that will need to be cleaned up and fixed all over
> the place...)

I dount you can change the meaning of the mod bits ever.  Adding something
like a umask for directories (dmask) might be possible, though.

> The part you're missing here is that the "fuzzy buzzword mechanism" is
> deployable *NOW*, and will provide *real benefits* *NOW*, rather than having
> to wait for the 2.7 or 3.1 or whatever kernel.

By messing up the kernel.  Note that I don't want to steal you your
code - deploy it if you want, but don't harm the mainline kernel with it.

