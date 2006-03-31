Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWCaRCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWCaRCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCaRCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:02:21 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:34520 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751227AbWCaRCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:02:20 -0500
Message-ID: <442D6085.4000800@watson.ibm.com>
Date: Fri, 31 Mar 2006 12:01:57 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, greg@kroah.com,
       arjan@infradead.org, hadi@cyberus.ca, ak@suse.de,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       erikj@sgi.com, jlan@engr.sgi.com, lserinol@gmail.com,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: [Patch 0/8] per-task delay accounting
References: <442B271D.10208@watson.ibm.com>	<20060329210314.3db53aaa.akpm@osdl.org>	<20060330062357.GB18387@in.ibm.com>	<20060329224737.071b9567.akpm@osdl.org>	<442CCF54.3000501@watson.ibm.com> <20060331093152.000d8284@localhost.localdomain>
In-Reply-To: <20060331093152.000d8284@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin wrote:

>On Fri, 31 Mar 2006 01:42:28 -0500
>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
>  
>
>>Following Andrew's suggestion, here's my quick overview
>>of the various other accounting packages that have been
>>proposed on lse-tech with a focus on whether they can
>>utilize the netlink-based taskstats interface being proposed
>>by the delay accounting patches.
>>
>>Please note that unification of statistics *collection* is not
>>being discussed since that kind of merger can be done as these
>>patches get accepted, if at all, into the kernel. To try and
>>unify right away would hold every patch (esp. delay accounting !)
>>hostage to the problems in every other patch unnecessarily. As
>>long as the interface can be unified, the merger of the
>>collection bits can always happen without affecting user space.
>>
>>Stakeholders of each of these patches, on cc, are requested to
>>please correct any misunderstandings of what their patches do.
>>
>>Also, please comment on the observations about their patch's
>>ability to use the netlink-based taskstats interface, code for which
>>was posted at
>>   
>>http://www.uwsg.indiana.edu/hypermail/linux/kernel/0603.3/1787.html
>>
>>    
>>
>[...]
>  
>
>>5. Enhanced Linux System Accounting (Guillaume Thouvenine)
>>    
>>
>                                                 ^^^^^^^^^^
>                                                 Thouvenin
>  
>
>>----------------------------------------------------------   
>>
>>- Group tasks at a user level into "jobs" and aggregate,
>>at user level, per-task statistics collected by CSA and/or BSD
>>process accounting.
>>
>>- ELSA does not introduce any new requirement for either
>>collection or export of statistics from the kernel. It can use
>>either BSD and/or CSA's  method of using an accounting file.
>>
>>- ELSA needs notification of forks and exits which it can already
>>get through the process events connector in the kernel.
>>
>>Hence ELSA's needs are either met by the kernel today or are a
>>strict subset of  CSA (since BSD accounting is already there).
>>    
>>
>
>The overview is very interesting and you have a very good comprehension
>of ELSA. As you said ELSA is a group tasks at a user level and
>everything is already in the kernel so your patches don't generate
>troubles to ELSA. As you said in the delay accounting documentation,
>delay statistics can also be collected for all tasks and a tool like
>ELSA can aggregate results for groups of processes.
>
>
>Chears,
>Guillaume
>  
>
Thanks Guillaume. Thats one "sign-off" on the taskstats interface then :-)

--Shailabh


