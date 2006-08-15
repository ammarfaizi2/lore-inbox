Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965362AbWHOKWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965362AbWHOKWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965364AbWHOKWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:22:17 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:28855 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S965362AbWHOKWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:22:17 -0400
Date: Tue, 15 Aug 2006 18:46:06 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Esben Nielsen <nielsen.esben@gogglemail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup and remove some extra spinlocks from rtmutex
Message-ID: <20060815144606.GA239@oleg>
References: <1154439588.25445.31.camel@localhost.localdomain> <20060813190326.GA2276@oleg> <Pine.LNX.4.64.0608142217400.10597@frodo.shire> <20060815110353.GA111@oleg> <Pine.LNX.4.64.0608151152110.10351@frodo.shire> <20060815142605.GA232@oleg> <Pine.LNX.4.64.0608151204400.10351@frodo.shire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608151204400.10351@frodo.shire>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, Esben Nielsen wrote:
> 
> On Tue, 15 Aug 2006, Oleg Nesterov wrote:
> >
> >Sure, this needs a comment.
> 
> It is even better if you can read the code without a comment. Good code 
> doesn't need comments.

Yes. But from my point of view, the current code needs a comment to explain
why do we take ->pi_lock, this is hard to understand at least to me.

It is even better if we don't take ->pi_lock for ->wait_list manipulation.

Imho.

Oleg.

