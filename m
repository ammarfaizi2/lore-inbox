Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVLERdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVLERdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVLERdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:33:46 -0500
Received: from tim.rpsys.net ([194.106.48.114]:64705 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932479AbVLERdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:33:46 -0500
Subject: Re: Two module-init-
From: Richard Purdie <rpurdie@rpsys.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-input@atrey.karlin.mff.cuni.cz,
       Scott James Remnant <scott@ubuntu.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, vojtech@suse.cz
In-Reply-To: <1133691865.30188.24.camel@localhost.localdomain>
References: <1133359773.2779.13.camel@localhost.localdomain>
	 <1133482376.4094.11.camel@localhost.localdomain>
	 <200512022319.05246.dtor_core@ameritech.net>
	 <200512022328.29182.dtor_core@ameritech.net>
	 <1133691865.30188.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 17:30:55 +0000
Message-Id: <1133803856.8101.206.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 21:24 +1100, Rusty Russell wrote:
> On Fri, 2005-12-02 at 23:28 -0500, Dmitry Torokhov wrote:
> > On Friday 02 December 2005 23:19, Dmitry Torokhov wrote:
> > > On Thursday 01 December 2005 19:12, Rusty Russell wrote:
> > > > Meanwhile, as noone seems to use swbit in struct input_device_id,
> > > > perhaps we can remove it for 2.6.15?
> > > > 
> > > 
> > > Please take a look at drivers/input/keyboard/corgikbd.c
> > > 
> > 
> > What I meant we do use EV_SW in the drivers and so it sould be part
> > of input_device_id. Nobody uses ffbit or sndbit either and still
> > they are present...
> 
> Sure.  BUT it will break current users.  I'm suggesting we jerk that
> field out for 2.6.15, and reintroduce it for >= 2.6.16, when we can (1)
> ensure everyone has a fixed module-init tools, or (2) make sure everyone
> is using the module alias stuff, or both.
> 
> It seems the simplest solution, surely?

The two users of EV_SW I'm aware of are corgikbd.c and spitzkbd.c.
Speaking as the maintainer of the kernel builds for the main users of
Zaurus 2.6 kernels, I can safely say that those two drivers are always
likely to be compiled into a kernel (not modules) and therefore this is
unlikely to upset anyone from a technical point of view. I keep out of
politics ;-)

Richard



