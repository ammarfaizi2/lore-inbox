Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRCXSPN>; Sat, 24 Mar 2001 13:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131743AbRCXSPE>; Sat, 24 Mar 2001 13:15:04 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:26596 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131742AbRCXSOs>; Sat, 24 Mar 2001 13:14:48 -0500
Message-ID: <3ABCE547.DD5E78B9@redhat.com>
Date: Sat, 24 Mar 2001 13:19:51 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.33.0103241039590.2310-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Sat, 24 Mar 2001, Doug Ledford wrote:
> > To those people that would suggest I send in code I only have this to say.
> > Fine, I'll send in a patch to fix this bug.  It will make the oom killer call
> > the cache reclaim functions and never kill anything.  That would at least fix
> > the bug you see above.
> 
> That won't fix the problem, but merely paper it over.  The problem is
> in the balancing code that lets swap be exausted while at the same time
> allowing cache to become obscenely obese in the first place.  I can't
> trigger that behavior here, but it obviously exists for some workloads.

I would be more than happy to fix the problem properly if I knew the first
thing about the vm subsystem, but I don't.

> General thread comment:
> To those who are griping, and obviously rightfully so, Rik has twice
> stated on this list that he could use some help with VM auto-balancing.
> The responses (visible on this list at least) was rather underwhelming.
> I noted no public exchange of ideas.. nada in fact.

While my post didn't give an exact formula, I was quite clear on the fact that
the system is allowing the caches to overrun memory and cause oom problems. 
I'm more than happy to test patches, and I would even be willing to suggest
some algorithms that might help, but I don't know where to stick them in the
code.  Most of the people who have been griping are in a similar position.

> Get off your lazy butts and do something about it.  Don't work on the
> oom-killer though.. that's only a symptom.  Work on the problem instead.
> 
>         -Mike  (who doesn't give a rats ass if he gets flamed;-)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
