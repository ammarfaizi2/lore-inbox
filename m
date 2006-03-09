Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbWCJBk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWCJBk7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWCJBk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:40:59 -0500
Received: from ozlabs.org ([203.10.76.45]:27777 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751191AbWCJBk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:40:58 -0500
Subject: Re: Robust futexes
From: Rusty Russell <rusty@rustcorp.com.au>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43F5F87E.4030307@us.ibm.com>
References: <1140152271.25078.42.camel@localhost.localdomain>
	 <43F5F87E.4030307@us.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 10:17:48 +1100
Message-Id: <1141946268.12863.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 08:23 -0800, Darren Hart wrote:
> Rusty Russell wrote:
> telling the kernel that the lock is the tid allows the
> > kernel to do prio inheritence etc. in future.
> 
> Priority Inheritance has come up a couple of times in relation to Ingo's new 
> LightWeight Robust Futexes.  Ingo has said that PI is orthogonal to LWRF, but I 
> don't think we've heard if there are plans already in the works (or in his head 
> :-) for PI.  Rusty's comment above reads as "the current LWRF implementation 
> cannot support PI" - is there something about it that makes PI impractical to 
> implement?

Hi Darren!

	Ingo's approach is indeed orthogonal.  But the obvious approach to PI
etc is to tell the kernel who is holding the lock, by making the lock
value == TID of the holder.  If we are heading towards this anyway, the
kernel could use this to implement robust mutexes, too, although not
with a 100% guarantee (due to tid wrap).  Ingo doesn't like that,
though.

Hope that clarifies!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

