Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422954AbWAMU7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422954AbWAMU7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWAMU7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:59:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20418 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422954AbWAMU7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:59:37 -0500
Date: Fri, 13 Jan 2006 21:59:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Message-ID: <20060113205927.GN1906@elf.ucw.cz>
References: <200601122241.07363.rjw@sisk.pl> <200601130031.34624.rjw@sisk.pl> <200601132053.43085.ioe-lkml@rameria.de> <200601132149.39159.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200601132149.39159.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 13-01-06 21:49:38, Rafael J. Wysocki wrote:
> On Friday, 13 January 2006 20:53, Ingo Oeser wrote:
> > On Friday 13 January 2006 00:31, Rafael J. Wysocki wrote:
> > > On Thursday, 12 January 2006 23:09, Pavel Machek wrote:
> > > > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argument
> > > > > +	should be a pointer to an unsigned int variable that will contain
> > > > > +	the result if the call is successful)
> > > > 
> > > > Is this good idea? It will overflow on 32-bit systems. Ammount of
> > > > available swap can be >4GB. [Or maybe it is in something else than
> > > > bytes, then you need to specify it.]
> > > 
> > > It returns the number of pages.  Well, it should be written explicitly,
> > > so I'll fix that.
> > 
> > Please always talk to the kernel in bytes. Pagesize is only a kernel
> > internal unit. Sth. like off64_t is fine.
> 
> These are values returned by the kernel, actually.  Of course I can convert them
> to bytes before sending to the user space, if that's preferrable.
> 
> Pavel, what do you think?

Bytes, I'd say. It would be nice if preffered image size was in bytes,
too, for consistency.
								Pavel 
-- 
Thanks, Sharp!
