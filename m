Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTEQCV1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 22:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTEQCV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 22:21:27 -0400
Received: from dp.samba.org ([66.70.73.150]:57522 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261166AbTEQCV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 22:21:26 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       davidm@hpl.hp.com, rth@twiddle.net
Subject: Re: [PATCH] Unlimited per-cpu allocation 
In-reply-to: Your message of "Thu, 15 May 2003 22:42:32 MST."
             <20030515.224232.63031915.davem@redhat.com> 
Date: Sat, 17 May 2003 11:58:55 +1000
Message-Id: <20030517023420.7FCE42C04F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030515.224232.63031915.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Fri, 16 May 2003 15:30:36 +1000
> 
>    D: This patch allows an unlimited number of per-cpu allocations.
> 
> Except, of course, on IA64.  Maybe I missed the end of some thread,
> but I thought we had all agreed that this kind of limitation was
> a showstopper.

Not breaking IA64 is nice, but it's not an inherent "IA64 can't do it"
thing.

IA64 could just use the generic mechanism, like everyone else.  But
they do the tricky 64k mapping thing.  As I pointed out, maybe their
decision would have to be rethought if that proves inadaquate.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
