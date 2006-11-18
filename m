Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755959AbWKREkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbWKREkL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 23:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755973AbWKREkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 23:40:11 -0500
Received: from main.gmane.org ([80.91.229.2]:61606 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1755959AbWKREkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 23:40:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: We're still coping with GCC < 3.0
Date: Sat, 18 Nov 2006 04:39:44 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelt421.dd3.olecom@flower.upol.cz>
References: <200611172228.58658.blaisorblade@yahoo.it>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo.

On 2006-11-17, someone with nick Blaisorblade wrote:
> In arch/i386/kernel/irq.c (current git head) I found this comment:
>
> /*
>  * These should really be __section__(".bss.page_aligned") as well, but
>  * gcc's 3.0 and earlier don't handle that correctly.
>  */
> static char softirq_stack[NR_CPUS * THREAD_SIZE]
>                 __attribute__((__aligned__(THREAD_SIZE)));
>
> static char hardirq_stack[NR_CPUS * THREAD_SIZE]
>                 __attribute__((__aligned__(THREAD_SIZE)));
>
> That should be fixed now that we require GCC 3.0, not?
>
> Btw, there are other such comments, like in include/asm-i386/semaphore.h: 
> sema_init (for GCC 2.7!). That one might not be the case to fix because of the 
> increased stack usage
>
> I've seen other similar tests around, so I thought that it'd be useful to 
> centralize all tests for GCC versions to headers like include/compiler.h so 
> they're promptly removed when deprecating old compilers.
>
> What about this?

Tested patches to Andrew Morton and code maintainers.
See also:
<http://marc.theaimsgroup.com/?l=linux-kernel&m=116315825009126&w=2>

-- e-mail --
> (CC me on replies as I'm not subscribed)
Cc yourself, isn't this smart idea?
Also, please, honor "Mail-Followup-To" headers and the like.
____

