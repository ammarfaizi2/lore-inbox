Return-Path: <linux-kernel-owner+w=401wt.eu-S932826AbXALIXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826AbXALIXV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 03:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932827AbXALIXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 03:23:21 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:53077 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826AbXALIXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 03:23:20 -0500
Message-ID: <45A74557.4020004@in.ibm.com>
Date: Fri, 12 Jan 2007 13:52:47 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: vatsa@in.ibm.com, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, xemul@sw.ru, rohitseth@google.com,
       pj@sgi.com, mbligh@google.com, winget@google.com,
       containers@lists.osdl.org, serue@us.ibm.com, dev@sw.ru,
       devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH 3/6] containers: Add generic multi-subsystem
 API to containers
References: <20061222141442.753211763@menage.corp.google.com> <20061222145216.574346828@menage.corp.google.com> <45A50CA5.6070101@in.ibm.com> <6599ad830701111453t62bec38cl9534263002f48a15@mail.gmail.com> <45A72AE0.9010209@in.ibm.com> <6599ad830701120010u11f24bfdxeb3e8bfbd8bdba40@mail.gmail.com>
In-Reply-To: <6599ad830701120010u11f24bfdxeb3e8bfbd8bdba40@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 1/11/07, Balbir Singh <balbir@in.ibm.com> wrote:
>> to 0. To walk the hierarchy, I have no root now since I do not have
>> any task context. I was wondering if exporting the rootnode or providing
>> a function to export the rootnode of the mounter hierarchy will make
>> programming easier.
> 
> Ah - I misunderstood what you were looking for before.

I'll try and post the changes to cpu_acct once I get the container system
working.

> 
>> Something like
>>
>> struct container *get_root_container(struct container_subsys *ss)
>> {
>>        return &rootnode[ss->hierarchy];
>> }
> 
> Yes, something like that sounds fine - except that it would be
> 
> return &rootnode[ss->hierarchy].top_container;
> 

Aah! I missed the top_container bit. Do you want me to send you a patch for it?
It will be nice to have it in the next version.

> Paul

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
