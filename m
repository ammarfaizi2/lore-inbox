Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTLUP2h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTLUP2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:28:37 -0500
Received: from mail.shareable.org ([81.29.64.88]:52103 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263463AbTLUP2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:28:36 -0500
Date: Sun, 21 Dec 2003 15:28:22 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, lse-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Message-ID: <20031221152822.GA4871@mail.shareable.org>
References: <3FE594D0.8000807@colorfullife.com> <Pine.LNX.4.44.0312210701330.12172-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312210701330.12172-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> First, f_op->poll() does not allow you to send and event mask, 
> and this requires the driver to indiscriminately wake up both IN and OUT 
> waiters. The second area will be to give the driver to specify some "info" 
> 
> wake_up_info(&wq, XXXX);

I agree totally, both of these are (and always were, isn't it amazing
how long these things take) the way to do it "properly".

> The good thing is that migration can be gradual, beside the initial
> dumb compile fixing to suite the new f_op->poll() interface.

Even that's trivial, if a little time consuming, as it's only a
function signature change.  Actually using the extra argument is
optional for each driver.

-- Jamie
