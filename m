Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVBKRgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVBKRgS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVBKRe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:34:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:38379 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262300AbVBKRb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:31:27 -0500
Date: Fri, 11 Feb 2005 09:31:18 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Al Borchers <alborchers@steinerpoint.com>
Cc: david-b@pacbell.net, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] add wait_event_*_lock() functions
Message-ID: <20050211173118.GA2372@us.ibm.com>
References: <1108105628.420c599cf3558@my.visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108105628.420c599cf3558@my.visi.com>
X-Operating-System: Linux 2.6.11-rc3 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 01:07:08AM -0600, Al Borchers wrote:
> 
> 
> On Thursday 10 February 2005 9:39 am, Nishanth Aravamudan wrote:
> >> It came up on IRC that the wait_cond*() functions from
> >> usb/serial/gadget.c could be useful in other parts of the kernel. Does
> >> the following patch make sense towards this?
> 
> Sure, if people want to use these.
> 
> I did not push them because they seemed a bit "heavy weight",
> but the construct is useful and general.

I think that is very much the case. As I was setting up patches for the
Kernel-Janitors to clean up the wait-queue usage in the kernel, I found
I was unable to use wait_event*(), as locks needed to be
released/grabbed around the sleep. wait_event_*_lock() fixes this
problem, clearly :)

> The docs should explain that the purpose is to wait atomically on
> a complex condition, and that the usage pattern is to hold the
> lock when using the wait_event_* functions or when changing any
> variable that might affect the condition and waking up the waiting
> processes.

I will submit a new patch which documents the general structure of the
wait_event_*() class of functions, including what you have written.

Thanks,
Nish
