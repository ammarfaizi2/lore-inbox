Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310346AbSCGOVd>; Thu, 7 Mar 2002 09:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310348AbSCGOVP>; Thu, 7 Mar 2002 09:21:15 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:25878 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S310346AbSCGOU6>; Thu, 7 Mar 2002 09:20:58 -0500
From: "Steven A. DuChene" <linux-clusters@mindspring.com>
Date: Thu, 7 Mar 2002 09:20:12 -0500
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCHED_YIELD undeclared with Trond's NFS patch w/2.4.19-pre2-ac2
Message-ID: <20020307092012.D16224@lapsony.mydomain.here>
In-Reply-To: <20020307084514.C16224@lapsony.mydomain.here> <Pine.LNX.3.95.1020307085809.19727A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
In-Reply-To: <Pine.LNX.3.95.1020307085809.19727A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Mar 07, 2002 at 09:00:59AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 09:00:59AM -0500, Richard B. Johnson wrote:
> You need to change loops that do something like:
> 
>     while(something)
>     {
>         current->policy |= SCHED_YIELD;
>         schedule();
>     }
>     
>     to:
> 
>     while(something)
>         sys_sched_yield();
> 

Thanks Richard! that did the trick
-- 
Steven A. DuChene      linux-clusters@mindspring.com
                      sduchene@mindspring.com

        http://www.mindspring.com/~sduchene/
