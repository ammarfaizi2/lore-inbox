Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVALUZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVALUZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVALUYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:24:30 -0500
Received: from waste.org ([216.27.176.166]:37349 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261352AbVALURY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:17:24 -0500
Date: Wed, 12 Jan 2005 12:16:56 -0800
From: Matt Mackall <mpm@selenic.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: David Lang <dlang@digitalinsight.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       Andries Brouwer <aebr@win.tue.nl>, "Barry K. Nathan" <barryn@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050112201656.GK2995@waste.org>
References: <20050111235907.GG2760@pclin040.win.tue.nl> <Pine.LNX.4.61.0501120203510.2912@dragon.hygekrogen.localhost> <Pine.LNX.4.60.0501111714450.18921@dlang.diginsite.com> <20050111223641.GA27100@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111223641.GA27100@logos.cnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 08:36:41PM -0200, Marcelo Tosatti wrote:
> > >>There are more ancient system calls, like old_stat and oldolduname.
> > >>Do we want separate options for each system call that is obsoleted?
> > >>
> > >IMO, no, we do not.
> > 
> > how about something like the embedded, experimental, and broken options. 
> > that way normal users can disable all of them at a stroke, people who need 
> > them can add them in.
> 
> Thats just not an option - you would have zillions of config options. 
> 
> Moreover this is a system call, and the system call interface is one of the few 
> supposed to be stable. You shouldnt simply assume that "no one will ever use sys_uselib()" - 
> there might be programs out there who use it.
> 
> I agree with Andries.

In -tiny, I've added config options for disabling _many_ syscalls (but
not this one). They all go under EMBEDDED. And then I changed the
description of EMBEDDED to imply that changing anything takes you into
nonstandard, unsupported territory.

-- 
Mathematics is the supreme nostalgia of our time.
