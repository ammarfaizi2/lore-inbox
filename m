Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSGZFNX>; Fri, 26 Jul 2002 01:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGZFNX>; Fri, 26 Jul 2002 01:13:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:11270 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316840AbSGZFNW>; Fri, 26 Jul 2002 01:13:22 -0400
Message-ID: <3D40DA00.9080603@evision.ag>
Date: Fri, 26 Jul 2002 07:11:28 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lock assertion macros for 2.5.28
References: <20020725233047.GA782991@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
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

Well one one place? Every single implementation of the request_fn
method from the request_queue_t needs to hold some
lock associated with the queue in question.

In fact you will find ASSERT_LOCK macros sparnkled through the scsi code 
already right now. BTW> ASSERT_HOLDS would sound a bit more
familiar to some of us.

This minor issue asside I think that your idea is a good thing.


