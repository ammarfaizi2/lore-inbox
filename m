Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752002AbWCIQGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbWCIQGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbWCIQGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:06:47 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:28393 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751535AbWCIQGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:06:46 -0500
Message-ID: <44105293.2010803@watson.ibm.com>
Date: Thu, 09 Mar 2006 11:06:43 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: hadi@cyberus.ca, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [UPDATED PATCH] Re: [Lse-tech] Re: [Patch 7/7] Generic netlink
 interface (delay	accounting)
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141029060.5785.77.camel@elinux04.optonline.net> <1141045194.5363.12.camel@localhost.localdomain> <4403608E.1050304@watson.ibm.com> <1141652556.5185.64.camel@localhost.localdomain> <440C6AAA.9030301@watson.ibm.com> <1141742282.5171.55.camel@localhost.localdomain> <440F52FF.30908@watson.ibm.com> <20060309143759.GA4653@in.ibm.com>
In-Reply-To: <20060309143759.GA4653@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

<snip>

>Hello, Jamal,
>
>Please find the latest version of the patch for review. The genetlink
>code has been updated as per your review comments. The changelog is provided
>below
>
>1. Eliminated TASKSTATS_CMD_LISTEN and TASKSTATS_CMD_IGNORE
>2. Provide generic functions called genlmsg_data() and genlmsg_len()
>   in linux/net/genetlink.h
>  
>
Balbir,
it might be a good idea to split 2. out separately, since it has generic 
value beyond the
delay accounting patches (just like we did for the timespec_diff_ns change)


Thanks,
Shailabh

>3. Do not multicast all replies, multicast only events generated due
>   to task exit.
>4. The taskstats and taskstats_reply structures are now 64 bit aligned.
>5. Family id is dynamically generated.
>
>Please let us know if we missed something out.
>
>Thanks,
>Balbir
>
>
>Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
>Signed-off-by: Balbir Singh <balbir@in.ibm.com>
>
>---
>
> include/linux/delayacct.h |    2 
> include/linux/taskstats.h |  128 ++++++++++++++++++++++++
> include/net/genetlink.h   |   20 +++
> init/Kconfig              |   16 ++-
> kernel/Makefile           |    1 
> kernel/delayacct.c        |   56 ++++++++++
> kernel/taskstats.c        |  244 ++++++++++++++++++++++++++++++++++++++++++++++
> 7 files changed, 464 insertions(+), 3 deletions(-)
>
>  
>
<snip>

