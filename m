Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVJLJKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVJLJKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 05:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVJLJKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 05:10:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21681 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932424AbVJLJKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 05:10:04 -0400
Date: Wed, 12 Oct 2005 11:09:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: Felix Oxley <lkml@oxley.org>
Cc: OBATA Noboru <noboru.obata.ar@hitachi.com>, hyoshiok@miraclelinux.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
Message-ID: <20051012090945.GN12682@elf.ucw.cz>
References: <20051010084535.GA2298@elf.ucw.cz> <20051012.172844.59463643.noboru.obata.ar@hitachi.com> <200510121002.59098.lkml@oxley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510121002.59098.lkml@oxley.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >    CMD     | NET TIME (in seconds)          | OUTPUT SIZE (in bytes)
> >   ---------+--------------------------------+------------------------
> >    cp      |  35.94 (usr 0.23, sys 14.16)   | 2,121,438,352 (100.0%)
> >    lzf     |  54.30 (usr 35.04, sys 13.10)  | 1,959,473,330 ( 92.3%)
> >    gzip -1 | 200.36 (usr 186.84, sys 11.73) | 1,938,686,487 ( 91.3%)
> >   ---------+--------------------------------+------------------------
> >
> > Although it is too early to say lzf's compress ratio is good
> > enough, its compression speed is impressive indeed.  
> 
> As you say, the speed of lzf relative to gzip is impressive.
> 
> However if the properties of the kernel dump mean that it is not suitable for 
> compression then surely it is not efficient to spend any time on it.
> 
> >And the
> > result also suggests that it is too early to give up the idea of
> > full dump with compression.
> 
> Are you sure? :-)
> If we are talking about systems with 32GB of memory then we must be taking 
> about organisations who can afford an extra 100GB of disk space just for 
> keeping their kernel dump files. 
> 
> I would expect that speed of recovery would always be the primary concern.
> Would you agree?

Notice that suspend2 project actually introduced compression *for
speed*. Doing it right means that it is faster to do it
compressed. See Jamie Lokier's description how to *never* slow down.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
