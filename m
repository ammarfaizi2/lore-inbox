Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWFHRml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWFHRml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 13:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWFHRml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 13:42:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964923AbWFHRml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 13:42:41 -0400
Date: Thu, 8 Jun 2006 10:42:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: balbir@in.ibm.com, linux-kernel@vger.kernel.org, jlan@engr.sgi.com,
       peterc@gelato.unsw.edu.au
Subject: Re: Merge of per task delay accounting (was Re: 2.6.18 -mm merge
 plans)
Message-Id: <20060608104224.b2fe8c60.akpm@osdl.org>
In-Reply-To: <448833E2.6000608@watson.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<4484D25E.4020805@in.ibm.com>
	<4486017F.8030308@watson.ibm.com>
	<20060606154034.10147da7.akpm@osdl.org>
	<448833E2.6000608@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2006 10:27:46 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> Andrew Morton wrote:
> 
> >On Tue, 06 Jun 2006 18:28:15 -0400
> >Shailabh Nagar <nagar@watson.ibm.com> wrote:
> >
> >  
> >
> >>So, we have a good consensus from existing/potential users of taskstats and would
> >>very much appreciate it being included in 2.6.18.
> >>    
> >>
> >
> >Yes, for 2.6.18 I'm inclined to send taskstats and to continue to play
> >wait-and-see on the statistics infrastructure.  Greg is taking a look at
> >the stats code, which is good.
> >
> >  
> >
> Thanks !
> 
> The suggestion from  Jay Lan to extend the interface by making sending 
> of tgid stats configurable
> is quite reasonable and can be done relatively simply:
> set some parameter, either by sending a separate command (verify sender 
> is privileged) or by
> some sysfs parameter and use that to control sending of tgid stats on 
> task exit (as well as allocation of
> any tgid stat related structures).

hm.  Is it possible to check the privileges of a netlink message sender?

> Would you recommend we submit a patch for it now or wait till after 
> delay accounting has gone into
> 2.6.18 ?

Earlier, please.

> Such requests for extending the interface are likely to happen as more 
> users start using the interface.
> But since any patch will need some testing etc. and we are very close to 
> the 2.6.18 merge window, I
> wanted your advice on whether this should wait until later.

If it's merged, we'll have a couple more months to test it, and to fix any
little problems.

