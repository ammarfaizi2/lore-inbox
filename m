Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWBWL5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWBWL5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 06:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWBWL5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 06:57:52 -0500
Received: from mx1.suse.de ([195.135.220.2]:7071 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750749AbWBWL5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 06:57:52 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [Patch 2/3] fast VMA recycling
Date: Thu, 23 Feb 2006 12:57:46 +0100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <200602231200.42990.ak@suse.de> <43FD9AEF.1040204@linux.intel.com>
In-Reply-To: <43FD9AEF.1040204@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231257.47194.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 12:22, Arjan van de Ven wrote:
> Andi Kleen wrote:
> >> see voluntary preempt.
> > 
> > Only when its time slice is used up 
> 
> or if some other thread gets a higher dynamic prio
> > but then it would sleep a bit later 
> > in user space. 
> 
> ... but that is without the semaphore held! (and that is the entire 
> point of this patch, move the sleep moments to outside the lock holding 
> area as much as possible, to reduce lock hold times)

And you verified this happens often in your workload?

Anyways, how about adding a down_no_preempt() or similar instead
that won't voluntarily preempt?

-Andi
