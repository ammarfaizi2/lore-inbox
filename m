Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWENFVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWENFVB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 01:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWENFVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 01:21:01 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27155 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750706AbWENFVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 01:21:01 -0400
Date: Sun, 14 May 2006 07:17:29 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Greg KH <greg@kroah.com>
Cc: nick@linicks.net, Adrian Bunk <bunk@stusta.de>,
       Ingo Oeser <ioe-lkml@rameria.de>, Chris Wright <chrisw@sous-sol.org>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.16
Message-ID: <20060514051729.GL11191@w.ods.org>
References: <20060511022547.GE25010@moss.sous-sol.org> <296295514.20060511123419@dns.toxicfilms.tv> <20060511173312.GI25010@moss.sous-sol.org> <200605131735.20062.ioe-lkml@rameria.de> <20060513155610.GB6931@stusta.de> <7c3341450605131029l194174f3v7339dce0e234b555@mail.gmail.com> <20060514035937.GA6498@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514035937.GA6498@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sat, May 13, 2006 at 08:59:37PM -0700, Greg KH wrote:
> On Sat, May 13, 2006 at 06:29:25PM +0100, Nick Warne wrote:
> > On 13/05/06, Adrian Bunk <bunk@stusta.de> wrote:
> > >The CVE should be enough for easily getting all information you
> > >requested.
> > >
> > >Information whether it's a DoS or a root exploit is helpful, but any
> > >qualified person doing risk management will anyways lookup the CVE.
> > 
> > Well, yes, but some people do *actually* use the latest kernel at home
> > and not in labs (et al), and as Maciej asked, we are not sure whether
> > the (whatever) latest patch is needed or not on whatever our current
> > config is the way the latest stable fixes are announced.
> > 
> > "    [PATCH] fs/locks.c: Fix lease_init (CVE-2006-1860)
> > 
> >    It is insane to be giving lease_init() the task of freeing the lock it is
> >    supposed to initialise, given that the lock is not guaranteed to be
> >    allocated on the stack. This causes lockups in fcntl_setlease().
> >    Problem diagnosed by Daniel Hokka Zakrisson <daniel@hozac.com>
> > 
> >    Also fix a slab leak in __setlease() due to an uninitialised return 
> >    value.
> >    Problem diagnosed by Bj????rn Steinbrink.
> > "
> > 
> > OK, great.  But what does it mean?
> > 
> > It would be nice to have a short explanation of what the fix is for in
> > real world terms.
> 
> To be fair, the extra work of writing out a detailed exploit, complete
> with example code, for every security update, would just take way too
> long.  If you look for where this patch was discussed on lkml, you will
> see a full description of the problem, and how to hit it.

I second this. I try to write detailed changes or at least to compact
the original explanations for patches that go into 2.4 hotfixes, and
sometimes I wonder if I don't do too much. It takes nearly 1/3 of the
time to get the patches in and compile the kernel, and 2/3 of the time
to write things that I sometimes think very few people will read. I
think that if i still do it, it's because I release far less often than
you and Chris do. Otherwise I would have given up.

One compromise might be to post the full changelog in the announcement
in addition to the shortlog. But I agree that security fixes are rarely
well documented by their authors, and CVE descriptions are sometimes
rather obscure :-(

> thanks,
> 
> greg k-h

Regards,
Willy

