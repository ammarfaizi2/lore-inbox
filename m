Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284744AbRLEV3Q>; Wed, 5 Dec 2001 16:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284745AbRLEV3H>; Wed, 5 Dec 2001 16:29:07 -0500
Received: from [202.135.142.196] ([202.135.142.196]:9484 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S284744AbRLEV3B>; Wed, 5 Dec 2001 16:29:01 -0500
Date: Thu, 6 Dec 2001 08:29:49 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] scalable timers implementation, 2.4.16, 2.5.0
Message-Id: <20011206082949.400dffd5.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0111271543410.16419-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0111271543410.16419-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 15:57:03 +0100 (CET)
Ingo Molnar <mingo@elte.hu> wrote:

> 
> the 'ultra scalable timers' patch, against 2.4.16 or 2.5.0 is available
> at:
> 
>   http://redhat.com/~mingo/scalable-timers-patches/smptimers-2.4.16-A0

Hi Ingo,

	Hmm... there are some ugly hoops there to make sure that they don't
conflict with bottom halves or cli().  I assume you want to take that out:
what will break if that happens, and do we need a disable_timers() interface
to move code over?

Cheers,
Rusty.
PS.  Also would be nice to #define del_timer del_timer_sync, and have a
     del_timer_async for those (very few) cases who really want this.
--
  Anyone who quotes me is an idiot -- Rusty Russell.
