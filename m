Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVCRCKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVCRCKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 21:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVCRCKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 21:10:18 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6361 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261372AbVCRCKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 21:10:00 -0500
Date: Thu, 17 Mar 2005 18:09:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Jason Uhlenkott <jasonuhl@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, holt@sgi.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8 + free_hot_zeroed_page + free_cold_zeroed
 page
In-Reply-To: <20050318020645.GC156968@dragonfly.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0503171808540.11258@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <20050317140831.414b73bb.akpm@osdl.org> <Pine.LNX.4.58.0503171459310.10205@schroedinger.engr.sgi.com>
 <20050318020645.GC156968@dragonfly.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Jason Uhlenkott wrote:

> On Thu, Mar 17, 2005 at 05:36:50PM -0800, Christoph Lameter wrote:
> > +        while (avenrun[0] >= ((unsigned long)sysctl_scrub_load << FSHIFT)) {
> > +		set_current_state(TASK_UNINTERRUPTIBLE);
> > +		schedule_timeout(30*HZ);
> > +	}
>
> This should probably be TASK_INTERRUPTIBLE.  It'll never actually get
> interrupted either way since kernel threads block all signals, but
> sleeping uninterruptibly contributes to the load average.

Correct. .... I just do not seem to be able to get this right.

