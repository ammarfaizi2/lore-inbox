Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbTA2HVq>; Wed, 29 Jan 2003 02:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTA2HVp>; Wed, 29 Jan 2003 02:21:45 -0500
Received: from dp.samba.org ([66.70.73.150]:61600 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265077AbTA2HVp>;
	Wed, 29 Jan 2003 02:21:45 -0500
Date: Wed, 29 Jan 2003 18:26:22 +1100
From: Anton Blanchard <anton@samba.org>
To: Stephen Hemminger <shemminger@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (1/4) 2.5.59 fast reader/writer lock for gettimeofday
Message-ID: <20030129072622.GA18250@krispykreme>
References: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net> <20030128230639.A17385@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128230639.A17385@twiddle.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> These need to be mb(), not wmb(), if you want the bits in between
> to actually happen in between, as with your xtime example.  At
> present there's nothing stoping xtime from being *read* before
> your read from pre_sequence happens.

But with frlocks we synchronise writers with a spinlock, so shouldnt it
provide that synchronisation?

Anton
