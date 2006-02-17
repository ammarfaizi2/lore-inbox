Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWBQPrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWBQPrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWBQPrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:47:36 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:9205 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751438AbWBQPrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:47:36 -0500
Subject: Re: Robust futexes
From: Daniel Walker <dwalker@mvista.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1140152271.25078.42.camel@localhost.localdomain>
References: <1140152271.25078.42.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 07:47:34 -0800
Message-Id: <1140191254.3492.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 15:57 +1100, Rusty Russell wrote:
> Hi Ingo, all,
> 
> 	Noticed (via LWN, hence the delay) your robust futex work.  Have you
> considered the less-perfect, but simpler option of simply having futex
> calls which tell the kernel that the u32 value is in fact the holder's
> TID?
> 
> 	In this case, you don't get perfect robustness when TID wrap occurs:
> the kernel won't know that the lock holder is dead.  However, it's
> simple, and telling the kernel that the lock is the tid allows the
> kernel to do prio inheritence etc. in future.

	I think this was Todd Kneisel's approach . His version was vma
scanning, which is what Ingo is trying to replace. It just used the
current u32 value .

Daniel

