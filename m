Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWILJ6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWILJ6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWILJ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:58:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42713 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965187AbWILJ6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:58:37 -0400
Message-ID: <450683A2.50508@in.ibm.com>
Date: Tue, 12 Sep 2006 15:23:38 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: rohitseth@google.com
Cc: sekharan@us.ibm.com, Rik van Riel <riel@redhat.com>,
       Srivatsa <vatsa@in.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters	(v4)	(added	user
 memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>	<44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>	<1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>	<1157743424.19884.65.camel@linuxchandra>	<1157751834.1214.112.camel@galaxy.corp.google.com>	<1157999107.6029.7.camel@linuxchandra>	<1158001831.12947.16.camel@galaxy.corp.google.com>	<1158003725.6029.60.camel@linuxchandra> <1158019099.12947.102.camel@galaxy.corp.google.com>
In-Reply-To: <1158019099.12947.102.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:

> If the limits are set appropriately so that containers total memory
> consumption does not exceed the system memory then there shouldn't be
> any QoS issue (to whatever extent it is applicable for specific
> scenario).
> 
> -rohit
> 

What if the guarantee and limits are subject to change? Consider many groups,
with changing limits - how do we provide guarantees then?

Limit is the upper bound on resource utilization and guarantee is the lower
bound. In a dynamic system, how can we provide a lower bound on a resource
for a group by manipulating the upper bounds on the rest of the groups?

Consider a system with 1GB of ram and two groups such that they need a guarantee
of 100MB and 200MB of memory. How would you setup limits to ensure that
the guarantees are met? The remaining groups will be limited to 700MB, but
how do we ensure that these classes get 100MB and 200MB of the remaining 300MB
respectively?

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
