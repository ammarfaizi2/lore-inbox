Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266142AbUGOIDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUGOIDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 04:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUGOIDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 04:03:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31738 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266142AbUGOIDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 04:03:03 -0400
Date: Thu, 15 Jul 2004 13:32:04 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040715080204.GC1312@obelix.in.ibm.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714085758.GA4165@obelix.in.ibm.com> <20040714170800.GC4636@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714170800.GC4636@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 10:08:00AM -0700, Greg KH wrote:
> > ...
> > Close, but not the same.  I just had a quick look at krefs.
> > Actually, this refrerence count infrastructure I am proposing is not for 
> > traditional refcounting.
> 
> But you are advertising it as such by calling it a refcount_t and
> putting it in a file called refcount.h.

The naming is bad, I agree. But as Dipankar pointed out earlier, there
was no kref when I did this.  We (Dipankar and myslef) had a discussion
and decided:
1. I will make a patch to shrink kref and feed it to Greg
2. Add new set kref api for lockfree refcounting --
	kref_lf_xxx.  (kref_lf_get, kref_lf_get_rcu etc.,)
3. Change the fd lookup patch to use kref_lf_xxx api

Does that sound ok?

Thanks,
Kiran
