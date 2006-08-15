Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965344AbWHOKCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965344AbWHOKCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965348AbWHOKCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:02:16 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:64433 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S965344AbWHOKCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:02:15 -0400
Date: Tue, 15 Aug 2006 18:26:05 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Esben Nielsen <nielsen.esben@gogglemail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup and remove some extra spinlocks from rtmutex
Message-ID: <20060815142605.GA232@oleg>
References: <1154439588.25445.31.camel@localhost.localdomain> <20060813190326.GA2276@oleg> <Pine.LNX.4.64.0608142217400.10597@frodo.shire> <20060815110353.GA111@oleg> <Pine.LNX.4.64.0608151152110.10351@frodo.shire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608151152110.10351@frodo.shire>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, Esben Nielsen wrote:
>
> On Tue, 15 Aug 2006, Oleg Nesterov wrote:
> >
> >task->pi_blocked_on != NULL, we hold task->pi_blocked_on->lock->wait_lock.
> >Can it go away ?
> 
> That is correct. But does it make the code more readable?

Well, in my opinion - yes. But yes, it's only my personal feeling :)

>                                                            When you read 
> the code you shouldn't need to go into that kind of complicated arguments 
> to see the correctness - unless the code can't be written otherwise.

Sure, this needs a comment.

Thanks again,

Oleg.

