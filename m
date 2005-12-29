Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVL2CkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVL2CkY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 21:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVL2CkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 21:40:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7319 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964972AbVL2CkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 21:40:23 -0500
Date: Wed, 28 Dec 2005 21:39:06 -0500
From: Dave Jones <davej@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Message-ID: <20051229023906.GC3286@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Keith Owens <kaos@ocs.com.au>, Matt Mackall <mpm@selenic.com>,
	linux-kernel@vger.kernel.org
References: <20051229012915.GB3286@redhat.com> <23471.1135821010@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23471.1135821010@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 12:50:10PM +1100, Keith Owens wrote:
 > Dave Jones (on Wed, 28 Dec 2005 20:29:15 -0500) wrote:
 > >
 > > > Something like this:
 > > > 
 > > > http://lwn.net/Articles/124374/
 > >
 > >One thing that really sticks out like a sore thumb is soft_cursor()
 > >That thing gets called a *lot*, and every time it does a kmalloc/free
 > >pair that 99.9% of the time is going to be the same size alloc as
 > >it was the last time.  This patch makes that alloc persistent
 > >(and does a realloc if the size changes).
 > >The only time it should change is if the font/resolution changes I think.
 > 
 > Can soft_cursor() be called from multiple processes at the same time,
 > in particular with dual head systems?  If so then a static variable is
 > not going to work.

My dual-head system here displays a cloned image on the second
screen, which seems to dtrt.  I'm not sure how to make it show
something different on the other head to test further.

		Dave

