Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbTIRFR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 01:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbTIRFR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 01:17:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:4483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262968AbTIRFRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 01:17:17 -0400
Date: Wed, 17 Sep 2003 22:17:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: netpoll/netconsole minor tweaks
Message-ID: <20030917221715.B32199@build.pdx.osdl.net>
References: <20030917112447.A24623@osdlab.pdx.osdl.net> <20030917205150.GT4489@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030917205150.GT4489@waste.org>; from mpm@selenic.com on Wed, Sep 17, 2003 at 03:51:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> On Wed, Sep 17, 2003 at 11:24:47AM -0700, Chris Wright wrote:
> > Here's a couple small tweaks.  The first is to netpoll_setup.  The settle
> > time was too short for my e100, and the system would hang.  
> 
> This probably ought to be a command line arg, my tg3 apparently
> doesn't need it at all. One second is what's in the nfs-root stuff,
> perhaps they need to share an arg, I changed it to two because my tlan
> was dropping stuff (but not hanging - that may be a driver bug).
> Ideally, I'd like to find a way to wait until the damn thing is up
> before sending.

Yeah, I agree, that seems best.

> net/ipv4/ipconfig.c:
>  /* Define the friendly delay before and after opening net devices */
>  #define CONF_PRE_OPEN           (HZ/2)  /* Before opening: 1/2 second */
>  #define CONF_POST_OPEN          (1*HZ)  /* After opening: 1 second */
>  
> Anyway, I'm still struggling with getting stuff working on my Opteron
> box, care to take a stab at it?

Sure, I'll poke at it tomorrow, unless you get to it first.

> > The second
> > is to netconsole so that it registers a console with CON_PRINTBUFFER.
> > This helps debugging early bootup issues where you want to capture data
> > from before netconsole is initialized.  Perhaps it should be a param
> > to netconsole?
> 
> I think this can probably be unconditional. Merged.

Ok, cool.
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
