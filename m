Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVFPAYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVFPAYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 20:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVFPAYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 20:24:05 -0400
Received: from one.firstfloor.org ([213.235.205.2]:34793 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261677AbVFPAYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 20:24:00 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: cndougla@purdue.edu, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: TCP prequeue performance
References: <BED5FA3B.2A0%cndougla@purdue.edu> <m1br679otj.fsf@muc.de>
	<20050615.164115.74747690.davem@davemloft.net>
From: Andi Kleen <ak@muc.de>
Date: Thu, 16 Jun 2005 02:23:59 +0200
In-Reply-To: <20050615.164115.74747690.davem@davemloft.net> (David S.
 Miller's message of "Wed, 15 Jun 2005 16:41:15 -0700 (PDT)")
Message-ID: <m17jgv9mjk.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:
>
> Not true, if this check does not pass, tp->ucopy.task is
> never set, therefore prequeue processing is never performed.

Oh well, here goes my nice theory :)
>
> This test must pass the first time, when both tp->ucopy.task
> and user_recv are both NULL, in order for prequeue processing
> to occur at all.
>
> So his change did totally disable prequeue.

Then probably his test was latency bound somehow, but normally
that should not affect system time, just wall time.

I would perhaps compare context switch numbers and netstat -s
output between the different runs and see if anything pops out.

-Andi
