Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWHCJlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWHCJlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 05:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWHCJlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 05:41:40 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:34713 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932443AbWHCJlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 05:41:39 -0400
Date: Thu, 3 Aug 2006 13:40:55 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take3 0/4] kevent: Generic event handling mechanism.
Message-ID: <20060803094055.GA19635@2ka.mipt.ru>
References: <20060731103322.GA1898@2ka.mipt.ru> <11545983592236@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <11545983592236@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 13:40:56 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 01:45:59PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> Changes from 'take2' patchset:
>  * split kevent_finish_user() to locked and unlocked variants
>  * do not use KEVENT_STAT ifdefs, use inline functions instead
>  * use array of callbacks of each type instead of each kevent callback initialization
>  * changed name of ukevent guarding lock
>  * use only one kevent lock in kevent_user for all hash buckets instead of per-bucket locks
>  * do not use kevent_user_ctl structure instead provide needed arguments as syscall parameters
>  * various indent cleanups
>  * mapped buffer (initial) implementation (no userspace yet)

Also added optimisation aimed to help when a lot of kevents are being
copied from userspace in one syscall.

-- 
	Evgeniy Polyakov
