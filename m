Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbRGOUsI>; Sun, 15 Jul 2001 16:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbRGOUrt>; Sun, 15 Jul 2001 16:47:49 -0400
Received: from sncgw.nai.com ([161.69.248.229]:52205 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267025AbRGOUrm>;
	Sun, 15 Jul 2001 16:47:42 -0400
Message-ID: <XFMail.20010715135110.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <OF0C6F5F92.24F5EA98-ON85256A88.006DDC58@pok.ibm.com>
Date: Sun, 15 Jul 2001 13:51:10 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Shailabh Nagar <nagar@us.ibm.com>
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@suse.de>, lse-tech@lists.sourceforge.net,
        Mike Kravetz <mkravetz@sequent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Jul-2001 Shailabh Nagar wrote:
> That is true to an extent. It would be convenient for us as scheduler
> rewriters to have neatly differentiated classes like UP, SMP, BIG_SMP, NUMA
> etc. But it forces all other scheduler-sensitive code to think of each of
> these cases separately and is exactly the reason why #ifdef's are
> discouraged for critical kernel code like the scheduler.

Personally I hate #ifdef's inside the code more than my cat water, but something
like :

[sched.c]
#ifdef CONFIG_SCHED_XXX
#include "sched_xxx.c"
#else
#ifdef CONFIG_SCHED_YYY
#include "sched_yyy.c"

...

#endif


looks pretty clean to me.




- Davide

