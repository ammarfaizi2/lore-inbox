Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbULOAa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbULOAa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbULOA21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:28:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:53418 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261782AbULOATc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:19:32 -0500
Date: Tue, 14 Dec 2004 16:19:12 -0800
From: Greg KH <greg@kroah.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041215001912.GA15575@kroah.com>
References: <20041214164548.GA18817@kroah.com> <Pine.LNX.4.44.0412142304160.11826-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0412142304160.11826-100000@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 11:26:48PM +0000, Hugh Dickins wrote:
> One case that's easy to explain: if it was preceded (perhaps hours
> earlier) by a "Bad page state" message and stacktrace, referring to
> the same page (in ecx, edx, ebp in your dump), which showed non-zero
> mapcount, then this is an after-effect of bad_page resetting mapcount.
> And the real problem was probably a double free, which bad_page noted,
> but carried on regardless.  Worth checking your logs for, let us know,
> but there have been several reports where that's definitely not so.

Nope, nothing like that in my logs, sorry.

> I presume this was just a one-off?  If you can repeat it from time to
> time, I'll try to devise some printk'ing to shed more light.

I'll try to see if I can reproduce it.  If so, I'll let you know.

thanks,

greg k-h
