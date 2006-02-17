Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWBQOMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWBQOMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWBQOML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:12:11 -0500
Received: from cabal.ca ([134.117.69.58]:59840 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1751411AbWBQOMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:12:10 -0500
Date: Fri, 17 Feb 2006 09:11:08 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kyle McMartin <kyle@parisc-linux.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Generic is_compat_task helper
Message-ID: <20060217141108.GO13492@quicksilver.road.mcmartin.ca>
References: <20060217025242.GM13492@quicksilver.road.mcmartin.ca> <20060216214939.78aebcbb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216214939.78aebcbb.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 09:49:39PM -0800, Andrew Morton wrote:
> > +static inline int __is_compat_task(struct task_struct *t)
> > +{
> > +	return (personality(t->personality) == PER_LINUX32);
> > +}
> > +
> 
> What continues to bug me about this (in a high-level hand-wavy sort of way)
> is that this is an attribute of the mm_struct, not of the task_struct.
>

I'm not sure I agree, I can't find any real defined use for PER_LINUX32,
as opposed to PER_LINUX_32BIT, which is | ADDR_LIMIT_32BIT. That said,
I'm not opposed to moving parisc to use TIF_32BIT, in fact, I had this
in mind when I give the entrypoints a crapectomy.

Cheers,
	Kyle
