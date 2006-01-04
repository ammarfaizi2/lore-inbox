Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWADAnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWADAnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWADAnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:43:00 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:29371 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751497AbWADAm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:42:59 -0500
Message-ID: <43BB19FC.9020905@watson.ibm.com>
Date: Wed, 04 Jan 2006 00:42:36 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [Patch 6/6] Delay accounting: Connector interface
References: <43BB05D8.6070101@watson.ibm.com> <43BB09D4.2060209@watson.ibm.com> <20060104002112.GA18730@kroah.com>
In-Reply-To: <20060104002112.GA18730@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Jan 03, 2006 at 11:33:40PM +0000, Shailabh Nagar wrote:
> 
>>Changes since 11/14/05:
>>
>>- explicit versioning of statistics data returned
>>- new command type for returning per-tgid stats
>>- for cpu running time, use tsk->sched_info.cpu_time (collected by schedstats)
>>
>>First post 11/14/05
>>
>>delayacct-connector.patch
>>
>>Creates a connector interface for getting delay and cpu statistics of tasks
>>during their lifetime and when they exit. The cpu stats are available only if
>>CONFIG_SCHEDSTATS is enabled.
> 
> 
> Why do you use this when we can send typesafe data through netlink
> messages now?  

AFAIK, adding new netlink types was frowned upon which is one of the reasons why
connectors were proposed (besides making it easier to use the netlink interface) ?

> Because of that, I think the whole connector code can be
> deleted :)
> 
> Unless I missed something in the connector code that is not present in
> netlink...
> 
> thanks,
> 
> greg k-h
> 

