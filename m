Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVF2EN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVF2EN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 00:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVF2EN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 00:13:28 -0400
Received: from kalmia.hozed.org ([209.234.73.41]:23689 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S262227AbVF2ENX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 00:13:23 -0400
Date: Tue, 28 Jun 2005 23:13:22 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Greg KH <greg@kroah.com>
Cc: Roland Dreier <rolandd@cisco.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 05/16] IB uverbs: core implementation
Message-ID: <20050629041321.GM4907@kalmia.hozed.org>
References: <2005628163.lUk0bfpO8VsSXUh5@cisco.com> <2005628163.jfSiMqRcI78iLMJP@cisco.com> <20050629002709.GB17805@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20050629002709.GB17805@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 05:27:09PM -0700, Greg KH wrote:
> On Tue, Jun 28, 2005 at 04:03:43PM -0700, Roland Dreier wrote:
> > +++ linux/drivers/infiniband/core/uverbs_main.c	2005-06-28 15:20:04.363963991 -0700
> > @@ -0,0 +1,708 @@
> > +/*
> > + * Copyright (c) 2005 Topspin Communications.  All rights reserved.
> > + * Copyright (c) 2005 Cisco Systems.  All rights reserved.
> > + *
> > + * This software is available to you under a choice of one of two
> > + * licenses.  You may choose to be licensed under the terms of the GNU
> > + * General Public License (GPL) Version 2, available from the file
> > + * COPYING in the main directory of this source tree, or the
> > + * OpenIB.org BSD license below:
> 
> Ok, I've complained about this before, but due to the fact that you are
> calling EXPORT_SYMBOL_GPL() only functions in this code, the ability for
> it for someone to use the BSD license on it in the future, is pretty
> much impossible, right?

Only if someone tries to use it under a BSD license, strips off the GPL
notices, and then builds it against *Linux*. If linux-kernel is going to
be that fascist about licensing, let's please clean up all the binary
firmware blobs in header files first.

It seems reasonable to me that distribution and modification of the
*source code* can be under either license. But as soon as you build a
binary agaist the linux kernel, the binary is irrevocably GPL licensed.

--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@hozed.org  

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shultz
