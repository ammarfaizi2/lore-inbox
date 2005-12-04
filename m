Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVLDKY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVLDKY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 05:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVLDKY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 05:24:28 -0500
Received: from ozlabs.org ([203.10.76.45]:38617 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750952AbVLDKY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 05:24:27 -0500
Subject: Re: Two module-init-
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Scott James Remnant <scott@ubuntu.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, vojtech@suse.cz
In-Reply-To: <200512022328.29182.dtor_core@ameritech.net>
References: <1133359773.2779.13.camel@localhost.localdomain>
	 <1133482376.4094.11.camel@localhost.localdomain>
	 <200512022319.05246.dtor_core@ameritech.net>
	 <200512022328.29182.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 21:24:25 +1100
Message-Id: <1133691865.30188.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 23:28 -0500, Dmitry Torokhov wrote:
> On Friday 02 December 2005 23:19, Dmitry Torokhov wrote:
> > On Thursday 01 December 2005 19:12, Rusty Russell wrote:
> > > Meanwhile, as noone seems to use swbit in struct input_device_id,
> > > perhaps we can remove it for 2.6.15?
> > > 
> > 
> > Please take a look at drivers/input/keyboard/corgikbd.c
> > 
> 
> What I meant we do use EV_SW in the drivers and so it sould be part
> of input_device_id. Nobody uses ffbit or sndbit either and still
> they are present...

Sure.  BUT it will break current users.  I'm suggesting we jerk that
field out for 2.6.15, and reintroduce it for >= 2.6.16, when we can (1)
ensure everyone has a fixed module-init tools, or (2) make sure everyone
is using the module alias stuff, or both.

It seems the simplest solution, surely?
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

