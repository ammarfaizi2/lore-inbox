Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264425AbTEJQ2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTEJQ2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:28:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40335 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264425AbTEJQ2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:28:23 -0400
Date: Sat, 10 May 2003 18:41:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Shane Shrybman <shrybman@sympatico.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: Can't find CDR device in -mm only
Message-ID: <20030510164102.GD837@suse.de>
References: <1052537820.2441.113.camel@mars.goatskin.org> <20030510092041.GN812@suse.de> <1052578016.2369.7.camel@mars.goatskin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052578016.2369.7.camel@mars.goatskin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10 2003, Shane Shrybman wrote:
> Hi Jens,
> 
> On Sat, 2003-05-10 at 05:20, Jens Axboe wrote:
> > On Fri, May 09 2003, Shane Shrybman wrote:
> > > Hi,
> > > 
> > > The problem first appeared in 2.5.68-mm3 and is not in mainline 2.5.69.
> > > It is present in all -mm releases since.
> > 
> > Curious. Looking at patches between .68-mm2 and -mm3 reveals nothing
> > major, in fact the only thing touching anything in that area seems to be
> > the dynamic request allocation patch. Could you try 2.5.69 with the
> > attached patch to verify that it still works (or doesn't)? There might
> > be a small offset in deadline-iosched.c, should be nothing to worry
> > about.
> 
> Still doesn't work with 2.5.69 + rq_dyn. The output from cdrecord is
> below.

Ah thanks, that kind of narrows it down then. I'll take a look at the
problem tomorrow, should be easy to reproduce. Thanks for reporting!

-- 
Jens Axboe

