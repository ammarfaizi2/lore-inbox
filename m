Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbVI0VfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVI0VfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbVI0VfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:35:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:61414 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965156AbVI0VfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:35:07 -0400
Subject: Re: Resource limits
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Al Boldi <a1426z@gawab.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Matthew Helsley <matthltc@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200509270808.21821.a1426z@gawab.com>
References: <200509251712.42302.a1426z@gawab.com>
	 <200509262326.10305.a1426z@gawab.com>
	 <20050927010522.GB4522@localhost.localdomain>
	 <200509270808.21821.a1426z@gawab.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 27 Sep 2005 14:35:00 -0700
Message-Id: <1127856900.4861.26.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 08:08 +0300, Al Boldi wrote:
<snip>
> Consider this dilemma:
> Runaway proc/s hit the limit.
> Try to kill some and you are denied due to the resource limit.
> Use some previously running app like top, hope it hasn't been killed by some 
> OOM situation, try killing some procs and another one takes it's place 
> because of the runaway situation.
> Raise the limit, and it gets filled by the runaways.
> You are pretty much stuck.

CKRM can solve this problem nicely. You can define classes (for example,
you can define a class and it attach to a user). Limits will be applied
only to that class(user), failures will be seen only by that class(user)
and the rest of the system will be free to operate without getting into
the situation stated above.

>  and associate resources to a class 
> You may get around the problem by a user-space solution, but this will always 
> run the risks associated with user-space.
> 
> > > The issue here is a general lack of proper kernel support for resource
> > > limits.  The fork problem is just an example.
> >
> > Thats not really true.  As Mr. Helsley pointed out, CKRM is available
> 
> Matthew Helsley wrote:
> > 	Have you looked at Class-Based Kernel Resource Managment (CKRM)
> > (http://ckrm.sf.net) to see if it fits your needs? My initial thought is
> > that the CKRM numtasks controller may help limit forks in the way you
> > describe.
> 
> Thanks for the link!  CKRM is great!

Thank you!! :)
> 
> Is there a CKRM-lite version?  This would make it easier to be included into 

we are currently working on reducing the codesize and complexity of
CKRM, which will be lot thinner and less complex than what was in -mm
tree a while ago. The development is underway and you can follow the
progress of the f-series in ckrm-tech mailing list. 

> the mainline, something that would concentrate on the pressing issues, like 
> lock-out prevention, and leave all the management features as an option.
> 

You are welcome to join the mailing list and provide feedback on how the
f-series shapes up.

Thanks,

chandra 
> Thanks!
> 
> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


