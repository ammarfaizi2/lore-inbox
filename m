Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUE2DN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUE2DN6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 23:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUE2DN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 23:13:58 -0400
Received: from ozlabs.org ([203.10.76.45]:43245 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262772AbUE2DN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 23:13:56 -0400
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jakub Jelinek <jakub@redhat.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040520093817.GX30909@devserv.devel.redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1085635370.9356.13.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 29 May 2004 13:13:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-20 at 19:38, Jakub Jelinek wrote:
> Hi!
> 
> FUTEX_REQUEUE operation has been added to the kernel mainly to improve
> pthread_cond_broadcast which previously used FUTEX_WAKE INT_MAX op.

For the record, I wasn't happy about adding FUTEX_REQUEUE to optimize
for suboptimal apps using the horrid pthreads interface, but I
understand the benchmarking realities.

I'm certainly way less than thrilled to discover that it doesn't work,
and we need to implement FUTEX_CMP_REQUEUE, and of course can't get rid
of FUTEX_REQUEUE.

The base futex concept and interface is simple (although the
implementation w/ the Linux mm subsystem proved interesting in the
corner cases); it's increasingly becoming a horror with these kind of
hacks.

8(
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

