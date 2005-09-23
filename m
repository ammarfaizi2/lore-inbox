Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVIWU5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVIWU5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVIWU5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:57:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:20097 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751268AbVIWU5e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:57:34 -0400
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050923153158.GA4548@x30.random>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
	 <200509231036.16921.kernel@kolivas.org>
	 <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
	 <20050923153158.GA4548@x30.random>
Content-Type: text/plain
Date: Fri, 23 Sep 2005 15:57:27 -0500
Message-Id: <1127509047.8880.4.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-23 at 17:31 +0200, Andrea Arcangeli wrote:
> Hello,
> 
> Can you try this updated patch? I believe the blk_congestion_wait is
> just wrong there, since there may be just one page being flushed. That
> sounds like a longstanding bug except it normally wouldn't trigger
> because the dirty levels never goes down near zero during heavy writes.

fsx is now stuck in a loop somewhere, using 100% cpu.

> 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.14-rc1/per-task-predictive-write-throttling-3

-- 
David Kleikamp
IBM Linux Technology Center

