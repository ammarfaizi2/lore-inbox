Return-Path: <linux-kernel-owner+w=401wt.eu-S932169AbXAOKME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbXAOKME (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 05:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbXAOKME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 05:12:04 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:41218 "EHLO
	ausmtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169AbXAOKMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 05:12:02 -0500
Message-ID: <45AB531D.8050909@in.ibm.com>
Date: Mon, 15 Jan 2007 15:40:37 +0530
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
Subject: Re: [ckrm-tech] [PATCH 1/1] Fix a panic while mouting containers
 on powerpc and some other small cleanups (Re: [PATCH 4/6] containers: Simple
 CPU accounting container subsystem)
References: <20061222141442.753211763@menage.corp.google.com> <20061222145216.755437205@menage.corp.google.com> <45A4F675.3080503@in.ibm.com> <6599ad830701111633j2ae65807sad393d2dad44a260@mail.gmail.com> <45AB42E6.4020507@in.ibm.com> <45AB43B5.3070007@in.ibm.com> <6599ad830701150122g7156a599t1b3dd3af9f5f821b@mail.gmail.com> <45AB4EA0.3030704@in.ibm.com> <6599ad830701150201i2b1cd11dk61ab8cef611c84d6@mail.gmail.com>
In-Reply-To: <6599ad830701150201i2b1cd11dk61ab8cef611c84d6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 1/15/07, Balbir Singh <balbir@in.ibm.com> wrote:
>> While writing/extending the cpuacct container, I found it useful to
>> know if the container resource group we are controlling is really mounted.
>> Controllers can try and avoid doing work when not mounted and start
>> when the subsystem is mounted. Also, without these callbacks, one has no
>> definite way of checking if the top_container is dummy or for real.
>>
> 
> That's somewhat intentional - my aim was that the controllers
> shouldn't really care whether they're connected to the default
> hierarchy or have been bound to some mounted hierarchy. Having said
> thay, they can determine it by checking <foo>_subsys.hierarchy if they
> really want to. If that's 0 then they're in the default hierarchy (and
> can assume that all tasks are in one top-level container).
> 

That makes sense, the only additional thing required is to know when
the subsystem really got mounted (we cannot keep polling hierarchy
for it:-))

> Paul


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
