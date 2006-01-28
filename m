Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWA1Sth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWA1Sth (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWA1Sth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:49:37 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:65222 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932533AbWA1Sth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:49:37 -0500
Date: Sun, 29 Jan 2006 00:19:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu_process_callbacks: don't cli() while testing ->nxtlist
Message-ID: <20060128184904.GF5633@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <43DBBFA9.8D5E231A@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DBBFA9.8D5E231A@tv-sign.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 10:02:01PM +0300, Oleg Nesterov wrote:
> __rcu_process_callbacks() disables interrupts to protect itself
> from call_rcu() which adds new entries to ->nxtlist.
> 
> However we can check "->nxtlist != NULL" with interrupts enabled,
> we can't get "false positives" because call_rcu() can only change
> this condition from 0 to 1.
> 
> Tested with rcutorture.ko.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Looks good to me.

Thanks
Dipankar
