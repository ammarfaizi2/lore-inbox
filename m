Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWCaHcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWCaHcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWCaHcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:32:05 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:55506 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751248AbWCaHcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:32:04 -0500
Date: Fri, 31 Mar 2006 09:31:52 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, greg@kroah.com,
       arjan@infradead.org, hadi@cyberus.ca, ak@suse.de,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       erikj@sgi.com, jlan@engr.sgi.com, lserinol@gmail.com,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: [Patch 0/8] per-task delay accounting
Message-ID: <20060331093152.000d8284@localhost.localdomain>
In-Reply-To: <442CCF54.3000501@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<20060329210314.3db53aaa.akpm@osdl.org>
	<20060330062357.GB18387@in.ibm.com>
	<20060329224737.071b9567.akpm@osdl.org>
	<442CCF54.3000501@watson.ibm.com>
Organization: Bull S.A.
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 31/03/2006 09:34:06,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 31/03/2006 09:34:07,
	Serialize complete at 31/03/2006 09:34:07
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006 01:42:28 -0500
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> Following Andrew's suggestion, here's my quick overview
> of the various other accounting packages that have been
> proposed on lse-tech with a focus on whether they can
> utilize the netlink-based taskstats interface being proposed
> by the delay accounting patches.
> 
> Please note that unification of statistics *collection* is not
> being discussed since that kind of merger can be done as these
> patches get accepted, if at all, into the kernel. To try and
> unify right away would hold every patch (esp. delay accounting !)
> hostage to the problems in every other patch unnecessarily. As
> long as the interface can be unified, the merger of the
> collection bits can always happen without affecting user space.
> 
> Stakeholders of each of these patches, on cc, are requested to
> please correct any misunderstandings of what their patches do.
> 
> Also, please comment on the observations about their patch's
> ability to use the netlink-based taskstats interface, code for which
> was posted at
>    
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0603.3/1787.html
> 
[...]
> 
> 5. Enhanced Linux System Accounting (Guillaume Thouvenine)
                                                 ^^^^^^^^^^
                                                 Thouvenin
> ----------------------------------------------------------   
> 
> - Group tasks at a user level into "jobs" and aggregate,
> at user level, per-task statistics collected by CSA and/or BSD
> process accounting.
> 
> - ELSA does not introduce any new requirement for either
> collection or export of statistics from the kernel. It can use
> either BSD and/or CSA's  method of using an accounting file.
> 
> - ELSA needs notification of forks and exits which it can already
> get through the process events connector in the kernel.
> 
> Hence ELSA's needs are either met by the kernel today or are a
> strict subset of  CSA (since BSD accounting is already there).

The overview is very interesting and you have a very good comprehension
of ELSA. As you said ELSA is a group tasks at a user level and
everything is already in the kernel so your patches don't generate
troubles to ELSA. As you said in the delay accounting documentation,
delay statistics can also be collected for all tasks and a tool like
ELSA can aggregate results for groups of processes.


Chears,
Guillaume



