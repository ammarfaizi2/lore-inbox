Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVIWU7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVIWU7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVIWU7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:59:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:11489 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751288AbVIWU7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:59:17 -0400
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1127509047.8880.4.camel@kleikamp.austin.ibm.com>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
	 <200509231036.16921.kernel@kolivas.org>
	 <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
	 <20050923153158.GA4548@x30.random>
	 <1127509047.8880.4.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 23 Sep 2005 15:59:15 -0500
Message-Id: <1127509155.8875.6.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-23 at 15:57 -0500, Dave Kleikamp wrote:
> On Fri, 2005-09-23 at 17:31 +0200, Andrea Arcangeli wrote:
> > Hello,
> > 
> > Can you try this updated patch? I believe the blk_congestion_wait is
> > just wrong there, since there may be just one page being flushed. That
> > sounds like a longstanding bug except it normally wouldn't trigger
> > because the dirty levels never goes down near zero during heavy writes.
> 
> fsx is now stuck in a loop somewhere, using 100% cpu.

I hit send a little early.  It eventually responded to a ^C.  I'll try
to get some more info.

-- 
David Kleikamp
IBM Linux Technology Center

