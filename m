Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbUCDOAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUCDOAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:00:17 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:18694 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261912AbUCDN7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:59:55 -0500
Date: Thu, 4 Mar 2004 14:48:09 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Armin Schindler <aml@melware.de>
Cc: Willy Tarreau <willy@w.ods.org>, Armin Schindler <armin@melware.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] sys_select() return error on bad file
Message-ID: <20040304134809.GA482@alpha.home.local>
References: <20040304072225.GA20915@alpha.home.local> <Pine.LNX.4.31.0403041016190.16757-100000@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0403041016190.16757-100000@phoenix.one.melware.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 10:20:41AM +0100, Armin Schindler wrote:
 
> retval cannot be used for that, it may get changed in the loop.

OK

> Anyway, I don't see how your proposal would do better performance?
> My patch just adds a new variable on the stack, which should not make any
> difference in performance. And later, it is the same if the new or another
> variable gets changed or checked.

It is possible that in current code the, compiler is able to allocate a
register for each variable used inside the loop, while it may not be able
anymore with an additionnal variable. But that's just speculation anyway.

Cheers,
Willy
