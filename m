Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWFTFku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWFTFku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWFTFku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:40:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:42211 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965041AbWFTFkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:40:49 -0400
Date: Tue, 20 Jun 2006 11:10:27 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       sam@vilain.net, dev@openvz.org, efault@gmx.de, mingo@elte.hu,
       pwil3058@bigpond.net.au, balbir@in.ibm.com,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp, ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: Resource Management Requirements (was "[RFC] CPU controllers?")
Message-ID: <20060620054027.GA1083@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net> <4494EE86.7090209@yahoo.com.au> <20060617234259.dc34a20c.akpm@osdl.org> <4495009D.9030505@yahoo.com.au> <1150743803.30013.37.camel@linuxchandra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150743803.30013.37.camel@linuxchandra>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 12:03:23PM -0700, Chandra Seetharaman wrote:
> On Sun, 2006-06-18 at 17:28 +1000, Nick Piggin wrote:
> 
> > OK... let me put it more clearly. What are the requirements?

At a very broad-level, all the requirements pointed by Chandra below boil down 
to the requirement of providing guaranteed CPU usage for a group of 
tasks and the ability of limiting (hard or soft) CPU usage of other group of 
tasks.

At a finer-level, this broad requirement could be interpreted and implemented 
in a number of ways (ex: by having kernel support only task-level limit and
implementing group-level in user-space etc) and thats what this RFC was
about - to discuss what minimal kernel support would be needed to
support the above broad requirement!

> Nick,
> 
> Here are some requirements we(Resource Groups aka CKRM) are working
> towards (Note that this is not limited to CPU alone):
> 
> In a enterprise environment:
>  - Ability to group applications into their importance levels and assign
>    appropriate amount of resources to them.
>  - In case of server consolidation, ability to allocate and control
>    resources to a specific group of applications. Ability to 
>    account/charge according to their usages.
>  - manage multiple departments in a single OS instance with ability to
>    allocate and control resources department wise (similar to above
>    requirement :)
>  - ability to guarantee "time to complete" for a specific user
>    request (by controlling resource usage starting from the web server
>    to the database server).
>  - In case of ISPs and ASPs, ability to guarantee/limit usages to 
>    independent clients (in a single OS instance). 
>  - Ability to control runaway processes from bringing down the system 
>    response (DoS attacks, fork bombs etc.,)
>   
> In a university environment (can be treated as a subset of enterprise
> requirements above):
>  - Ability to limit resource consumption at individual user level.
>  - Ability to control runaway processes.
>  - Ability for a user to manage resources allocated to them (as 
>    explained in the desktop environment below). 
> 
> In a desktop environment:
>  - Ability to control resource usage of a set of applications 
>    (ex: infamous updatedb issue).
>  - Ability to run different loads and get the expected result (like 
>    checking emails or browsing Internet while compilation is in 
>    progress) 
> 
> Generic:
> Provide these resource management capabilities with less overhead on
> overall system performance.

-- 
Regards,
vatsa
