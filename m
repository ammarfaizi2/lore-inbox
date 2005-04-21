Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVDUQB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVDUQB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVDUQB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:01:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:20668 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261477AbVDUQBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:01:55 -0400
Date: Thu, 21 Apr 2005 09:01:04 -0700
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc2] aoe [1/6]: improve allowed interfaces configuration
Message-ID: <20050421160104.GA10221@kroah.com>
References: <3VqSf-2z7-15@gated-at.bofh.it> <E1DOVtj-0003bF-6c@be1.7eggert.dyndns.org> <87y8bcjlpq.fsf@coraid.com> <20050421145658.GA27263@kroah.com> <87pswoi1vl.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pswoi1vl.fsf@coraid.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 11:30:06AM -0400, Ed L Cashin wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Thu, Apr 21, 2005 at 09:36:17AM -0400, Ed L Cashin wrote:
> >> "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de> writes:
> >> 
> >> > Ed L Cashin <ecashin@coraid.com> wrote:
> >> >
> >> >> +++ b/Documentation/aoe/aoe.txt       2005-04-20 11:42:20.000000000 -0400
> >> >
> >> >> +  When the aoe driver is a module, use
> >> >
> >> > Is there any reason for this inconsistent behaviour?
> >> 
> >> Yes, the /sys/module/aoe area is only present when the aoe driver is a
> >> module.
> >
> > Not true, have you looked in /sys/module lately?  :)
> >
> >> It would be nicer if there were a sysfs area where I could
> >> put this file regardless of whether the driver is a module or built
> >> into the kernel.  
> >
> > That's the place for it.  It will be there if the driver is built as a
> > module or into the kernel.
> 
> Wow!  Well, that's very convenient for driver writers, so I'm pleased,
> and I can update the docs.  It surprises me, though, to find out that
> /sys/module is for things other than modules.

It's not for things other than modules, it's filling a real need that
you yourself just pointed out.  Namely, we need to be able to have
access to module paramaters in a consistant place, no matter if the
driver is built into the kernel or not.

Man, you try to be nice to people...  :)

thanks,

greg k-h
