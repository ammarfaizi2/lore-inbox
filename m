Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVL2BuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVL2BuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 20:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVL2BuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 20:50:19 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:65219 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S964954AbVL2BuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 20:50:18 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@redhat.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ? 
In-reply-to: Your message of "Wed, 28 Dec 2005 20:29:15 CDT."
             <20051229012915.GB3286@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Dec 2005 12:50:10 +1100
Message-ID: <23471.1135821010@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones (on Wed, 28 Dec 2005 20:29:15 -0500) wrote:
>
> > Something like this:
> > 
> > http://lwn.net/Articles/124374/
>
>One thing that really sticks out like a sore thumb is soft_cursor()
>That thing gets called a *lot*, and every time it does a kmalloc/free
>pair that 99.9% of the time is going to be the same size alloc as
>it was the last time.  This patch makes that alloc persistent
>(and does a realloc if the size changes).
>The only time it should change is if the font/resolution changes I think.

Can soft_cursor() be called from multiple processes at the same time,
in particular with dual head systems?  If so then a static variable is
not going to work.

