Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVAMDzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVAMDzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVAMDzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:55:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:56983 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261453AbVAMDyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:54:12 -0500
Date: Wed, 12 Jan 2005 19:54:10 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
       marcelo.tosatti@cyclades.com, greg@kroah.com, chrisw@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112195410.G24171@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <20050112194239.0a7b720b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050112194239.0a7b720b.akpm@osdl.org>; from akpm@osdl.org on Wed, Jan 12, 2005 at 07:42:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> yup.  But there are so many ways to cripple a Linux box once you have local
> access.  Another means which happens to be bug-induced doesn't seem
> important.

That depends on the environment.  If it's already locked down via MAC
and rlimits, etc. and the bug now creates a DoS that wasn't there before
it may be important.  But, as a general rule of thumb, local DoS
is much less severe than other bugs, I fully agree.

> > An information leak from kernel space may be equally as mundane to some,
> > though terrifying to some admins. Would you want some process to be
> > leaking your root password, credit card #, etc to some other users process ?
> > 
> > priveledge escalation is clearly the number one threat. Whilst some
> > class 'remote root hole' higher risk than 'local root hole', far
> > too often, we've had instances where execution of shellcode by
> > overflowing some buffer in $crappyapp has led to a shell
> > turning a local root into a remote root.
> 
> I'd place information leaks and privilege escalations into their own class,
> way above "yet another local DoS".

Yes, me too.

> A local privilege escalation hole should be viewed as seriously as a remote
> privilege escalation hole, given the bugginess of userspace servers, yes?

Absolutely, yes.  Local root hole all too often == remote root hole.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
