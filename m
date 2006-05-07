Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWEGQDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWEGQDy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 12:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWEGQDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 12:03:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:6054 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932176AbWEGQDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 12:03:53 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: sched_clock() uses are broken
Date: Sun, 7 May 2006 18:03:28 +0200
User-Agent: KMail/1.9.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Mike Galbraith <efault@gmx.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
References: <44578EB9.8050402@nortel.com> <20060507135540.GD20443@flint.arm.linux.org.uk> <445DFE72.4080801@yahoo.com.au>
In-Reply-To: <445DFE72.4080801@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071803.28983.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 16:04, Nick Piggin wrote:
> Russell King wrote:
> 
> > Also, any comments on update_cpu_clock() and current_sched_time() both
> > appearing to be buggy, or am I barking up the wrong tree with those?
> 
> Can't remember off the top of my head who put those in, sorry.
> 
> Aside from the fact that they appear to be fundamentally buggy anyway
> because we don't require exact ns intervals from sched_clock() at the
> best of times, I think your wrapping fix for them looks correct.

I must say I always hated them because adding code to the context
switch for such an obscure POSIX bu^w"feature" is just a bad idea.
Maybe it would be best to remove it again instead of adding the 
scaling needed to make it actually work

(since we got along with such a broken implementation for so long I 
would guess that nobody uses these timers anyways) 

-Andi

