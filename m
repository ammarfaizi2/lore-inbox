Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbULJUpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbULJUpi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 15:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbULJUpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 15:45:38 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64932 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261157AbULJUpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 15:45:34 -0500
Subject: Re: RCU question
From: Lee Revell <rlrevell@joe-job.com>
To: dipankar@in.ibm.com
Cc: George Anzinger <george@mvista.com>, ganzinger@mvista.com,
       Manfred Spraul <manfred@colorfullife.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041210204003.GC4073@in.ibm.com>
References: <41B8E6F1.4070007@mvista.com> <20041210043102.GC4161@in.ibm.com>
	 <41B9FC3F.50601@mvista.com>  <20041210204003.GC4073@in.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 15:45:31 -0500
Message-Id: <1102711532.29919.35.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-11 at 02:10 +0530, Dipankar Sarma wrote:
> On Fri, Dec 10, 2004 at 11:42:55AM -0800, George Anzinger wrote:
> > Dipankar Sarma wrote:
> > >And yes, RCU processing in softirq context can re-raise the softirq.
> > >AFAICS, it is perfectly normal.
> > 
> > My assumption was that, this being the idle task, RCU would be more than 
> > happy to finish all its pending tasks.
> 
> We try to avoid really long running softirqs (RCU tasklet in this case)
> for better scheduling latency. A long running rcu tasklet during
> an idle cpu may delay running of an RT process that becomes runnable
> during the rcu tasklet.
> 

Well, softirqs should really be preemptible if you care about RT task
latency.  Ingo's patches have had this for months.  Works great.  Maybe
it's time to push it upstream.

Lee

