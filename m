Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUGPOht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUGPOht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 10:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUGPOht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 10:37:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:20637 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266485AbUGPOhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 10:37:47 -0400
Date: Fri, 16 Jul 2004 07:32:35 -0700
From: Greg KH <greg@kroah.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040716143235.GC8282@kroah.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714085758.GA4165@obelix.in.ibm.com> <20040714170800.GC4636@kroah.com> <20040715080204.GC1312@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715080204.GC1312@obelix.in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 01:32:04PM +0530, Ravikiran G Thirumalai wrote:
> The naming is bad, I agree. But as Dipankar pointed out earlier, there
> was no kref when I did this.

No offence meant, but lib/kref.c has been in the kernel tree since
2.6.5-rc1 which was released 4 months ago.  Did refcount.h take 4 months
to get released?  :)

> We (Dipankar and myslef) had a discussion
> and decided:
> 1. I will make a patch to shrink kref and feed it to Greg
> 2. Add new set kref api for lockfree refcounting --
> 	kref_lf_xxx.  (kref_lf_get, kref_lf_get_rcu etc.,)

kref_*_rcu() as Dipankar noted is much nicer.

thanks,

greg k-h
