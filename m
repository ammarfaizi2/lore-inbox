Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVE1Q0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVE1Q0D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 12:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVE1Q0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 12:26:03 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:6550 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261164AbVE1QZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 12:25:57 -0400
Message-ID: <42989D7A.8E947760@tv-sign.ru>
Date: Sat, 28 May 2005 20:34:02 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john cooper <john.cooper@timesys.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Olaf Kirch <okir@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: RT and Cascade interrupts
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com> <42983135.C521F1C8@tv-sign.ru> <429879FD.30002@timesys.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john cooper wrote:
>
> Oleg Nesterov wrote:
>
> > If you need to ensure that timer's handler is not running on any
> > cpu then timer_pending() can't help. If you don't need this, you
> > should use plain del_timer().
>
> That's not the goal of the timer_pending() usage here.
> Rather we're at a point in rpc_release_task where we
> want to tear down an rpc_task.  The call to timer_pending()
> determines if the embedded timer is still linked in the
> timer cascade structure.

Yes, I see what you are trying to fix. However, your fix
opens even worse bug.

> If anyone with more ownership of the RPC code would like
> to comment, any insight would be most welcome.

Yes. Trond, could you please look at this thread:
http://marc.theaimsgroup.com/?t=111590936700001 and put an
end to our discussion?

Oleg.
