Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132507AbRC1Dg4>; Tue, 27 Mar 2001 22:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132527AbRC1Dgq>; Tue, 27 Mar 2001 22:36:46 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:59440 "EHLO devserv.devel.redhat.com") by vger.kernel.org with ESMTP id <S132507AbRC1Dgf>; Tue, 27 Mar 2001 22:36:35 -0500
Message-ID: <3AC15D6D.16E60291@redhat.com>
Date: Tue, 27 Mar 2001 22:41:33 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: james <jdickens@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Ideas for the oom problem
References: <Pine.LNX.4.21.0103280020110.8261-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 27 Mar 2001, Doug Ledford wrote:
> 
> > I've been using our internal tree for my testing, and I'm reluctant to
> > let my experiences there cause me to draw conclusions about other
> > trees.  So, will you please tell me which version of the kernel you
> > think has a vm that only triggers the oom killer in emergency
> > situations so I can test it here to see if you are right?
> 
> Detecting WHEN we're OOM is quite unrelated from chosing WHAT
> to do when we're OOM.
> 
> There is currently no kernel that I'm aware of which does the
> OOM kill at the "exact right" moment.

I'm not looking for "exact right".  I'm looking for "in the ballpark".  Hell,
I'm not even that picky.  "In the right country" will do for me.  But right
now, what I'm seeing, is a vm that will trigger the oom_killer with 900Mb of a
1GB machine used for nothing but disk cache.

Now, I wouldn't bring this up as a big issue except I keep seeing people say
things like "why so complex a solution for something that is only used in
emergency situations".  My point is that it *IS NOT* being using only in
emergency situations and that is what needs fixed.  Now, I'm willing to allow
that our internal kernel may trigger an oom at different times than the kernel
you use.  That's why I asked what kernel you want me to test in order to
establish whether or not I'm right about how far off the oom_killer trigger
really is.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
