Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWD0AF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWD0AF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 20:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWD0AF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 20:05:26 -0400
Received: from t3inc.us ([66.250.45.69]:129 "EHLO www.t3inc.us")
	by vger.kernel.org with ESMTP id S1751303AbWD0AFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 20:05:25 -0400
Date: Wed, 26 Apr 2006 18:05:20 -0600
From: kyle@pbx.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Heikki Orsila <shd@zakalwe.fi>, Willy Tarreau <willy@w.ods.org>,
       linux-kernel@vger.kernel.org
Subject: Re: accept()ing socket connections with level triggered epoll
Message-ID: <20060427000520.GA10880@www.t3inc.us>
References: <20060426205557.GA5483@www.t3inc.us> <Pine.LNX.4.64.0604261411460.16727@alien.or.mcafeemobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604261411460.16727@alien.or.mcafeemobile.com>
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 03:14:16PM -0700, Davide Libenzi wrote:
> 
> Correct, if it's LT you have to get the event because before returning from 
> epoll_wait(), the event is automatically re-armed if f_op->poll() returns it. 
> Can you post the *minimal* test code for this case?
> 
> - Davide
> 

I tried reducing the code I have to the minimum necessary to demonstrate the
problem.  It went away, I'm afraid.  Since I'm already aware of a workaround
(call accept in a loop until you get EAGAIN), I guess I'll just forget about
it.  Unfortunately I can't post the full code, not that you'd want to dig
through all of it anyway.

Thanks to everyone that responded.

Kyle
<kyle@pbx.org>
