Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317680AbSGZMGD>; Fri, 26 Jul 2002 08:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317681AbSGZMGD>; Fri, 26 Jul 2002 08:06:03 -0400
Received: from reload.namesys.com ([212.16.7.75]:54942 "EHLO
	reload.namesys.com") by vger.kernel.org with ESMTP
	id <S317680AbSGZMGD>; Fri, 26 Jul 2002 08:06:03 -0400
Date: Fri, 26 Jul 2002 16:09:18 +0400
From: Joshua MacDonald <jmacd@namesys.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.28
Message-ID: <20020726120918.GA22049@reload.namesys.com>
Mail-Followup-To: Jesse Barnes <jbarnes@sgi.com>,
	linux-kernel@vger.kernel.org
References: <20020725233047.GA782991@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725233047.GA782991@sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 04:30:47PM -0700, Jesse Barnes wrote:
> Here's the lastest version of the lockassert patch.  It includes:
>   o MUST_HOLD for all architectures
>   o MUST_HOLD_RW for architectures implementing rwlock_is_locked (only
>     ia64 at the moment, as part of this patch)
>   o MUST_HOLD_RWSEM for arcitectures that use rwsem-spinlock.h
>   o MUST_HOLD_SEM for ia64
>   o a call to MUST_HOLD(&inode_lock) in inode.c:__iget().
> 
> I'd be happy to take patches that implement the above routines for
> other architectures and/or patches that sprinkle the macros where
> they're needed.
> 
> Thanks,
> Jesse
> 

Jesse,

In reiser4 we are looking forward to having a MUST_NOT_HOLD (i.e.,
spin_is_not_locked) assertion for kernel spinlocks.  Do you know if any
progress has been made in that direction?

We have implemented a user-level testing framework for our file system and we
are already using a spin_is_not_locked() method, but these assertions are
disabled when compiled into the kernel.

-josh
