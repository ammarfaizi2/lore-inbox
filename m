Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWENEBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWENEBv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 00:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWENEBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 00:01:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:39145 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964808AbWENEBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 00:01:50 -0400
Date: Sat, 13 May 2006 20:59:37 -0700
From: Greg KH <greg@kroah.com>
To: nick@linicks.net
Cc: Adrian Bunk <bunk@stusta.de>, Ingo Oeser <ioe-lkml@rameria.de>,
       Chris Wright <chrisw@sous-sol.org>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.16
Message-ID: <20060514035937.GA6498@kroah.com>
References: <20060511022547.GE25010@moss.sous-sol.org> <296295514.20060511123419@dns.toxicfilms.tv> <20060511173312.GI25010@moss.sous-sol.org> <200605131735.20062.ioe-lkml@rameria.de> <20060513155610.GB6931@stusta.de> <7c3341450605131029l194174f3v7339dce0e234b555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3341450605131029l194174f3v7339dce0e234b555@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 06:29:25PM +0100, Nick Warne wrote:
> On 13/05/06, Adrian Bunk <bunk@stusta.de> wrote:
> >The CVE should be enough for easily getting all information you
> >requested.
> >
> >Information whether it's a DoS or a root exploit is helpful, but any
> >qualified person doing risk management will anyways lookup the CVE.
> 
> Well, yes, but some people do *actually* use the latest kernel at home
> and not in labs (et al), and as Maciej asked, we are not sure whether
> the (whatever) latest patch is needed or not on whatever our current
> config is the way the latest stable fixes are announced.
> 
> "    [PATCH] fs/locks.c: Fix lease_init (CVE-2006-1860)
> 
>    It is insane to be giving lease_init() the task of freeing the lock it is
>    supposed to initialise, given that the lock is not guaranteed to be
>    allocated on the stack. This causes lockups in fcntl_setlease().
>    Problem diagnosed by Daniel Hokka Zakrisson <daniel@hozac.com>
> 
>    Also fix a slab leak in __setlease() due to an uninitialised return 
>    value.
>    Problem diagnosed by Bj????rn Steinbrink.
> "
> 
> OK, great.  But what does it mean?
> 
> It would be nice to have a short explanation of what the fix is for in
> real world terms.

To be fair, the extra work of writing out a detailed exploit, complete
with example code, for every security update, would just take way too
long.  If you look for where this patch was discussed on lkml, you will
see a full description of the problem, and how to hit it.

thanks,

greg k-h
