Return-Path: <linux-kernel-owner+w=401wt.eu-S1161036AbXALI0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbXALI0r (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 03:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbXALI0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 03:26:47 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:54170 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161036AbXALI0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 03:26:46 -0500
Message-ID: <45A74634.4050600@in.ibm.com>
Date: Fri, 12 Jan 2007 13:56:28 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: vatsa@in.ibm.com, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, xemul@sw.ru, dev@sw.ru,
       containers@lists.osdl.org, pj@sgi.com, mbligh@google.com,
       winget@google.com, rohitseth@google.com, serue@us.ibm.com,
       devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/6] containers: Simple CPU accounting container
 subsystem
References: <20061222141442.753211763@menage.corp.google.com> <20061222145216.755437205@menage.corp.google.com> <45A4F675.3080503@in.ibm.com> <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com> <45A729A9.5070902@in.ibm.com> <6599ad830701120015k440a16c8sec25a4db23865ebd@mail.gmail.com>
In-Reply-To: <6599ad830701120015k440a16c8sec25a4db23865ebd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 1/11/07, Balbir Singh <balbir@in.ibm.com> wrote:
>> I tried something similar, I added an activated field, which is set
>> to true when the ->create() callback is invoked. That did not help
>> either, the machine still panic'ed.
> 
> I think that marking it active when create() is called may be too soon.
> 
> Is this with my unchanged cpuacct subsystem, or with the version that
> you've extended to track load over defined periods? I don't see it
> when I test under VMware (with two processors in the VM), but I
> suspect that's not going to be quite as parallel as a real SMP system.

This is with the unchanged cpuacct subsystem. Ok, so the container
system needs to mark active internally then.

> 
>> I see the need for it, but I wonder if we should start with that
>> right away. I understand that people might want to group cpusets
>> differently from their grouping of let's say the cpu resource
>> manager. I would still prefer to start with one hierarchy and then
>> move to multiple hierarchies. I am concerned that adding complexity
>> upfront might turn off people from using the infrastructure.
> 
> That's what I had originally and people objected to the lack of flexibility :-)
> 
> The presence or absence of multiple hierarchies is pretty much exposed
> to userspace, and presenting the right interface to userspace is a
> fairly important thing to get right from the start.
> 

I understand that the features are exported to userspace. But from
the userspace POV only the mount options change - right?


> Paul
> 

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
