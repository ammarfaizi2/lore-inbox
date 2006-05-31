Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWEaVBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWEaVBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWEaVBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:01:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964972AbWEaVBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:01:03 -0400
Date: Wed, 31 May 2006 14:01:00 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iWARP Connection Manager.
Message-ID: <20060531140100.36024296@localhost.localdomain>
In-Reply-To: <1149109080.7469.15.camel@stevo-desktop>
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	<20060531182652.3308.1244.stgit@stevo-desktop>
	<20060531114059.704ef1f1@localhost.localdomain>
	<ada3beqyp39.fsf@cisco.com>
	<1149109080.7469.15.camel@stevo-desktop>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 15:58:00 -0500
Steve Wise <swise@opengridcomputing.com> wrote:

> On Wed, 2006-05-31 at 12:24 -0700, Roland Dreier wrote:
> > > > +	cm_id_priv = kzalloc(sizeof *cm_id_priv, GFP_KERNEL);
> > 
> > > Please put paren's after sizeof, it is not required by C but it
> > > is easier to read.
> > 
> > I disagree -- I hate seeing sizeof look like a function call.
> > 
> 
> For the most part, drivers/infiniband/core uses sizeof without
> parentheses.  So I think the correct answer here is to keep the iwcm.c
> file in line with the rest of the core.
> 
> 

Make yours right, Bunk will "fix" infiniband core.  The kernel style
matters not the subsystem.  In Documentation/CodingStyle

		Chapter 13: Allocating memory

The kernel provides the following general purpose memory allocators:
kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
documentation for further information about them.

The preferred form for passing a size of a struct is the following:

	p = kmalloc(sizeof(*p), ...);

The alternative form where struct name is spelled out hurts readability and
introduces an opportunity for a bug when the pointer variable type is changed
but the corresponding sizeof that is passed to a memory allocator is not.

Casting the return value which is a void pointer is redundant. The
conversion from void pointer to any other pointer type is guaranteed by
the C programming language.
