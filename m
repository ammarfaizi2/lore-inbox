Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWESKKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWESKKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWESKKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:10:09 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:23509 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S932248AbWESKKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:10:07 -0400
Date: Fri, 19 May 2006 13:10:06 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stealing ur megahurts (no, really)
Message-ID: <20060519101006.GL8304@mea-ext.zmailer.org>
References: <446D61EE.4010900@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446D61EE.4010900@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 02:13:02AM -0400, John Richard Moser wrote:
...
> On Linux we have mem= to toy with memory, which I personally HAVE used
> to evaluate how various distributions and releases of GNOME operate
> under memory pressure.  This is a lot more convenient than pulling chips
> and trying to find the right combination.  This option was, apparently,
> designed for situations where actual system memory capacity is
> mis-detected (mandrake 7.2 and its insistence that a 256M memory stick
> is 255M....); but is very useful in this application too.
> 
> This brings the idea of a cpumhz= parameter to adjust CPU clock rate.
> Obviously we can't do this directly, as convenient as this would be; but
> the idea warrants some thought, and some thought I gave it.  What I came
> up with was simple:  Adjust time slice length and place a delay between
> time slices so they're evenly spaced.
...
> Questions?  Comments?  Particular ideas on what would happen?

Modern machines have ability to be "speed controlled" - Perhaps
they can cut their speed by 1/3 or 1/2, but run slower anyway
in the name of energy conservation.


Another approach (not thinking on multiprocessor systems now)
is to somehow gobble up system performance into some "hoarder"
(highest scheduling priority, eats up 90% of time slices doing
excellent waste of CPU resources..)

Combine that with internal timer ticking at 1000 or 1024 Hz, and
you do get fairly good approximation of a machine running at 1/10
of its real speed.

Kernel IO tasks might skew statistics a bit, but that is another story.


In multiprocessor systems similar hoarders do work combined with
CPU Affinity - one hoarder for each processor.

/Matti Aarnio
