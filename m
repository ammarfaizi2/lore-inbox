Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTCEVKi>; Wed, 5 Mar 2003 16:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264820AbTCEVKi>; Wed, 5 Mar 2003 16:10:38 -0500
Received: from ns.suse.de ([213.95.15.193]:46604 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264748AbTCEVKg>;
	Wed, 5 Mar 2003 16:10:36 -0500
Date: Wed, 5 Mar 2003 22:21:07 +0100
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
Message-ID: <20030305212107.GB7961@wotan.suse.de>
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6650D4.8060809@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 11:32:36AM -0800, Ulrich Drepper wrote:
> > If you just want to save one mmap/allocation: I think the context switch
> > overhead will be more expensive than the allocation.
> 
> And two more things:
> 
> 1. every process will already use the prctl(ARCH_SET_FS).  We are
> talking here only about the 2nd thread and later.  We need to use
> prctl(ARCH_SET_FS) for TLS support.

Not when you put it into the first four GB. Then you can use the same
calls as 32bit.

> 2. May I remind you that you were in the crowd who complained when we
> requested a dedicated thread register?  Yes, I still would prefer that
> but I have no energy to battle for that.

I don't see the connection.


-Andi
