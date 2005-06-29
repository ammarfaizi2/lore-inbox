Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVF2Qct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVF2Qct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVF2Qct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:32:49 -0400
Received: from kalmia.hozed.org ([209.234.73.41]:53644 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S261583AbVF2Qc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:32:27 -0400
Date: Wed, 29 Jun 2005 11:32:25 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Greg KH <greg@kroah.com>
Cc: Roland Dreier <rolandd@cisco.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 05/16] IB uverbs: core implementation
Message-ID: <20050629163225.GP4907@kalmia.hozed.org>
References: <2005628163.lUk0bfpO8VsSXUh5@cisco.com> <2005628163.jfSiMqRcI78iLMJP@cisco.com> <20050629002709.GB17805@kroah.com> <20050629041321.GM4907@kalmia.hozed.org> <20050629161209.GA23781@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20050629161209.GA23781@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 09:12:09AM -0700, Greg KH wrote:
> On Tue, Jun 28, 2005 at 11:13:22PM -0500, Troy Benjegerdes wrote:
> > On Tue, Jun 28, 2005 at 05:27:09PM -0700, Greg KH wrote:
> > > On Tue, Jun 28, 2005 at 04:03:43PM -0700, Roland Dreier wrote:
> > > > +++ linux/drivers/infiniband/core/uverbs_main.c	2005-06-28 15:20:04.363963991 -0700
> > > > @@ -0,0 +1,708 @@
> > > > +/*
> > > > + * Copyright (c) 2005 Topspin Communications.  All rights reserved.
> > > > + * Copyright (c) 2005 Cisco Systems.  All rights reserved.
> > > > + *
> > > > + * This software is available to you under a choice of one of two
> > > > + * licenses.  You may choose to be licensed under the terms of the GNU
> > > > + * General Public License (GPL) Version 2, available from the file
> > > > + * COPYING in the main directory of this source tree, or the
> > > > + * OpenIB.org BSD license below:
> > > 
> > > Ok, I've complained about this before, but due to the fact that you are
> > > calling EXPORT_SYMBOL_GPL() only functions in this code, the ability for
> > > it for someone to use the BSD license on it in the future, is pretty
> > > much impossible, right?
> > 
> > Only if someone tries to use it under a BSD license, strips off the GPL
> > notices, and then builds it against *Linux*.
> 
> Exactly, that's my point.  It's pretty useless, and if you are going to
> build this code for another OS, well, that's going to be a tough job :)
> 
> > If linux-kernel is going to be that fascist about licensing, let's
> > please clean up all the binary firmware blobs in header files first.
> 
> I'm not being "fascist", I'm just saying it's pretty pointless to try to
> dual license this code, that's all.

Ahh.. I think the point of the dual-license is that there is a lot of
non linux-specific Infiniband code that will (hopefully) be usefull on
other platforms where a BSD license might be more usefull. If for some
reason I decided I wanted to run MacOSX, I would at least want to be
running the OpenIB infiniband stack, and not some proprietary module.

Does anyone have some nice scripts to audit for useage of
EXPORT_SYMBOL_GPL only functions? Maybe it's worth trying to clean up
the code to clearly deliniate what depends on GPL functions and what
doesn't.
