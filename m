Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWC1IwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWC1IwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWC1IwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:52:09 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:19073 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751385AbWC1IwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:52:07 -0500
Date: Tue, 28 Mar 2006 10:52:06 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060328085206.GA14089@MAIL.13thfloor.at>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4428BB5C.3060803@tmr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 11:28:12PM -0500, Bill Davidsen wrote:
> Dave Hansen wrote:
> >On Sat, 2006-03-25 at 04:33 +1100, Nick Piggin wrote:
> >>Oh, after you come to an agreement and start posting patches, can you
> >>also outline why we want this in the kernel (what it does that low
> >>level virtualization doesn't, etc, etc) 
> >
> >Can you wait for an OLS paper? ;)
> >
> >I'll summarize it this way: low-level virtualization uses resource
> >inefficiently.
> >
> >With this higher-level stuff, you get to share all of the Linux caching,
> >and can do things like sharing libraries pretty naturally.
> >
> >They are also much lighter-weight to create and destroy than full
> >virtual machines.  We were planning on doing some performance
> >comparisons versus some hypervisors like Xen and the ppc64 one to show
> >scaling with the number of virtualized instances.  Creating 100 of these
> >Linux containers is as easy as a couple of shell scripts, but we still
> >can't find anybody crazy enough to go create 100 Xen VMs.
> 
> But these require a modified O/S, do they not? Or do I read that
> incorrectly? Is this going to be real virtualization able to run any
> O/S?

Xen requires slighly modified kernels, while e.g.
Linux-VServer only uses a _single_ kernel for all
virtualized guests ...

> Frankly I don't see running 100 VMs as a realistic goal, being able to
> run Linux, Windows, Solaris and BEOS unmodified in 4-5 VMs would be
> far more useful.

well, that largely depends on the 'use' ...

I don't think that vps providers like lycos would be
very happy if they had to multiply the ammount of
machines they require by 10 or 20 :)

and yes, running 100 and more Linux-VServers on a
single machine _is_ realistic ...

best,
Herbert

> >Anyway, those are the things that came to my mind first.  I'm sure the
> >others involved have their own motivations.
> >
> >-- Dave
> >
