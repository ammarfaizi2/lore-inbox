Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWHDOvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWHDOvD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWHDOvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:51:03 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:46984 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161248AbWHDOvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:51:01 -0400
Message-ID: <44D35F0B.5000801@sw.ru>
Date: Fri, 04 Aug 2006 18:51:55 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com>
In-Reply-To: <20060804114109.GA28988@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I think the risk is that OpenVZ has all the controls and resource
>>managers we need, while CKRM is still more research-ish. I find the
>>OpenVZ code much clearer, cleaner and complete at the moment, although
>>also much more conservative in its approach to solving problems.
> 
> 
> I think it would be nice to compare first the features provided by ckrm and 
> openvz at some point and agree upon the minimum common features we need to have 
> as we go forward. For instance I think Openvz assumes that tasks do
> not need to move between containers (task-groups), whereas ckrm provides this
> flexibility for workload management. This may have some effect on the 
> controller/interface design, no?
OpenVZ assumes that tasks can't move between task-groups for a single reason:
user shouldn't be able to escape from the container.
But this have no implication on the design/implementation.

BTW, do you see any practical use cases for tasks jumping between resource-containers?

Kirill

