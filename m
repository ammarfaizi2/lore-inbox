Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVCCX0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVCCX0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVCCXZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:25:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:45253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262662AbVCCXR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:17:57 -0500
Date: Thu, 3 Mar 2005 15:17:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: jgarzik@pobox.com, torvalds@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303151752.00527ae7.akpm@osdl.org>
In-Reply-To: <20050303181122.GB12103@kroah.com>
References: <42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > It's perfectly workable from a BK standpoint to do
> > 
> > 	-> linux-2.6 commit
> > 	-> cpcset into linux-2.6.X.Y [see Documentation/BK-usage/cpcset]
> > 	-> pull from linux-2.6.X.Y into linux-2.6 [dups cset, but no
> > 	   real code change]
> 
> That's fine with me to do.  As long as someone points out to $sucker
> that such a patch should go into 2.6.x.y.

That's the only way it _can_ work.  The maintainer of 2.6.x.y shouldn't be
put in a position of having to locate the patches which he needs.

Like it or not, Vojtech is still the maintainer of the input system in
2.6.x.y and he should be the primary guy who keeps an eye out for patches
which needs to be applied there.

If we go overboard here, every maintainer will end up maintaining
another tree of "stuff which needs to be backported to 2.6.x.y", which is
probably more work than we want to do.

As long as we can keep it down to "small and really critical things" then
it should work OK.

Ideally, the 2.6.x.y maintainer wouldn't need any particular kernel
development skills - it's just patchmonkeying the things which maintainers
send him.
