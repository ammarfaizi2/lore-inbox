Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTERWWI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTERWWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:22:08 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:10631 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S262231AbTERWWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:22:07 -0400
Subject: Re: recursive spinlocks. Shoot.
From: David Woodhouse <dwmw2@infradead.org>
To: ptb@it.uc3m.es
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
References: <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
Content-Type: text/plain
Organization: 
Message-Id: <1053297297.28446.18.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sun, 18 May 2003 23:34:58 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: ptb@it.uc3m.es, wli@holomorphy.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-18 at 18:24, Peter T. Breuer wrote:
> The second method is used by programmers who aren't aware that some
> obscure subroutine takes a spinlock, and who recklessly take a lock
> before calling a subroutine (the very thought sends shivers down my
> spine ...).  A popular scenario involves not /knowing/ that your routine
> is called by the kernel with some obscure lock already held, and then
> calling a subroutine that calls the same obscure lock.  The request
> function is one example, but that's hardly obscure (and in 2.5 the 
> situation has eased there!).

To be honest, if any programmer is capable of committing this error and
not finding and fixing it for themselves, then they're also capable, and
arguably _likely_, to introduce subtle lock ordering discrepancies which
will cause deadlock once in a blue moon.

I don't _want_ you to make life easier for this hypothetical programmer.

I want them to either learn to comprehend locking _properly_, or take up
gardening instead.

-- 
dwmw2


