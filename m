Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVFPOVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVFPOVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 10:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVFPOVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 10:21:20 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:55688 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261643AbVFPOVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 10:21:17 -0400
Message-ID: <42B18CE8.8B75F3AB@tv-sign.ru>
Date: Thu, 16 Jun 2005 18:30:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [BUG] Race condition with it_real_fn inkernel/itimer.c
References: <42B067BD.F4526CD@tv-sign.ru>
		 <1118860623.4508.70.camel@localhost.localdomain>
		 <1118864043.4508.81.camel@localhost.localdomain>
		 <42B12DD6.7028CBAE@tv-sign.ru> <1118921624.4512.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> 
> Andrew, (or Roland since I see Andrew added you to the list)
> 
>  What do you think? Should try_to_del_timer_sync be brought over to the
> mainline, or have the above ugly code added?

On the other hand, if 2 threads calls do_setitimer() in parallel
they are asking for trouble. So may be it is possible to ignore
this minor problem and stay with your patch?

Oleg.
