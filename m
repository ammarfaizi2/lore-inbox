Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422944AbWAMUsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422944AbWAMUsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWAMUsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:48:04 -0500
Received: from h144-158.u.wavenet.pl ([217.79.144.158]:37762 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1422944AbWAMUsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:48:02 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Fri, 13 Jan 2006 21:49:38 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Linux PM <linux-pm@osdl.org>
References: <200601122241.07363.rjw@sisk.pl> <200601130031.34624.rjw@sisk.pl> <200601132053.43085.ioe-lkml@rameria.de>
In-Reply-To: <200601132053.43085.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601132149.39159.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 13 January 2006 20:53, Ingo Oeser wrote:
> On Friday 13 January 2006 00:31, Rafael J. Wysocki wrote:
> > On Thursday, 12 January 2006 23:09, Pavel Machek wrote:
> > > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argument
> > > > +	should be a pointer to an unsigned int variable that will contain
> > > > +	the result if the call is successful)
> > > 
> > > Is this good idea? It will overflow on 32-bit systems. Ammount of
> > > available swap can be >4GB. [Or maybe it is in something else than
> > > bytes, then you need to specify it.]
> > 
> > It returns the number of pages.  Well, it should be written explicitly,
> > so I'll fix that.
> 
> Please always talk to the kernel in bytes. Pagesize is only a kernel
> internal unit. Sth. like off64_t is fine.

These are values returned by the kernel, actually.  Of course I can convert them
to bytes before sending to the user space, if that's preferrable.

Pavel, what do you think?

Rafael
