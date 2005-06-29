Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVF2QS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVF2QS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVF2QPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:15:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:57553 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262506AbVF2QMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:12:45 -0400
Date: Wed, 29 Jun 2005 09:12:09 -0700
From: Greg KH <greg@kroah.com>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: Roland Dreier <rolandd@cisco.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 05/16] IB uverbs: core implementation
Message-ID: <20050629161209.GA23781@kroah.com>
References: <2005628163.lUk0bfpO8VsSXUh5@cisco.com> <2005628163.jfSiMqRcI78iLMJP@cisco.com> <20050629002709.GB17805@kroah.com> <20050629041321.GM4907@kalmia.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629041321.GM4907@kalmia.hozed.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 11:13:22PM -0500, Troy Benjegerdes wrote:
> On Tue, Jun 28, 2005 at 05:27:09PM -0700, Greg KH wrote:
> > On Tue, Jun 28, 2005 at 04:03:43PM -0700, Roland Dreier wrote:
> > > +++ linux/drivers/infiniband/core/uverbs_main.c	2005-06-28 15:20:04.363963991 -0700
> > > @@ -0,0 +1,708 @@
> > > +/*
> > > + * Copyright (c) 2005 Topspin Communications.  All rights reserved.
> > > + * Copyright (c) 2005 Cisco Systems.  All rights reserved.
> > > + *
> > > + * This software is available to you under a choice of one of two
> > > + * licenses.  You may choose to be licensed under the terms of the GNU
> > > + * General Public License (GPL) Version 2, available from the file
> > > + * COPYING in the main directory of this source tree, or the
> > > + * OpenIB.org BSD license below:
> > 
> > Ok, I've complained about this before, but due to the fact that you are
> > calling EXPORT_SYMBOL_GPL() only functions in this code, the ability for
> > it for someone to use the BSD license on it in the future, is pretty
> > much impossible, right?
> 
> Only if someone tries to use it under a BSD license, strips off the GPL
> notices, and then builds it against *Linux*.

Exactly, that's my point.  It's pretty useless, and if you are going to
build this code for another OS, well, that's going to be a tough job :)

> If linux-kernel is going to be that fascist about licensing, let's
> please clean up all the binary firmware blobs in header files first.

I'm not being "fascist", I'm just saying it's pretty pointless to try to
dual license this code, that's all.

thanks,

greg k-h
