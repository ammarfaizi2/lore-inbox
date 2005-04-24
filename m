Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVDXV1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVDXV1b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVDXV1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:27:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:35763 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262439AbVDXV1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:27:16 -0400
Date: Sun, 24 Apr 2005 13:53:10 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org, roland@topspin.com,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050424205309.GA5386@kroah.com>
References: <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426BABF4.3050205@ammasso.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 09:23:48AM -0500, Timur Tabi wrote:
> Andrew Morton wrote:
> 
> >If your theory is correct then it should be able to demonstrate this
> >problem without any special hardware at all: pin some user memory, then
> >generate memory pressure then check the contents of those pinned pages.
> 
> I tried that, but I couldn't get it to fail.  But that was a while ago, and 
> I've learned a few things since then, so I'll try again.
> 
> >But if, for the DMA transfer, you're using the array of page*'s which were
> >originally obtained from get_user_pages() then it's rather hard to see how
> >the kernel could alter the page's contents.
> >
> >Then again, if mlock() fixes it then something's up.  Very odd.
> 
> With mlock(), we don't need to use get_user_pages() at all.  Arjan tells me 
> the only time an mlocked page can move is with hot (un)plug of memory, but 
> that isn't supported on the systems that we support.

You don't "support" i386 or ia64 or x86-64 or ppc64 systems?  What
hardware do you support?  And what about the fact that you are aiming to
get this code into mainline, right?  If not, why are you asking here?
:)

thanks,

greg k-h
