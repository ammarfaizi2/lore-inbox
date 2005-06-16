Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFPIyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFPIyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 04:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFPIyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 04:54:20 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:28373 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261207AbVFPIyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 04:54:17 -0400
Message-ID: <42B14044.FC2F5432@tv-sign.ru>
Date: Thu, 16 Jun 2005 13:03:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] Race condition with it_real_fn in kernel/itimer.c
References: <42B067BD.F4526CD@tv-sign.ru> <1118860623.4508.70.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> 
> On Wed, 2005-06-15 at 21:39 +0400, Oleg Nesterov wrote:
> >
> > I think we don't need del_timer_sync() at all, just del_timer().
> >
> [...]
>
> it_real_arm unprotected! And you can see here that it_real_arm is also
> called and they both call add_timer! This would not work, so far the
> first patch seems to handle this.

Yes, you are right, thanks.

> PS. Don't strip the CC list.

I am sorry. It's because I am not subscribed to lkml, I saw your message
on http://marc.theaimsgroup.com/. You might know is there an lkml archive
which does not hide recipients list (or in mbox format) ?

Oleg.
